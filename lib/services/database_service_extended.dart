import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../database/database.dart';
import '../models/block.dart' as models;
import '../models/link.dart' as models;
import '../models/tag.dart' as models;
import 'database_service.dart';
import '../models/note.dart' as models;

extension DatabaseServiceExtended on DatabaseService {
  // Block-related service methods
  Future<List<models.Block>> getBlocksByNoteId(String noteId) async {
    final blocks = await _database.getBlocksByNoteId(noteId);
    return blocks.map((block) => models.Block(
      id: block.id,
      noteId: block.noteId,
      content: block.content,
      createdAt: block.createdAt,
      updatedAt: block.updatedAt,
      syncStatus: block.syncStatus,
    )).toList();
  }

  Future<models.Block?> getBlockById(String id) async {
    final block = await _database.getBlockById(id);
    if (block == null) return null;
    
    return models.Block(
      id: block.id,
      noteId: block.noteId,
      content: block.content,
      createdAt: block.createdAt,
      updatedAt: block.updatedAt,
      syncStatus: block.syncStatus,
    );
  }

  Future<String> createBlock({
    required String noteId,
    required String content,
    String? id,
  }) async {
    final blockId = id ?? _uuid.v4();
    final block = BlocksCompanion.insert(
      id: blockId,
      noteId: noteId,
      content: content,
    );
    
    await _database.insertBlock(block);
    
    // Update full-text search index
    await _database.updateBlocksFts(blockId, content);
    
    // Update note's blockIds
    await _updateNoteBlockIds(noteId, blockId, true);
    
    return blockId;
  }

  Future<bool> updateBlock({
    required String id,
    String? content,
    String? syncStatus,
  }) async {
    final block = BlocksCompanion(
      id: Value(id),
      content: content != null ? Value(content) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
      syncStatus: syncStatus != null ? Value(syncStatus) : const Value.absent(),
    );
    
    final success = await _database.updateBlock(block);
    
    // If content is updated, update full-text search index
    if (success && content != null) {
      await _database.updateBlocksFts(id, content);
    }
    
    return success;
  }

  Future<bool> deleteBlock(String id) async {
    // Get block info to update note's blockIds
    final block = await _database.getBlockById(id);
    if (block != null) {
      await _updateNoteBlockIds(block.noteId, id, false);
    }
    
    final deletedCount = await _database.deleteBlock(id);
    
    // Delete from full-text search index
    await _database.deleteFromBlocksFts(id);
    
    return deletedCount > 0;
  }

  // Tag-related service methods
  Future<List<models.Tag>> getAllTags() async {
    final tags = await _database.getAllTags();
    return tags.map((tag) => models.Tag(
      id: tag.id,
      name: tag.name,
    )).toList();
  }

  Future<models.Tag?> getTagByName(String name) async {
    final tag = await _database.getTagByName(name);
    if (tag == null) return null;
    
    return models.Tag(
      id: tag.id,
      name: tag.name,
    );
  }

  Future<String> createTag({
    required String name,
    String? id,
  }) async {
    final tagId = id ?? _uuid.v4();
    final tag = TagsCompanion.insert(
      id: tagId,
      name: name,
    );
    
    await _database.insertTag(tag);
    return tagId;
  }

  Future<List<models.Tag>> getTagsByNoteId(String noteId) async {
    final tags = await _database.getTagsByNoteId(noteId);
    return tags.map((tag) => models.Tag(
      id: tag.id,
      name: tag.name,
    )).toList();
  }

