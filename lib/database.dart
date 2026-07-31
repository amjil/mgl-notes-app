import 'package:drift/drift.dart';

import 'connection/connection.dart' as impl;

part 'database.g.dart';

// ---------------------------------------------------------------------------
// Tables (Sync Spec v1.0)
// ---------------------------------------------------------------------------

class Documents extends Table {
  TextColumn get id => text()();
  TextColumn get parentId => text().nullable()();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get icon => text().nullable()();
  // 'normal' | 'daily'
  TextColumn get type => text().withDefault(const Constant('normal'))();
  TextColumn get cover => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Blocks extends Table {
  TextColumn get id => text()();
  TextColumn get documentId =>
      text().references(Documents, #id, onDelete: KeyAction.cascade)();
  TextColumn get parentId => text().nullable()();

  TextColumn get type => text()();
  TextColumn get textContent =>
      text().named('text').withDefault(const Constant(''))();
  BoolColumn get checked => boolean().withDefault(const Constant(false))();
  TextColumn get dataJson => text().nullable()();

  RealColumn get orderIndex => real()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Operations extends Table {
  TextColumn get id => text()();
  TextColumn get deviceId => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get action => text()();
  TextColumn get payload => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Documents, Blocks, Operations])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migrations {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
    );
  }

  Stream<List<Document>> watchDocuments() {
    final query = select(documents)
      ..where((t) => t.deletedAt.isNull() & t.type.equals('normal'))
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);
    return query.watch();
  }

  Stream<List<DocumentWithChildrenNum>> watchAllActiveDocuments() {
    final children = alias(documents, 'children');
    final childrenNum = children.id.count();

    final query = select(documents).join([
      leftOuterJoin(
        children,
        children.parentId.equalsExp(documents.id) &
            children.deletedAt.isNull(),
        useColumns: false,
      ),
    ])
      ..addColumns([childrenNum])
      ..where(documents.deletedAt.isNull())
      ..groupBy([documents.id])
      ..orderBy([OrderingTerm.desc(documents.updatedAt)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return DocumentWithChildrenNum(
          document: row.readTable(documents),
          childrenNum: row.read(childrenNum) ?? 0,
        );
      }).toList();
    });
  }

  Stream<List<Block>> watchBlocksForDocument(String docId) {
    final query = select(blocks)
      ..where((t) => t.documentId.equals(docId) & t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]);
    return query.watch();
  }

  Stream<List<TaskWithDocument>> watchUncompletedTasks() {
    final query = select(blocks).join([
      innerJoin(documents, documents.id.equalsExp(blocks.documentId)),
    ])
      ..where(blocks.type.equals('todo') &
          blocks.checked.equals(false) &
          blocks.deletedAt.isNull() &
          documents.deletedAt.isNull())
      ..orderBy([OrderingTerm.desc(blocks.updatedAt)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final doc = row.readTable(documents);
        return TaskWithDocument(
          block: row.readTable(blocks),
          documentId: doc.id,
          documentTitle: doc.title,
        );
      }).toList();
    });
  }

  Future<List<Operation>> getUnsyncedOperations() {
    final query = select(operations)
      ..where((t) => t.synced.equals(false))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    return query.get();
  }
}

class DocumentWithChildrenNum {
  final Document document;
  final int childrenNum;

  DocumentWithChildrenNum({
    required this.document,
    required this.childrenNum,
  });
}

class TaskWithDocument {
  final Block block;
  final String documentId;
  final String documentTitle;

  TaskWithDocument({
    required this.block,
    required this.documentId,
    required this.documentTitle,
  });
}

Future<AppDatabase> initDriftDatabase() async {
  final db = AppDatabase();
  await db.customSelect('SELECT 1').get();
  return db;
}
