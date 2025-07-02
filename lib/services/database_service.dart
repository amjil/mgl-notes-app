import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import '../models/block.dart';
import '../models/tag.dart';
import '../models/daily_stats.dart';

/// Database service class
/// Provides all database operations for the notes application
class DatabaseService {
  // ==================== Constants ====================
  static const String _databaseName = 'notes_app.db';
  static const int _maxPreviewLength = 200;
  static const String _blockIdPrefix = 'block-';
  
  // ==================== Private fields ====================
  static Isar? _isar;
  static final Uuid _uuid = Uuid();

  // ==================== Database initialization ====================
  
  /// Initialize database
  static Future<void> initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [NoteSchema, BlockSchema, TagSchema, DailyStatsSchema],
      directory: dir.path,
      name: _databaseName,
    );
  }

  /// Get database instance
  static Isar get isar {
    if (_isar == null) {
      throw Exception('Database not initialized. Call initDatabase() first.');
    }
    return _isar!;
  }

  /// Close database
  static Future<void> closeDatabase() async {
    await _isar?.close();
    _isar = null;
  }

  // ==================== Note operations ====================
  
  /// Create new note
  static Future<Note> createNote({
    required String title,
    List<String>? tags,
    DateTime? scheduledDate,
  }) async {
    final note = Note(
      title: title,
      blockIds: [],
      tags: tags ?? [],
      scheduledDate: scheduledDate,
    );

    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });

    return note;
  }

  /// Get note by ID
  static Future<Note?> getNote(int id) async {
    return await isar.txn(() async {
      return await isar.notes.get(id);
    });
  }

  /// Update note
  static Future<void> updateNote(Note note) async {
    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });
  }

  /// Delete note
  static Future<void> deleteNote(int id) async {
    await isar.writeTxn(() async {
      await isar.notes.delete(id);
    });
  }

  /// Get all notes
  static Future<List<Note>> getAllNotes() async {
    return await isar.txn(() async {
      return await isar.notes
          .where()
          .isDeletedEqualTo(false)
          .sortByUpdatedAtDesc()
          .findAll();
    });
  }

  /// Get all notes with pagination
  static Future<Map<String, dynamic>> getAllNotesPaginated({
    int page = 1,
    int pageSize = 20,
  }) async {
    final offset = (page - 1) * pageSize;
    
    return await isar.txn(() async {
      final totalCount = await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .count();
      
      final notes = await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .sortByUpdatedAtDesc()
          .offset(offset)
          .limit(pageSize)
          .findAll();
      
      return {
        'notes': notes,
        'totalCount': totalCount,
        'page': page,
        'pageSize': pageSize,
        'totalPages': (totalCount / pageSize).ceil(),
        'hasNext': page * pageSize < totalCount,
        'hasPrevious': page > 1,
      };
    });
  }

  /// Get notes by date
  static Future<List<Note>> getNotesByDate(DateTime date) async {
    final startDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return await isar.txn(() async {
      return await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .createdAtBetween(startDate, endDate)
          .sortByCreatedAtDesc()
          .findAll();
    });
  }

  /// Get notes by date with pagination
  static Future<Map<String, dynamic>> getNotesByDatePaginated(
    DateTime date, {
    int page = 1,
    int pageSize = 20,
  }) async {
    final startDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);
    final offset = (page - 1) * pageSize;

    return await isar.txn(() async {
      final totalCount = await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .createdAtBetween(startDate, endDate)
          .count();
      
      final notes = await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .createdAtBetween(startDate, endDate)
          .sortByCreatedAtDesc()
          .offset(offset)
          .limit(pageSize)
          .findAll();
      
      return {
        'notes': notes,
        'totalCount': totalCount,
        'page': page,
        'pageSize': pageSize,
        'totalPages': (totalCount / pageSize).ceil(),
        'hasNext': page * pageSize < totalCount,
        'hasPrevious': page > 1,
      };
    });
  }

  /// Search notes
  static Future<List<Note>> searchNotes(String query) async {
    return await isar.txn(() async {
      return await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .titleContains(query)
          .sortByUpdatedAtDesc()
          .findAll();
    });
  }

  /// Search notes with pagination
  static Future<Map<String, dynamic>> searchNotesPaginated(
    String query, {
    int page = 1,
    int pageSize = 20,
  }) async {
    final offset = (page - 1) * pageSize;

    return await isar.txn(() async {
      final totalCount = await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .titleContains(query)
          .count();
      
      final notes = await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .titleContains(query)
          .sortByUpdatedAtDesc()
          .offset(offset)
          .limit(pageSize)
          .findAll();
      
      return {
        'notes': notes,
        'totalCount': totalCount,
        'page': page,
        'pageSize': pageSize,
        'totalPages': (totalCount / pageSize).ceil(),
        'hasNext': page * pageSize < totalCount,
        'hasPrevious': page > 1,
      };
    });
  }

  /// Get notes by tag
  static Future<List<Note>> getNotesByTag(String tagName) async {
    return await isar.txn(() async {
      return await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .tagsElementEqualTo(tagName)
          .sortByUpdatedAtDesc()
          .findAll();
    });
  }

  /// Get notes by tag with pagination
  static Future<Map<String, dynamic>> getNotesByTagPaginated(
    String tagName, {
    int page = 1,
    int pageSize = 20,
  }) async {
    final offset = (page - 1) * pageSize;

    return await isar.txn(() async {
      final totalCount = await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .tagsElementEqualTo(tagName)
          .count();
      
      final notes = await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .tagsElementEqualTo(tagName)
          .sortByUpdatedAtDesc()
          .offset(offset)
          .limit(pageSize)
          .findAll();
      
      return {
        'notes': notes,
        'totalCount': totalCount,
        'page': page,
        'pageSize': pageSize,
        'totalPages': (totalCount / pageSize).ceil(),
        'hasNext': page * pageSize < totalCount,
        'hasPrevious': page > 1,
      };
    });
  }

  // ==================== Block operations ====================
  
  /// Create new block
  static Future<Block> createBlock({
    required String blockId,
    required int noteId,
    required String content,
    List<String>? tags,
  }) async {
    final block = Block(
      blockId: blockId,
      noteId: noteId,
      content: content,
      tags: tags ?? [],
    );

    await isar.writeTxn(() async {
      await isar.blocks.put(block);
      await _updateNotePreviewIfFirstBlock(noteId, block);
    });

    return block;
  }

  /// Get block by block ID
  static Future<Block?> getBlock(String blockId) async {
    return await isar.txn(() async {
      return await isar.blocks
          .filter()
          .blockIdEqualTo(blockId)
          .isDeletedEqualTo(false)
          .findFirst();
    });
  }

  /// Get block by database ID
  static Future<Block?> getBlockById(int id) async {
    return await isar.txn(() async {
      return await isar.blocks.get(id);
    });
  }

  /// Get all blocks by note ID
  static Future<List<Block>> getBlocksByNote(int noteId) async {
    return await isar.txn(() async {
      return await isar.blocks
          .filter()
          .noteIdEqualTo(noteId)
          .isDeletedEqualTo(false)
          .findAll();
    });
  }

  /// Get blocks by ID list
  static Future<List<Block>> getBlocksByIds(List<int> blockIds) async {
    return await isar.txn(() async {
      final blocks = <Block>[];
      for (final id in blockIds) {
        final block = await isar.blocks
            .filter()
            .idEqualTo(id)
            .isDeletedEqualTo(false)
            .findFirst();
        if (block != null) {
          blocks.add(block);
        }
      }
      return blocks;
    });
  }

  /// Update block
  static Future<void> updateBlock(Block block) async {
    await isar.writeTxn(() async {
      await isar.blocks.put(block);
      await _updateNotePreviewIfFirstBlock(block.noteId, block);
    });
  }

  /// Delete block
  static Future<void> deleteBlock(int id) async {
    await isar.writeTxn(() async {
      final block = await isar.blocks.get(id);
      if (block != null) {
        final noteId = block.noteId;
        await isar.blocks.delete(id);
        await _updateNotePreviewIfFirstBlock(noteId, block);
      }
    });
  }

  /// Search blocks
  static Future<List<Block>> searchBlocks(String query) async {
    return await isar.txn(() async {
      return await isar.blocks
          .filter()
          .isDeletedEqualTo(false)
          .contentContains(query)
          .findAll();
    });
  }

  /// Get blocks by tag
  static Future<List<Block>> getBlocksByTag(String tagName) async {
    return await isar.txn(() async {
      return await isar.blocks
          .filter()
          .isDeletedEqualTo(false)
          .tagsElementEqualTo(tagName)
          .findAll();
    });
  }

  /// Get the first block of a note
  static Future<Block?> getFirstBlockOfNote(int noteId) async {
    return await isar.txn(() async {
      final note = await isar.notes.get(noteId);
      if (note == null || note.blockIds.isEmpty) {
        return null;
      }
      
      final firstBlockId = note.blockIds.first;
      return await isar.blocks
          .filter()
          .idEqualTo(firstBlockId)
          .isDeletedEqualTo(false)
          .findFirst();
    });
  }

  // ==================== Tag operations ====================
  
  /// Create new tag
  static Future<Tag> createTag({required String name}) async {
    final tag = Tag(name: name);

    await isar.writeTxn(() async {
      await isar.tags.put(tag);
    });

    return tag;
  }

  /// Get tag by name
  static Future<Tag?> getTag(String name) async {
    return await isar.txn(() async {
      return await isar.tags
          .filter()
          .nameEqualTo(name)
          .findFirst();
    });
  }

  /// Get all tags
  static Future<List<Tag>> getAllTags() async {
    return await isar.txn(() async {
      return await isar.tags
          .where()
          .sortByUsageCountDesc()
          .findAll();
    });
  }

  /// Update tag
  static Future<void> updateTag(Tag tag) async {
    await isar.writeTxn(() async {
      await isar.tags.put(tag);
    });
  }

  /// Delete tag
  static Future<void> deleteTag(int id) async {
    await isar.writeTxn(() async {
      await isar.tags.delete(id);
    });
  }

  /// Increment tag usage count
  static Future<void> incrementTagUsage(String tagName) async {
    await isar.writeTxn(() async {
      var tag = await isar.tags
          .filter()
          .nameEqualTo(tagName)
          .findFirst();
      
      if (tag == null) {
        tag = Tag(name: tagName);
      }
      
      tag.incrementUsage();
      await isar.tags.put(tag);
    });
  }

  /// Decrement tag usage count
  static Future<void> decrementTagUsage(String tagName) async {
    await isar.writeTxn(() async {
      final tag = await isar.tags
          .filter()
          .nameEqualTo(tagName)
          .findFirst();
      
      if (tag != null) {
        tag.decrementUsage();
        await isar.tags.put(tag);
      }
    });
  }

  // ==================== Link operations ====================
  
  /// Add link to block
  static Future<void> addLinkToBlock(String blockId, String link) async {
    await isar.writeTxn(() async {
      final block = await isar.blocks
          .filter()
          .blockIdEqualTo(blockId)
          .findFirst();
      
      if (block != null) {
        block.addLink(link);
        await isar.blocks.put(block);
      }
    });
  }

  /// Remove link from block
  static Future<void> removeLinkFromBlock(String blockId, String link) async {
    await isar.writeTxn(() async {
      final block = await isar.blocks
          .filter()
          .blockIdEqualTo(blockId)
          .findFirst();
      
      if (block != null) {
        block.removeLink(link);
        await isar.blocks.put(block);
      }
    });
  }

  /// Add backlink to block
  static Future<void> addBacklinkToBlock(String blockId, String backlink) async {
    await isar.writeTxn(() async {
      final block = await isar.blocks
          .filter()
          .blockIdEqualTo(blockId)
          .findFirst();
      
      if (block != null) {
        block.addBacklink(backlink);
        await isar.blocks.put(block);
      }
    });
  }

  /// Remove backlink from block
  static Future<void> removeBacklinkFromBlock(String blockId, String backlink) async {
    await isar.writeTxn(() async {
      final block = await isar.blocks
          .filter()
          .blockIdEqualTo(blockId)
          .findFirst();
      
      if (block != null) {
        block.removeBacklink(backlink);
        await isar.blocks.put(block);
      }
    });
  }

  /// Get blocks with links
  static Future<List<Block>> getBlocksWithLinks() async {
    return await isar.txn(() async {
      return await isar.blocks
          .filter()
          .isDeletedEqualTo(false)
          .linksIsNotEmpty()
          .findAll();
    });
  }

  /// Get blocks with backlinks
  static Future<List<Block>> getBlocksWithBacklinks() async {
    return await isar.txn(() async {
      return await isar.blocks
          .filter()
          .isDeletedEqualTo(false)
          .backlinksIsNotEmpty()
          .findAll();
    });
  }

  // ==================== Recycle bin operations ====================
  
  /// Get deleted notes
  static Future<List<Note>> getDeletedNotes() async {
    return await isar.txn(() async {
      return await isar.notes
          .filter()
          .isDeletedEqualTo(true)
          .sortByDeletedAtDesc()
          .findAll();
    });
  }

  /// Get deleted blocks
  static Future<List<Block>> getDeletedBlocks() async {
    return await isar.txn(() async {
      return await isar.blocks
          .filter()
          .isDeletedEqualTo(true)
          .findAll();
    });
  }

  /// Restore note
  static Future<void> restoreNote(int id) async {
    await isar.writeTxn(() async {
      final note = await isar.notes.get(id);
      if (note != null) {
        note.restore();
        await isar.notes.put(note);
      }
    });
  }

  /// Restore block
  static Future<void> restoreBlock(int id) async {
    await isar.writeTxn(() async {
      final block = await isar.blocks.get(id);
      if (block != null) {
        block.restore();
        await isar.blocks.put(block);
      }
    });
  }

  /// Permanently delete note
  static Future<void> permanentlyDeleteNote(int id) async {
    await isar.writeTxn(() async {
      await isar.notes.delete(id);
    });
  }

  /// Permanently delete block
  static Future<void> permanentlyDeleteBlock(int id) async {
    await isar.writeTxn(() async {
      await isar.blocks.delete(id);
    });
  }

  /// Clear recycle bin
  static Future<void> clearRecycleBin() async {
    await isar.writeTxn(() async {
      final deletedNotes = await isar.notes
          .filter()
          .isDeletedEqualTo(true)
          .findAll();
      
      final deletedBlocks = await isar.blocks
          .filter()
          .isDeletedEqualTo(true)
          .findAll();
      
      for (final note in deletedNotes) {
        await isar.notes.delete(note.id);
      }
      
      for (final block in deletedBlocks) {
        await isar.blocks.delete(block.id);
      }
    });
  }

  // ==================== Statistics operations ====================
  
  /// Get daily statistics
  static Future<DailyStats?> getDailyStats(DateTime date) async {
    final dateOnly = DateTime(date.year, date.month, date.day, 0, 0, 0);
    
    return await isar.txn(() async {
      return await isar.dailyStats
          .filter()
          .dateEqualTo(dateOnly)
          .findFirst();
    });
  }

  /// Create or update daily statistics
  static Future<DailyStats> createOrUpdateDailyStats(
    DateTime date, {
    int? noteCount,
    int? wordCount,
    int? blockCount,
    List<String>? tags,
  }) async {
    final dateOnly = DateTime(date.year, date.month, date.day, 0, 0, 0);
    
    return await isar.writeTxn(() async {
      final existingStats = await isar.dailyStats
          .filter()
          .dateEqualTo(dateOnly)
          .findFirst();
      
      final stats = existingStats ?? DailyStats(
        date: dateOnly,
        tags: tags ?? [],
      );

      if (noteCount != null) stats.noteCount = noteCount;
      if (wordCount != null) stats.wordCount = wordCount;
      if (blockCount != null) stats.blockCount = blockCount;
      if (tags != null) stats.tags = tags;

      await isar.dailyStats.put(stats);
      
      return stats;
    });
  }

  /// Get statistics range
  static Future<List<DailyStats>> getStatsRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final start = DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0);
    final end = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    return await isar.txn(() async {
      return await isar.dailyStats
          .filter()
          .dateBetween(start, end)
          .sortByDate()
          .findAll();
    });
  }

  // ==================== Batch operations ====================
  
  /// Update note block IDs
  static Future<void> updateNoteBlockIds(int noteId, List<int> blockIds) async {
    await isar.writeTxn(() async {
      final note = await isar.notes.get(noteId);
      if (note != null) {
        note.updateBlockIds(blockIds);
        await isar.notes.put(note);
        await updateNotePreview(noteId);
      }
    });
  }

  /// Add block to note
  static Future<void> addBlockToNote(int noteId, int blockId) async {
    await isar.writeTxn(() async {
      final note = await isar.notes.get(noteId);
      if (note != null) {
        final wasEmpty = note.blockIds.isEmpty;
        note.addBlockId(blockId);
        await isar.notes.put(note);
        
        if (wasEmpty) {
          final block = await isar.blocks.get(blockId);
          if (block != null) {
            await _updateNotePreviewIfFirstBlock(noteId, block);
          }
        }
      }
    });
  }

  /// Remove block from note
  static Future<void> removeBlockFromNote(int noteId, int blockId) async {
    await isar.writeTxn(() async {
      final note = await isar.notes.get(noteId);
      if (note != null) {
        note.removeBlockId(blockId);
        await isar.notes.put(note);
        await updateNotePreview(noteId);
      }
    });
  }

  /// Update note preview
  static Future<void> updateNotePreview(int noteId) async {
    await isar.writeTxn(() async {
      final note = await isar.notes.get(noteId);
      if (note == null) {
        return;
      }
      
      if (note.blockIds.isNotEmpty) {
        final firstBlockId = note.blockIds.first;
        final firstBlock = await isar.blocks
            .filter()
            .idEqualTo(firstBlockId)
            .isDeletedEqualTo(false)
            .findFirst();
        
        if (firstBlock != null) {
          final preview = _generatePreview(firstBlock.content);
          note.updatePreview(preview);
        } else {
          note.clearPreview();
        }
      } else {
        note.clearPreview();
      }
      
      await isar.notes.put(note);
    });
  }

  /// Batch update all note previews
  static Future<void> updateAllNotePreviews() async {
    await isar.writeTxn(() async {
      final notes = await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .findAll();
      
      for (final note in notes) {
        if (note.blockIds.isNotEmpty) {
          final firstBlockId = note.blockIds.first;
          final firstBlock = await isar.blocks
              .filter()
              .idEqualTo(firstBlockId)
              .isDeletedEqualTo(false)
              .findFirst();
          
          if (firstBlock != null) {
            final preview = _generatePreview(firstBlock.content);
            note.updatePreview(preview);
          } else {
            note.clearPreview();
          }
        } else {
          note.clearPreview();
        }
        
        await isar.notes.put(note);
      }
    });
  }

  // ==================== Utility functions ====================
  
  /// Generate block ID
  static String generateBlockId() {
    return '$_blockIdPrefix${_uuid.v4()}';
  }

  /// Extract tags from content
  static List<String> extractTagsFromContent(String content) {
    const tagPattern = RegExp(r'#([a-zA-Z0-9\u1800-\u18AF]+)(?:#([a-zA-Z0-9\u1800-\u18AF]+))?');
    final matches = tagPattern.allMatches(content);
    
    return matches.map((match) {
      final parent = match.group(1)!;
      final child = match.group(2);
      return child != null ? '$parent#$child' : parent;
    }).toList();
  }

  /// Extract links from content
  static List<Map<String, String>> extractLinksFromContent(String content) {
    const linkPattern = RegExp(r'\[\[([^#\]]+)(?:#([^\]]+))?\]\]');
    final matches = linkPattern.allMatches(content);
    
    return matches.map((match) {
      return {
        'noteName': match.group(1)!,
        'blockId': match.group(2) ?? '',
      };
    }).toList();
  }

  /// Calculate word count
  static int calculateWordCount(String content) {
    if (content.trim().isEmpty) return 0;
    return content.trim().split(RegExp(r'\s+')).length;
  }

  /// Calculate note total word count
  static Future<int> calculateNoteWordCount(int noteId) async {
    final blocks = await getBlocksByNote(noteId);
    int totalWords = 0;
    
    for (final block in blocks) {
      totalWords += calculateWordCount(block.content);
    }
    
    return totalWords;
  }

  /// Update note word count statistics
  static Future<void> updateNoteWordCount(int noteId) async {
    final wordCount = await calculateNoteWordCount(noteId);
    
    await isar.writeTxn(() async {
      final note = await isar.notes.get(noteId);
      note?.updateWordCount(wordCount);
      if (note != null) {
        await isar.notes.put(note);
      }
    });
  }

  // ==================== Private helper methods ====================
  
  /// Update note preview if this is the first block
  static Future<void> _updateNotePreviewIfFirstBlock(int noteId, Block updatedBlock) async {
    final note = await isar.notes.get(noteId);
    if (note == null || note.blockIds.isEmpty) {
      return;
    }
    
    if (note.blockIds.first == updatedBlock.id) {
      final preview = _generatePreview(updatedBlock.content);
      note.updatePreview(preview);
      await isar.notes.put(note);
    }
  }

  /// Generate preview text
  static String _generatePreview(String content) {
    return content.length > _maxPreviewLength 
        ? '${content.substring(0, _maxPreviewLength)}...' 
        : content;
  }
} 