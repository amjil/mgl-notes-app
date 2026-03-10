import 'package:drift/drift.dart';

import 'connection/connection.dart' as impl;

part 'database.g.dart';

// ---------------------------------------------------------------------------
// Tables
// ---------------------------------------------------------------------------

class Pages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  
  // Page type: 'page' vs 'journal'
  TextColumn get type => text().withDefault(const Constant('page'))();
  
  // Created time for future timeline ordering
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Blocks extends Table {
  /// Block id (e.g. UUID string)
  TextColumn get id => text()();
  /// Page identifier (page name)
  TextColumn get pageId => text().references(Pages, #name, onDelete: KeyAction.cascade)();
  IntColumn get orderIndex => integer()();
  IntColumn get indent => integer().withDefault(const Constant(0))();
  TextColumn get type => text()();
  TextColumn get content => text().withDefault(const Constant(''))();
  TextColumn get dataJson => text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {id};
}

class BlockLinks extends Table {
  TextColumn get sourceId => text().references(Blocks, #id, onDelete: KeyAction.cascade)();
  TextColumn get targetId => text()();
  TextColumn get linkType => text().withDefault(const Constant('ref'))();

  @override
  Set<Column> get primaryKey => {sourceId, targetId};
}

/// Block properties: key:: value parsed and stored for SQL filter/query.
class Properties extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get blockId => text().references(Blocks, #id, onDelete: KeyAction.cascade)();
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  List<Set<Column>> get uniqueKeys => [{blockId, key}];
}

// ---------------------------------------------------------------------------
// Database
// ---------------------------------------------------------------------------

@DriftDatabase(tables: [Pages, Blocks, BlockLinks, Properties])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  // Schema version 3 (Properties table)
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migrations {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          await m.addColumn(pages, pages.type);
          await m.addColumn(pages, pages.createdAt);
        }
        if (from <= 2) {
          await m.createTable(properties);
        }
      },
    );
  }

  // Stream APIs for ClojureDart

  /// All journal names (desc, most recent first)
  Stream<List<String>> watchAllJournals() {
    final query = select(pages)
      ..where((t) => t.type.equals('journal'))
      ..orderBy([(t) => OrderingTerm.desc(t.name)]);
    return query.watch().map((rows) => rows.map((row) => row.name).toList());
  }

  /// All page names (asc by name)
  Stream<List<String>> watchAllPages() {
    final query = select(pages)
      ..where((t) => t.type.equals('page'))
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
      
    return query.watch().map((rows) => rows.map((row) => row.name).toList());
  }
}

/// Initialize the database and verify connection. Call with await before runApp.
Future<AppDatabase> initDriftDatabase() async {
  final db = AppDatabase();
  await db.customSelect("SELECT 1").get();
  return db;
}