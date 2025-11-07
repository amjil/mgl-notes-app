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
  TextColumn get noteId => text().references(Notes, #id, onDelete: KeyAction.cascade)();
  TextColumn get userId => text().nullable()();
  TextColumn get content => text()();
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
  TextColumn get noteId => text().references(Notes, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId => text().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {noteId, tagId};
}

// Favorite notes table
class FavoriteNotes extends Table {
  TextColumn get userId => text().nullable()();
  TextColumn get noteId => text().references(Notes, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {noteId};
}

@DriftDatabase(
  tables: [
    Notes,
    Blocks,
    Tags,
    NoteTags,
    FavoriteNotes,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 12;

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
      },
    );
  }
}

Future<AppDatabase> initDriftDatabase() async {
  final db = AppDatabase(impl.connect());

  await db.customSelect("SELECT 1").get();

  return db;
}