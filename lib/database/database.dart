import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'connection/connection.dart' as impl;

part 'database.g.dart';

// Notes table
class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get blockIds => text().withDefault(const Constant('[]'))();
  TextColumn get metaData => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Blocks table
class Blocks extends Table {
  TextColumn get id => text()();
  TextColumn get noteId =>
      text().references(Notes, #id, onDelete: KeyAction.cascade)();
  TextColumn get userId => text().nullable()();
  TextColumn get content => text()();
  TextColumn get metaData => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Tags table
class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get name => text().unique()();

  @override
  Set<Column> get primaryKey => {id};
}

// Note-tag junction table
class NoteTags extends Table {
  TextColumn get userId => text().nullable()();
  TextColumn get noteId =>
      text().references(Notes, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId =>
      text().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {noteId, tagId};
}

// Favorite notes table
class FavoriteNotes extends Table {
  TextColumn get userId => text().nullable()();
  TextColumn get noteId =>
      text().references(Notes, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {noteId};
}

// Note references table - stores note_id and referenced_note_id for note reference jump functionality
class NoteReferences extends Table {
  TextColumn get userId => text().nullable()();
  TextColumn get noteId =>
      text().references(Notes, #id, onDelete: KeyAction.cascade)();
  TextColumn get referencedNoteId =>
      text().references(Notes, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {noteId, referencedNoteId};
}

@DriftDatabase(
  tables: [Notes, Blocks, Tags, NoteTags, FavoriteNotes, NoteReferences],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 16;

  // Helper function to safely add a column if it doesn't exist
  Future<void> _addColumnIfNotExists(
    String tableName,
    String columnName,
    String columnDefinition,
  ) async {
    try {
      await customStatement(
        'ALTER TABLE $tableName ADD COLUMN $columnName $columnDefinition',
      );
    } catch (e) {
      // Check if error is due to duplicate column name
      final errorStr = e.toString().toLowerCase();
      if (!errorStr.contains('duplicate column') &&
          !errorStr.contains('duplicate column name')) {
        // Re-throw if it's a different error
        rethrow;
      }
      // Otherwise, column already exists, which is fine
    }
  }

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
            content
          )
        ''');

        await customStatement('''
          CREATE VIRTUAL TABLE note_fts
          USING fts5(
            id UNINDEXED,
            content
          )
        ''');
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle database upgrade logic
        if (from < 2) {
          // Future upgrade logic can be added here
        }
        if (from < 12) {
          // Add favorite_notes table
          await m.createTable(favoriteNotes);
        }
        if (from < 13) {
          // Add note_references table for note reference jump functionality
          await m.createTable(noteReferences);
        }
        if (from < 14) {
          // Add user_id column to note_references table if it doesn't exist
          await _addColumnIfNotExists('note_references', 'user_id', 'TEXT');
        }
        if (from < 15) {
          // Add meta_data column to blocks table
          await customStatement('ALTER TABLE blocks ADD COLUMN meta_data TEXT');
        }
        if (from < 16) {
          // Add meta_data column to notes table
          await customStatement('ALTER TABLE notes ADD COLUMN meta_data TEXT');
        }
      },
    );
  }
}

Future<AppDatabase> initDriftDatabase() async {
  final db = AppDatabase(impl.connect());

  await db.customSelect("SELECT 1").get();

  return db;
}
