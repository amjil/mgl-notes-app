import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Notes table
class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get blockIds => text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Blocks table
class Blocks extends Table {
  TextColumn get id => text()();
  TextColumn get noteId => text().references(Notes, #id, onDelete: KeyAction.cascade)();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Links table
class Links extends Table {
  TextColumn get id => text()();
  TextColumn get fromBlockId => text().references(Blocks, #id, onDelete: KeyAction.cascade)();
  TextColumn get toNoteId => text().references(Notes, #id, onDelete: KeyAction.cascade)();
  TextColumn get toBlockId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Tags table
class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().unique()();

  @override
  Set<Column> get primaryKey => {id};
}

// Note-tag junction table
class NoteTags extends Table {
  TextColumn get noteId => text().references(Notes, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId => text().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {noteId, tagId};
}



@DriftDatabase(
  tables: [
    Notes,
    Blocks,
    Links,
    Tags,
    NoteTags,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        
        // Create FTS5 tables for full-text search
        await customStatement('''
          CREATE VIRTUAL TABLE blocks_fts
          USING fts5(
            id UNINDEXED,
            content,
            content='',
            tokenize='unicode61'
          )
        ''');
        
        await customStatement('''
          CREATE VIRTUAL TABLE note_fts
          USING fts5(
            id UNINDEXED,
            content,
            content='',
            tokenize='unicode61'
          )
        ''');
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle database upgrade logic
        if (from < 2) {
          // Future upgrade logic can be added here
        }
      },
    );
  }

  // Note-related operations
  Future<List<Note>> getAllNotes() => select(notes).get();
  
  Future<List<Map<String, dynamic>>> getAllNotesWithFts() async {
    final result = await customSelect(
      '''
      SELECT 
        n.id,
        n.title,
        n.blockIds,
        n.createdAt,
        n.updatedAt,
        n.syncStatus,
        COALESCE(nf.content, '') as fts_content
      FROM notes n
      LEFT JOIN note_fts nf ON n.id = nf.id
      ORDER BY n.updatedAt DESC
      ''',
    ).get();
    
    return result.map((row) => {
      'id': row.data['id'],
      'title': row.data['title'],
      'blockIds': row.data['blockIds'],
      'createdAt': row.data['createdAt'],
      'updatedAt': row.data['updatedAt'],
      'syncStatus': row.data['syncStatus'],
      'fts_content': row.data['fts_content'],
    }).toList();
  }
  
  Future<List<Note>> getNotesPaginated({
    required int page,
    required int pageSize,
  }) {
    final offset = (page - 1) * pageSize;
    return (select(notes)
          ..orderBy([(n) => OrderingTerm.desc(n.updatedAt)])
          ..limit(pageSize, offset: offset))
        .get();
  }

  Future<List<Map<String, dynamic>>> getNotesPaginatedWithFts({
    required int page,
    required int pageSize,
  }) async {
    final offset = (page - 1) * pageSize;
    final result = await customSelect(
      '''
      SELECT 
        n.id,
        n.title,
        n.blockIds,
        n.createdAt,
        n.updatedAt,
        n.syncStatus,
        COALESCE(nf.content, '') as fts_content
      FROM notes n
      LEFT JOIN note_fts nf ON n.id = nf.id
      ORDER BY n.updatedAt DESC
      LIMIT ? OFFSET ?
      ''',
      variables: [
        Variable.withInt(pageSize),
        Variable.withInt(offset),
      ],
    ).get();
    
    return result.map((row) => {
      'id': row.data['id'],
      'title': row.data['title'],
      'blockIds': row.data['blockIds'],
      'createdAt': row.data['createdAt'],
      'updatedAt': row.data['updatedAt'],
      'syncStatus': row.data['syncStatus'],
      'fts_content': row.data['fts_content'],
    }).toList();
  }
  
  Future<int> getNotesCount() => select(notes).get().then((notes) => notes.length);
  
  Future<Note?> getNoteById(String id) => 
      (select(notes)..where((n) => n.id.equals(id))).getSingleOrNull();
  
  Future<Map<String, dynamic>?> getNoteByIdWithFts(String id) async {
    final result = await customSelect(
      '''
      SELECT 
        n.id,
        n.title,
        n.blockIds,
        n.createdAt,
        n.updatedAt,
        n.syncStatus,
        COALESCE(nf.content, '') as fts_content
      FROM notes n
      LEFT JOIN note_fts nf ON n.id = nf.id
      WHERE n.id = ?
      ''',
      variables: [Variable.withString(id)],
    ).getSingleOrNull();
    
    if (result == null) return null;
    
    return {
      'id': result.data['id'],
      'title': result.data['title'],
      'blockIds': result.data['blockIds'],
      'createdAt': result.data['createdAt'],
      'updatedAt': result.data['updatedAt'],
      'syncStatus': result.data['syncStatus'],
      'fts_content': result.data['fts_content'],
    };
  }
  
  Future<int> insertNote(NotesCompanion note) => into(notes).insert(note);
  
  Future<bool> updateNote(NotesCompanion note) => 
      update(notes).replace(note);
  
  Future<int> deleteNote(String id) => 
      (delete(notes)..where((n) => n.id.equals(id))).go();

  // Block-related operations
  Future<List<Block>> getBlocksByNoteId(String noteId) => 
      (select(blocks)..where((b) => b.noteId.equals(noteId))).get();
  
  Future<Block?> getBlockById(String id) => 
      (select(blocks)..where((b) => b.id.equals(id))).getSingleOrNull();
  
  Future<int> insertBlock(BlocksCompanion block) => into(blocks).insert(block);
  
  Future<bool> updateBlock(BlocksCompanion block) => 
      update(blocks).replace(block);
  
  Future<int> deleteBlock(String id) => 
      (delete(blocks)..where((b) => b.id.equals(id))).go();

  // Link-related operations
  Future<List<Link>> getLinksByBlockId(String blockId) => 
      (select(links)..where((l) => l.fromBlockId.equals(blockId))).get();
  
  Future<int> insertLink(LinksCompanion link) => into(links).insert(link);
  
  Future<int> deleteLink(String id) => 
      (delete(links)..where((l) => l.id.equals(id))).go();

  // Tag-related operations
  Future<List<Tag>> getAllTags() => select(tags).get();
  
  Future<Tag?> getTagByName(String name) => 
      (select(tags)..where((t) => t.name.equals(name))).getSingleOrNull();
  
  Future<int> insertTag(TagsCompanion tag) => into(tags).insert(tag);
  
  Future<List<Tag>> getTagsByNoteId(String noteId) {
    return (select(tags)
          ..join([
            innerJoin(noteTags, noteTags.tagId.equalsExp(tags.id)),
          ])
          ..where((t) => noteTags.noteId.equals(noteId)))
        .get();
  }

  // Note-tag association operations
  Future<int> addTagToNote(String noteId, String tagId) => 
      into(noteTags).insert(NoteTagsCompanion(
        noteId: Value(noteId),
        tagId: Value(tagId),
      ));
  
  Future<int> removeTagFromNote(String noteId, String tagId) => 
      (delete(noteTags)
        ..where((nt) => nt.noteId.equals(noteId) & nt.tagId.equals(tagId)))
      .go();

  // Full-text search operations
  Future<List<Map<String, dynamic>>> searchBlocks(String query) async {
    final result = await customSelect(
      'SELECT id, content FROM blocks_fts WHERE content MATCH ? ORDER BY rank',
      variables: [Variable.withString(query)],
    ).get();
    
    return result.map((row) => {
      'id': row.data['id'],
      'content': row.data['content'],
    }).toList();
  }

  Future<List<Map<String, dynamic>>> searchNotes(String query) async {
    final result = await customSelect(
      'SELECT id, content FROM note_fts WHERE content MATCH ? ORDER BY rank',
      variables: [Variable.withString(query)],
    ).get();
    
    return result.map((row) => {
      'id': row.data['id'],
      'content': row.data['content'],
    }).toList();
  }

  // Paginated search operations
  Future<List<Map<String, dynamic>>> searchBlocksPaginated(
    String query, {
    required int page,
    required int pageSize,
  }) async {
    final offset = (page - 1) * pageSize;
    final result = await customSelect(
      'SELECT id, content FROM blocks_fts WHERE content MATCH ? ORDER BY rank LIMIT ? OFFSET ?',
      variables: [
        Variable.withString(query),
        Variable.withInt(pageSize),
        Variable.withInt(offset),
      ],
    ).get();
    
    return result.map((row) => {
      'id': row.data['id'],
      'content': row.data['content'],
    }).toList();
  }

  Future<List<Map<String, dynamic>>> searchNotesPaginated(
    String query, {
    required int page,
    required int pageSize,
  }) async {
    final offset = (page - 1) * pageSize;
    final result = await customSelect(
      'SELECT id, content FROM note_fts WHERE content MATCH ? ORDER BY rank LIMIT ? OFFSET ?',
      variables: [
        Variable.withString(query),
        Variable.withInt(pageSize),
        Variable.withInt(offset),
      ],
    ).get();
    
    return result.map((row) => {
      'id': row.data['id'],
      'content': row.data['content'],
    }).toList();
  }

  // Get total search results count
  Future<int> getSearchBlocksCount(String query) async {
    final result = await customSelect(
      'SELECT COUNT(*) as count FROM blocks_fts WHERE content MATCH ?',
      variables: [Variable.withString(query)],
    ).getSingle();
    
    return result.data['count'] as int;
  }

  Future<int> getSearchNotesCount(String query) async {
    final result = await customSelect(
      'SELECT COUNT(*) as count FROM note_fts WHERE content MATCH ?',
      variables: [Variable.withString(query)],
    ).getSingle();
    
    return result.data['count'] as int;
  }

  // Get pending sync items
  Future<List<Note>> getPendingNotes() async {
    return (select(notes)..where((n) => n.syncStatus.equals('pending'))).get();
  }

  Future<List<Block>> getPendingBlocks() async {
    return (select(blocks)..where((b) => b.syncStatus.equals('pending'))).get();
  }

  // Mark items as synced
  Future<bool> markNoteAsSynced(String id) async {
    final note = NotesCompanion(
      id: Value(id),
      syncStatus: Value('synced'),
      updatedAt: Value(DateTime.now()),
    );
    return await updateNote(note);
  }

  Future<bool> markBlockAsSynced(String id) async {
    final block = BlocksCompanion(
      id: Value(id),
      syncStatus: Value('synced'),
      updatedAt: Value(DateTime.now()),
    );
    return await updateBlock(block);
  }

  // Update full-text search indexes
  Future<void> updateBlocksFts(String id, String content) async {
    await customStatement(
      'INSERT OR REPLACE INTO blocks_fts (id, content) VALUES (?, ?)',
      [id, content],
    );
  }

  Future<void> updateNoteFts(String id, String content) async {
    await customStatement(
      'INSERT OR REPLACE INTO note_fts (id, content) VALUES (?, ?)',
      [id, content],
    );
  }

  Future<void> deleteFromBlocksFts(String id) async {
    await customStatement(
      'DELETE FROM blocks_fts WHERE id = ?',
      [id],
    );
  }

  Future<void> deleteFromNoteFts(String id) async {
    await customStatement(
      'DELETE FROM note_fts WHERE id = ?',
      [id],
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'notes_app.db'));
    return NativeDatabase.createInBackground(file);
  });
} 