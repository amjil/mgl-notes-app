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
  TextColumn get blockIds => text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  BoolColumn get isBlocksSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get baseHash => text().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get syncVersion => integer().withDefault(const Constant(0))();

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

// Daily notes count table for calendar visualization
class DailyNotesCount extends Table {
  TextColumn get date => text()(); // Format: YYYY.MM.DD
  IntColumn get noteCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {date};
}

// Sync conflicts table for handling synchronization conflicts
class SyncConflicts extends Table {
  TextColumn get id => text()();
  TextColumn get note_id => text()(); // 'note'
  TextColumn get conflictType => text()(); // 'version_conflict', 'deletion_conflict', 'merge_conflict'
  TextColumn get localData => text().nullable()(); // JSON string of local data
  TextColumn get remoteData => text().nullable()(); // JSON string of remote data
  TextColumn get resolvedData => text().nullable()(); // JSON string of resolved data after conflict resolution
  TextColumn get resolution => text().withDefault(const Constant('pending'))(); // 'pending', 'local_wins', 'remote_wins', 'merged'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  TextColumn get description => text().nullable()(); // Human-readable description of the conflict

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Notes,
    Blocks,
    Links,
    Tags,
    NoteTags,
    DailyNotesCount,
    SyncConflicts,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 11;

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
        if (from < 5) {
          await m.addColumn(notes, notes.isBlocksSynced);
        }
        if (from < 6) {
          await m.addColumn(notes, notes.isDeleted);
        }
        if (from < 7) {
          await m.createTable(syncConflicts);
        }
        if (from < 8) {
          await m.addColumn(notes, notes.syncedAt);
        }
        if (from < 9) {
          await m.addColumn(notes, notes.baseHash);
        }
        if (from < 9) {
          await m.addColumn(notes, notes.mergedFromConflict);
        }
        if (from < 10) {
          await m.addColumn(notes, notes.deletedAt);
        }
        if (from < 11) {
          await m.addColumn(notes, notes.syncVersion);
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