  Future<bool> addTagToNote(String noteId, String tagId) async {
    try {
      await _database.addTagToNote(noteId, tagId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeTagFromNote(String noteId, String tagId) async {
    final deletedCount = await _database.removeTagFromNote(noteId, tagId);
    return deletedCount > 0;
  }

  // Full-text search service methods
  Future<List<Map<String, dynamic>>> searchBlocks(String query) async {
    return await _database.searchBlocks(query);
  }

  Future<List<Map<String, dynamic>>> searchNotes(String query) async {
    return await _database.searchNotes(query);
  }

  // Private helper methods
  Future<void> _updateNoteBlockIds(String noteId, String blockId, bool add) async {
    final note = await _database.getNoteById(noteId);
    if (note == null) return;
    
    List<String> blockIds;
    try {
      blockIds = List<String>.from(jsonDecode(note.blockIds));
    } catch (e) {
      blockIds = [];
    }
    
    if (add && !blockIds.contains(blockId)) {
      blockIds.add(blockId);
    } else if (!add && blockIds.contains(blockId)) {
      blockIds.remove(blockId);
    }
    
    await updateNote(
      id: noteId,
      blockIds: jsonEncode(blockIds),
    );
  }

  /// Complete note update process
  /// 1. Update note table
  /// 2. Update note_fts table
  /// 3. Calculate blocks using diff algorithm
  /// 4. Save to blocks table
  /// 5. Update note table blockids (with order)
  /// 6. Update block_fts table
  Future<bool> updateNoteWithBlocks({
    required String noteId,
    required String newContent,
    String? title,
    required List<Map<String, dynamic>> oldBlocks,
  }) async {
    try {
      // 1. Update note table
      final noteUpdateSuccess = await updateNote(
        id: noteId,
        title: title,
        syncStatus: 'pending',
      );
      
      if (!noteUpdateSuccess) {
        throw Exception('Failed to update note');
      }

      // 2. Update note_fts table
      await _database.updateNoteFts(noteId, newContent);

      // 3. Calculate blocks using diff algorithm
      final diffResult = await _calculateBlocksFromDiff(oldBlocks, newContent);
      
      // 4. Save to blocks table
      final blockIds = await _saveBlocksFromDiff(noteId, diffResult);
      
      // 5. Update note table blockids (with order)
      final blockIdsJson = jsonEncode(blockIds);
      final finalNoteUpdateSuccess = await updateNote(
        id: noteId,
        blockIds: blockIdsJson,
      );
      
      if (!finalNoteUpdateSuccess) {
        throw Exception('Failed to update note blockIds');
      }

      return true;
    } catch (e) {
      print('Error updating note with blocks: $e');
      return false;
    }
  }

  /// Calculate blocks changes using diff algorithm
  Future<Map<String, dynamic>> _calculateBlocksFromDiff(
    List<Map<String, dynamic>> oldBlocks,
    String newContent,
  ) async {
    try {
      // Call ClojureDart diff tool
      // Note: This needs to call ClojureDart code through some method
      // In actual projects, may need to use FFI or other integration methods
      
      // Convert Dart blocks to ClojureDart usable format
      final dartBlocks = oldBlocks.map((block) => {
        'blockId': block['id'] as String,
        'content': block['content'] as String,
      }).toList();
      
      // Call ClojureDart diff tool
      // This needs actual integration code
      final diffResult = await _callClojureDiff(dartBlocks, newContent);
      
      return diffResult;
    } catch (e) {
      print('Error calling ClojureDart diff: $e');
      // Fallback to simple implementation
      return _fallbackDiffCalculation(oldBlocks, newContent);
    }
  }

  /// Call ClojureDart diff tool
  Future<Map<String, dynamic>> _callClojureDiff(
    List<Map<String, dynamic>> dartBlocks,
    String newText,
  ) async {
    // This needs actual ClojureDart call
    // May need to use FFI or other methods
    // Temporarily return empty result, needs integration in actual implementation
    return {
      'added': <Map<String, dynamic>>[],
      'modified': <Map<String, dynamic>>[],
      'unchanged': <Map<String, dynamic>>[],
      'deleted': <List<Map<String, dynamic>>>[],
    };
  }

  /// Fallback diff calculation implementation
  Map<String, dynamic> _fallbackDiffCalculation(
    List<Map<String, dynamic>> oldBlocks,
    String newContent,
  ) {
    final oldText = oldBlocks.map((block) => block['content'] as String).join('\n');
    final newChunks = newContent.split('\n')
        .where((chunk) => chunk.trim().isNotEmpty)
        .toList();
    
    final result = <String, dynamic>{
      'added': <Map<String, dynamic>>[],
      'modified': <Map<String, dynamic>>[],
      'unchanged': <Map<String, dynamic>>[],
      'deleted': <List<Map<String, dynamic>>>[],
    };
    
    final oldBlockMap = <String, Map<String, dynamic>>{};
    for (final block in oldBlocks) {
      oldBlockMap[block['id'] as String] = block;
    }
    
    final newBlockIds = <String>[];
    
    for (int i = 0; i < newChunks.length; i++) {
      final chunk = newChunks[i];
      final existingBlock = oldBlockMap.values
          .where((block) => block['content'] == chunk)
          .firstOrNull;
      
      if (existingBlock != null) {
        newBlockIds.add(existingBlock['id'] as String);
        result['unchanged'].add(existingBlock);
        oldBlockMap.remove(existingBlock['id']);
      } else {
        final newBlockId = const Uuid().v4();
        final newBlock = {
          'id': newBlockId,
          'content': chunk,
        };
        newBlockIds.add(newBlockId);
        result['added'].add(newBlock);
      }
    }
    
    result['deleted'] = oldBlockMap.values.toList();
    
    return result;
  }

  /// Save diff result to blocks table
  Future<List<String>> _saveBlocksFromDiff(
    String noteId,
    Map<String, dynamic> diffResult,
  ) async {
    final blockIds = <String>[];
    
    // Handle unchanged blocks
    for (final block in diffResult['unchanged'] as List<Map<String, dynamic>>) {
      blockIds.add(block['id'] as String);
    }
    
    // Handle added blocks
    for (final block in diffResult['added'] as List<Map<String, dynamic>>) {
      final blockId = await createBlock(
        noteId: noteId,
        content: block['content'] as String,
        id: block['id'] as String,
      );
      blockIds.add(blockId);
    }
    
    // Handle modified blocks
    for (final block in diffResult['modified'] as List<Map<String, dynamic>>) {
      final success = await updateBlock(
        id: block['id'] as String,
        content: block['content'] as String,
      );
      if (success) {
        blockIds.add(block['id'] as String);
      }
    }
    
    return blockIds;
  }

  /// Batch update blocks full-text search index
  Future<void> updateBlocksFtsBatch(List<String> blockIds) async {
    for (final blockId in blockIds) {
      final block = await getBlockById(blockId);
      if (block != null) {
        await _database.updateBlocksFts(blockId, block.content);
      }
    }
  }

  /// Get complete note information (including blocks)
  Future<Map<String, dynamic>> getNoteWithBlocks(String noteId) async {
    final note = await getNoteById(noteId);
    if (note == null) return {};
    
    final blocks = await getBlocksByNoteId(noteId);
    final tags = await getTagsByNoteId(noteId);
    
    return {
      'note': note,
      'blocks': blocks,
      'tags': tags,
    };
  }

  /// Create new note and initialize blocks
  Future<String> createNoteWithBlocks({
    required String title,
    required String content,
    String? id,
  }) async {
    final noteId = id ?? const Uuid().v4();
    
    // 1. Create note
    await createNote(
      title: title,
      id: noteId,
    );
    
    // 2. Update note_fts table
    await _database.updateNoteFts(noteId, content);
    
    // 3. Create blocks
    final chunks = content.split('\n')
        .where((chunk) => chunk.trim().isNotEmpty)
        .toList();
    
    final blockIds = <String>[];
    for (final chunk in chunks) {
      final blockId = await createBlock(
        noteId: noteId,
        content: chunk,
      );
      blockIds.add(blockId);
    }
    
    // 4. Update note blockIds
    await updateNote(
      id: noteId,
      blockIds: jsonEncode(blockIds),
    );
    
    return noteId;
  }
} 