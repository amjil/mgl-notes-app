import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../database/database.dart';

/// Unified database service with both Map-based and ClojureDart-friendly methods
/// Provides both traditional Map<String, dynamic> methods and simplified parameter methods
class DatabaseService {
  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  DatabaseService(this._database);

  // ===== Note Operations =====
  
  /// Get all notes - returns Map list, ClojureDart friendly
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final notes = await _database.getAllNotesWithFts();
    return notes.map((note) => {
      'id': note['id'],
      'title': note['title'],
      'blockIds': note['blockIds'],
      'createdAt': note['createdAt'],
      'updatedAt': note['updatedAt'],
      'syncStatus': note['syncStatus'],
      'fts_content': note['fts_content'],
    }).toList();
  }

  /// Get notes with pagination
  Future<List<Map<String, dynamic>>> getNotesPaginated({
    required int page,
    required int pageSize,
  }) async {
    final notes = await _database.getNotesPaginatedWithFts(page: page, pageSize: pageSize);
    return notes.map((note) => {
      'id': note['id'],
      'title': note['title'],
      'blockIds': note['blockIds'],
      'createdAt': note['createdAt'],
      'updatedAt': note['updatedAt'],
      'syncStatus': note['syncStatus'],
      'fts_content': note['fts_content'],
    }).toList();
  }

  /// Get total count of notes
  Future<int> getNotesCount() async {
    return await _database.getNotesCount();
  }

  /// Get note by ID
  Future<Map<String, dynamic>?> getNoteById(String id) async {
    final note = await _database.getNoteByIdWithFts(id);
    if (note == null) return null;
    
    return {
      'id': note['id'],
      'title': note['title'],
      'blockIds': note['blockIds'],
      'createdAt': note['createdAt'],
      'updatedAt': note['updatedAt'],
      'syncStatus': note['syncStatus'],
      'fts_content': note['fts_content'],
    };
  }

  /// Create note with Map data (traditional method)
  Future<String> createNote(Map<String, dynamic> data) async {
    final noteId = data['id'] ?? _uuid.v4();
    final note = NotesCompanion.insert(
      id: noteId,
      title: data['title'] ?? '',
      blockIds: Value(data['blockIds'] ?? '[]'),
    );
    
    await _database.insertNote(note);
    return noteId;
  }

  /// Create note with simplified parameters - ClojureDart friendly
  Future<String> createNoteSimple(String title, [String? id, String? blockIds]) async {
    final noteId = id ?? _uuid.v4();
    final note = NotesCompanion.insert(
      id: noteId,
      title: title,
      blockIds: Value(blockIds ?? '[]'),
    );
    
    await _database.insertNote(note);
    return noteId;
  }

  /// Update note with Map data (traditional method)
  Future<bool> updateNote(Map<String, dynamic> data) async {
    final note = NotesCompanion(
      id: Value(data['id']),
      title: data['title'] != null ? Value(data['title']) : const Value.absent(),
      blockIds: data['blockIds'] != null ? Value(data['blockIds']) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
      syncStatus: data['syncStatus'] != null ? Value(data['syncStatus']) : const Value.absent(),
    );
    
    return await _database.updateNote(note);
  }

  /// Update note title - simplified for ClojureDart
  Future<bool> updateNoteTitle(String id, String title) async {
    final note = NotesCompanion(
      id: Value(id),
      title: Value(title),
      updatedAt: Value(DateTime.now()),
    );
    
    return await _database.updateNote(note);
  }

  /// Update note blockIds - simplified for ClojureDart
  Future<bool> updateNoteBlockIds(String id, String blockIds) async {
    final note = NotesCompanion(
      id: Value(id),
      blockIds: Value(blockIds),
      updatedAt: Value(DateTime.now()),
    );
    
    return await _database.updateNote(note);
  }

  /// Update note sync status - simplified for ClojureDart
  Future<bool> updateNoteSyncStatus(String id, String syncStatus) async {
    final note = NotesCompanion(
      id: Value(id),
      syncStatus: Value(syncStatus),
      updatedAt: Value(DateTime.now()),
    );
    
    return await _database.updateNote(note);
  }

  /// Delete note
  Future<bool> deleteNote(String id) async {
    final deletedCount = await _database.deleteNote(id);
    return deletedCount > 0;
  }

  // ===== Block Operations =====
  
  /// Get all blocks for a note
  Future<List<Map<String, dynamic>>> getBlocksByNoteId(String noteId) async {
    final blocks = await _database.getBlocksByNoteId(noteId);
    return blocks.map((block) => {
      'id': block.id,
      'noteId': block.noteId,
      'content': block.content,
      'createdAt': block.createdAt.toIso8601String(),
      'updatedAt': block.updatedAt.toIso8601String(),
      'syncStatus': block.syncStatus,
    }).toList();
  }

  /// Get block by ID
  Future<Map<String, dynamic>?> getBlockById(String id) async {
    final block = await _database.getBlockById(id);
    if (block == null) return null;
    
    return {
      'id': block.id,
      'noteId': block.noteId,
      'content': block.content,
      'createdAt': block.createdAt.toIso8601String(),
      'updatedAt': block.updatedAt.toIso8601String(),
      'syncStatus': block.syncStatus,
    };
  }

  /// Create block with Map data (traditional method)
  Future<String> createBlock(Map<String, dynamic> data) async {
    final blockId = data['id'] ?? _uuid.v4();
    final block = BlocksCompanion.insert(
      id: blockId,
      noteId: data['noteId'],
      content: data['content'] ?? '',
    );
    
    await _database.insertBlock(block);
    
    // Update full-text search index
    await _database.updateBlocksFts(blockId, data['content'] ?? '');
    
    return blockId;
  }

  /// Create block with simplified parameters - ClojureDart friendly
  Future<String> createBlockSimple(String noteId, String content, [String? id]) async {
    final blockId = id ?? _uuid.v4();
    final block = BlocksCompanion.insert(
      id: blockId,
      noteId: noteId,
      content: content,
    );
    
    await _database.insertBlock(block);
    
    // Update full-text search index
    await _database.updateBlocksFts(blockId, content);
    
    return blockId;
  }

  /// Update block with Map data (traditional method)
  Future<bool> updateBlock(Map<String, dynamic> data) async {
    final block = BlocksCompanion(
      id: Value(data['id']),
      content: data['content'] != null ? Value(data['content']) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
      syncStatus: data['syncStatus'] != null ? Value(data['syncStatus']) : const Value.absent(),
    );
    
    final success = await _database.updateBlock(block);
    
    return success;
  }

  /// Update block content - simplified for ClojureDart
  Future<bool> updateBlockContent(String id, String content) async {
    final block = BlocksCompanion(
      id: Value(id),
      content: Value(content),
      updatedAt: Value(DateTime.now()),
    );
    
    final success = await _database.updateBlock(block);
    
    return success;
  }

  /// Update block sync status - simplified for ClojureDart
  Future<bool> updateBlockSyncStatus(String id, String syncStatus) async {
    final block = BlocksCompanion(
      id: Value(id),
      syncStatus: Value(syncStatus),
      updatedAt: Value(DateTime.now()),
    );
    
    return await _database.updateBlock(block);
  }

  /// Delete block
  Future<bool> deleteBlock(String id) async {
    final deletedCount = await _database.deleteBlock(id);
    
    return deletedCount > 0;
  }

  // ===== Tag Operations =====
  
  /// Get all tags
  Future<List<Map<String, dynamic>>> getAllTags() async {
    final tags = await _database.getAllTags();
    return tags.map((tag) => {
      'id': tag.id,
      'name': tag.name,
    }).toList();
  }

  /// Create tag with Map data (traditional method)
  Future<String> createTag(Map<String, dynamic> data) async {
    final tagId = data['id'] ?? _uuid.v4();
    final tag = TagsCompanion.insert(
      id: tagId,
      name: data['name'],
    );
    
    await _database.insertTag(tag);
    return tagId;
  }

  /// Create tag with simplified parameters - ClojureDart friendly
  Future<String> createTagSimple(String name, [String? id]) async {
    final tagId = id ?? _uuid.v4();
    final tag = TagsCompanion.insert(
      id: tagId,
      name: name,
    );
    
    await _database.insertTag(tag);
    return tagId;
  }

  /// Add tag to note
  Future<bool> addTagToNote(String noteId, String tagId) async {
    final result = await _database.addTagToNote(noteId, tagId);
    return result > 0;
  }

  /// Remove tag from note
  Future<bool> removeTagFromNote(String noteId, String tagId) async {
    final result = await _database.removeTagFromNote(noteId, tagId);
    return result > 0;
  }

  /// Get tags by note ID
  Future<List<Map<String, dynamic>>> getTagsByNoteId(String noteId) async {
    final tags = await _database.getTagsByNoteId(noteId);
    return tags.map((tag) => {
      'id': tag.id,
      'name': tag.name,
    }).toList();
  }

  // ===== Search Operations =====
  
  /// Search notes
  Future<List<Map<String, dynamic>>> searchNotes(String query) async {
    final results = await _database.searchNotes(query);
    return results.map((result) => {
      'id': result['id'],
      'content': result['content'],
    }).toList();
  }

  /// Search blocks
  Future<List<Map<String, dynamic>>> searchBlocks(String query) async {
    final results = await _database.searchBlocks(query);
    return results.map((result) => {
      'id': result['id'],
      'content': result['content'],
    }).toList();
  }

  /// Search notes with pagination
  Future<List<Map<String, dynamic>>> searchNotesPaginated(
    String query, {
    required int page,
    required int pageSize,
  }) async {
    final results = await _database.searchNotesPaginated(
      query,
      page: page,
      pageSize: pageSize,
    );
    return results.map((result) => {
      'id': result['id'],
      'content': result['content'],
    }).toList();
  }

  /// Search blocks with pagination
  Future<List<Map<String, dynamic>>> searchBlocksPaginated(
    String query, {
    required int page,
    required int pageSize,
  }) async {
    final results = await _database.searchBlocksPaginated(
      query,
      page: page,
      pageSize: pageSize,
    );
    return results.map((result) => {
      'id': result['id'],
      'content': result['content'],
    }).toList();
  }

  /// Get total count of search results for notes
  Future<int> getSearchNotesCount(String query) async {
    return await _database.getSearchNotesCount(query);
  }

  /// Get total count of search results for blocks
  Future<int> getSearchBlocksCount(String query) async {
    return await _database.getSearchBlocksCount(query);
  }

  // ===== Full-Text Search Index Operations =====
  
  /// Update note full-text search index with content
  Future<void> updateNoteFts(String id, String content) async {
    await _database.updateNoteFts(id, content);
  }

  /// Update blocks full-text search index
  Future<void> updateBlocksFts(String id, String content) async {
    await _database.updateBlocksFts(id, content);
  }

  /// Delete from note full-text search index
  Future<void> deleteFromNoteFts(String id) async {
    await _database.deleteFromNoteFts(id);
  }

  /// Delete from blocks full-text search index
  Future<void> deleteFromBlocksFts(String id) async {
    await _database.deleteFromBlocksFts(id);
  }

  // ===== Sync Operations =====
  
  /// Get pending notes for sync
  Future<List<Map<String, dynamic>>> getPendingNotes() async {
    final notes = await _database.getPendingNotes();
    return notes.map((note) => {
      'id': note.id,
      'title': note.title,
      'syncStatus': note.syncStatus,
    }).toList();
  }

  /// Get pending blocks for sync
  Future<List<Map<String, dynamic>>> getPendingBlocks() async {
    final blocks = await _database.getPendingBlocks();
    return blocks.map((block) => {
      'id': block.id,
      'content': block.content,
      'syncStatus': block.syncStatus,
    }).toList();
  }

  /// Mark note as synced
  Future<bool> markNoteAsSynced(String noteId) async {
    return await _database.markNoteAsSynced(noteId);
  }

  /// Mark block as synced
  Future<bool> markBlockAsSynced(String blockId) async {
    return await _database.markBlockAsSynced(blockId);
  }

  // ===== Private Helper Methods =====

  /// Close database connection
  Future<void> close() async {
    await _database.close();
  }
} 