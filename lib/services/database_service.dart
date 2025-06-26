import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import '../models/block.dart';
import '../models/tag.dart';
import '../models/daily_stats.dart';

class DatabaseService {
  static Isar? _isar;
  static final Uuid _uuid = Uuid();

  static Future<void> initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [NoteSchema, BlockSchema, TagSchema, DailyStatsSchema],
      directory: dir.path,
    );
  }

  static Isar get isar {
    if (_isar == null) {
      throw Exception('Database not initialized. Call initDatabase() first.');
    }
    return _isar!;
  }

  static Future<void> closeDatabase() async {
    await _isar?.close();
    _isar = null;
  }

  // Note operations
  static Future<Note> createNote({
    required String title,
    required String content,
    List<String>? tags,
    DateTime? scheduledDate,
  }) async {
    final note = Note(
      title: title,
      content: content,
      tags: tags ?? [],
      scheduledDate: scheduledDate,
    );

    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });

    return note;
  }

  static Future<Note?> getNote(int id) async {
    return await isar.txn(() async {
      return await isar.notes.get(id);
    });
  }

  static Future<void> updateNote(Note note) async {
    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });
  }

  static Future<void> deleteNote(int id) async {
    await isar.writeTxn(() async {
      await isar.notes.delete(id);
    });
  }

  static Future<List<Note>> getAllNotes() async {
    return await isar.txn(() async {
      return await isar.notes
          .where()
          .isDeletedEqualTo(false)
          .sortByUpdatedAtDesc()
          .findAll();
    });
  }

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

  static Future<List<Note>> searchNotes(String query) async {
    return await isar.txn(() async {
      return await isar.notes
          .filter()
          .isDeletedEqualTo(false)
          .contentContains(query)
          .or()
          .titleContains(query)
          .sortByUpdatedAtDesc()
          .findAll();
    });
  }

  // Block operations
  static Future<Block> createBlock({
    required String blockId,
    required int noteId,
    required String content,
    required int order,
    List<String>? tags,
  }) async {
    final block = Block(
      blockId: blockId,
      noteId: noteId,
      content: content,
      order: order,
      tags: tags ?? [],
    );

    await isar.writeTxn(() async {
      await isar.blocks.put(block);
    });

    return block;
  }

  static Future<Block?> getBlock(String blockId) async {
    return await isar.txn(() async {
      return await isar.blocks
          .filter()
          .blockIdEqualTo(blockId)
          .isDeletedEqualTo(false)
          .findFirst();
    });
  }

  static Future<List<Block>> getBlocksByNote(int noteId) async {
    return await isar.txn(() async {
      return await isar.blocks
          .filter()
          .noteIdEqualTo(noteId)
          .isDeletedEqualTo(false)
          .sortByOrder()
          .findAll();
    });
  }

  static Future<void> updateBlock(Block block) async {
    await isar.writeTxn(() async {
      await isar.blocks.put(block);
    });
  }

  // Tag operations
  static Future<Tag> createTag({
    required String name,
    String? parentTag,
    String? color,
    String? description,
  }) async {
    final tag = Tag(
      name: name,
      parentTag: parentTag,
      color: color ?? '#2196F3',
      description: description ?? '',
    );

    await isar.writeTxn(() async {
      await isar.tags.put(tag);
    });

    return tag;
  }

  static Future<Tag?> getTag(String name) async {
    return await isar.txn(() async {
      return await isar.tags
          .filter()
          .nameEqualTo(name)
          .findFirst();
    });
  }

  static Future<List<Tag>> getAllTags() async {
    return await isar.txn(() async {
      return await isar.tags
          .where()
          .sortByUsageCountDesc()
          .findAll();
    });
  }

  static Future<void> updateTag(Tag tag) async {
    await isar.writeTxn(() async {
      await isar.tags.put(tag);
    });
  }

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

  // Recycle bin operations
  static Future<List<Note>> getDeletedNotes() async {
    return await isar.txn(() async {
      return await isar.notes
          .filter()
          .isDeletedEqualTo(true)
          .sortByDeletedAtDesc()
          .findAll();
    });
  }

  static Future<void> restoreNote(int id) async {
    await isar.writeTxn(() async {
      final note = await isar.notes.get(id);
      if (note != null) {
        note.restore();
        await isar.notes.put(note);
      }
    });
  }

  static Future<void> permanentlyDeleteNote(int id) async {
    await isar.writeTxn(() async {
      await isar.notes.delete(id);
    });
  }

  static Future<void> clearRecycleBin() async {
    await isar.writeTxn(() async {
      final deletedNotes = await isar.notes
          .filter()
          .isDeletedEqualTo(true)
          .findAll();
      
      for (final note in deletedNotes) {
        await isar.notes.delete(note.id);
      }
    });
  }

  // Daily stats operations
  static Future<DailyStats?> getDailyStats(DateTime date) async {
    final dateOnly = DateTime(date.year, date.month, date.day, 0, 0, 0);
    
    return await isar.txn(() async {
      return await isar.dailyStats
          .filter()
          .dateEqualTo(dateOnly)
          .findFirst();
    });
  }

  static Future<DailyStats> createOrUpdateDailyStats(
    DateTime date, {
    int? noteCount,
    int? wordCount,
    int? blockCount,
    List<String>? tags,
  }) async {
    final dateOnly = DateTime(date.year, date.month, date.day, 0, 0, 0);
    
    return await isar.writeTxn(() async {
      // 在写事务中读取现有统计数据
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

      // 在同一个写事务中保存
      await isar.dailyStats.put(stats);
      
      return stats;
    });
  }

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

  // Utility functions
  static String generateBlockId() {
    return 'block-${_uuid.v4()}';
  }

  static List<String> extractTagsFromContent(String content) {
    final tagPattern = RegExp(r'#([a-zA-Z0-9\u1800-\u18AF]+)(?:#([a-zA-Z0-9\u1800-\u18AF]+))?');
    final matches = tagPattern.allMatches(content);
    
    return matches.map((match) {
      final parent = match.group(1)!;
      final child = match.group(2);
      return child != null ? '$parent#$child' : parent;
    }).toList();
  }

  static List<Map<String, String>> extractBlocksFromContent(String content) {
    final blockPattern = RegExp(r'\[\[([^#\]]+)(?:#([^\]]+))?\]\]');
    final matches = blockPattern.allMatches(content);
    
    return matches.map((match) {
      return {
        'noteName': match.group(1)!,
        'blockId': match.group(2) ?? '',
      };
    }).toList();
  }
} 