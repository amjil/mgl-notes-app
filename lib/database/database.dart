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

// Notes statistics table
class NotesStats extends Table {
  TextColumn get noteId => text().references(Notes, #id, onDelete: KeyAction.cascade)();
  IntColumn get blockCount => integer().withDefault(const Constant(0))();
  IntColumn get wordCount => integer().withDefault(const Constant(0))();
  IntColumn get characterCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {noteId};
}

@DriftDatabase(
  tables: [
    Notes,
    Blocks,
    Links,
    Tags,
    NoteTags,
    NotesStats,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

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
}

Future<AppDatabase> initDriftDatabase() async {
  final db = AppDatabase(impl.connect());

  await db.customSelect("SELECT 1").get();

  return db;
}