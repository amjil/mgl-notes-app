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

/// Binary assets (images, attachments) referenced by blocks via asset-id.
class Assets extends Table {
  TextColumn get id => text()();
  TextColumn get filename => text()();
  TextColumn get mimeType => text().named('mime_type')();
  IntColumn get sizeBytes => integer().named('size_bytes')();
  TextColumn get sha256 => text()();
  TextColumn get localPath => text().named('local_path').nullable()();
  /// pending | uploaded | failed | pending_download
  TextColumn get uploadStatus =>
      text().named('upload_status').withDefault(const Constant('pending'))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Wiki / #tag outbound links: block → target document title.
/// `link_type` is `wiki` (`[[Title]]`) or `tag` (`#tag`).
class BlockLinks extends Table {
  TextColumn get sourceId =>
      text().references(Blocks, #id, onDelete: KeyAction.cascade)();
  /// Target is the document title string (matches `[[Title]]` / `#tag`).
  TextColumn get targetId => text()();
  TextColumn get linkType => text().withDefault(const Constant('wiki'))();

  @override
  Set<Column> get primaryKey => {sourceId, targetId};
}

/// Local mapping between a note and its remote publication.
class Publications extends Table {
  TextColumn get id => text()();
  TextColumn get documentId =>
      text().references(Documents, #id, onDelete: KeyAction.cascade)();
  TextColumn get provider => text().withDefault(const Constant('nomio'))();
  TextColumn get remoteId => text().named('remote_id').nullable()();
  TextColumn get status => text().withDefault(const Constant('publishing'))();
  DateTimeColumn get publishedAt => dateTime().named('published_at').nullable()();
  DateTimeColumn get lastSyncedAt =>
      dateTime().named('last_synced_at').nullable()();
  TextColumn get lastError => text().named('last_error').nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {documentId, provider},
      ];
}

@DriftDatabase(
  tables: [Documents, Blocks, Operations, BlockLinks, Assets, Publications],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? impl.connect());

  @override
  int get schemaVersion => 5;

  // 核心逻辑：定义 FTS5 虚拟表和自动同步的 SQLite 触发器
  Future<void> _createFts(Migrator m) async {
    // 1. 创建 unicode61 分词器的全文索引虚拟表
    await m.issueCustomQuery('''
      CREATE VIRTUAL TABLE IF NOT EXISTS search_index USING fts5(
        document_id UNINDEXED,
        block_id UNINDEXED,
        text,
        tokenize='unicode61'
      );
    ''');

    // 2. 绑定文档(Documents)触发器，实时同步标题
    await m.issueCustomQuery('''
      CREATE TRIGGER IF NOT EXISTS documents_ai AFTER INSERT ON documents
      WHEN new.deleted_at IS NULL BEGIN
        INSERT INTO search_index(document_id, block_id, text) VALUES (new.id, 'title', new.title);
      END;
    ''');
    await m.issueCustomQuery('''
      CREATE TRIGGER IF NOT EXISTS documents_au AFTER UPDATE ON documents BEGIN
        DELETE FROM search_index WHERE document_id = old.id AND block_id = 'title';
        INSERT INTO search_index(document_id, block_id, text)
        SELECT new.id, 'title', new.title WHERE new.deleted_at IS NULL;
      END;
    ''');
    await m.issueCustomQuery('''
      CREATE TRIGGER IF NOT EXISTS documents_ad AFTER DELETE ON documents BEGIN
        DELETE FROM search_index WHERE document_id = old.id AND block_id = 'title';
      END;
    ''');

    // 3. 绑定段落(Blocks)触发器，实时同步正文内容
    await m.issueCustomQuery('''
      CREATE TRIGGER IF NOT EXISTS blocks_ai AFTER INSERT ON blocks
      WHEN new.deleted_at IS NULL BEGIN
        INSERT INTO search_index(document_id, block_id, text) VALUES (new.document_id, new.id, new.text);
      END;
    ''');
    await m.issueCustomQuery('''
      CREATE TRIGGER IF NOT EXISTS blocks_au AFTER UPDATE ON blocks BEGIN
        DELETE FROM search_index WHERE block_id = old.id;
        INSERT INTO search_index(document_id, block_id, text)
        SELECT new.document_id, new.id, new.text WHERE new.deleted_at IS NULL;
      END;
    ''');
    await m.issueCustomQuery('''
      CREATE TRIGGER IF NOT EXISTS blocks_ad AFTER DELETE ON blocks BEGIN
        DELETE FROM search_index WHERE block_id = old.id;
      END;
    ''');
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (_) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onCreate: (Migrator m) async {
        await m.createAll();
        await _createFts(m); // 全新安装时自动建立 FTS
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(blockLinks);
        }
        if (from < 3) {
          await m.createTable(assets);
        }
        if (from < 4) { // 老用户升级时：建立 FTS 并回填所有历史数据
          await _createFts(m);
          await m.issueCustomQuery('''
            INSERT INTO search_index(document_id, block_id, text)
            SELECT id, 'title', title FROM documents WHERE deleted_at IS NULL;
          ''');
          await m.issueCustomQuery('''
            INSERT INTO search_index(document_id, block_id, text)
            SELECT document_id, id, text FROM blocks WHERE deleted_at IS NULL;
          ''');
        }
        if (from < 5) {
          await m.createTable(publications);
        }
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

  Future<Publication?> getPublicationForDocument(
    String documentId,
    String provider,
  ) {
    final query = select(publications)
      ..where(
        (t) =>
            t.documentId.equals(documentId) & t.provider.equals(provider),
      )
      ..limit(1);
    return query.getSingleOrNull();
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

  Future<List<Asset>> getPendingUploadAssets() {
    final query = select(assets)
      ..where((t) =>
          t.uploadStatus.equals('pending') & t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    return query.get();
  }

  Future<List<Asset>> getPendingDownloadAssets() {
    final query = select(assets)
      ..where((t) =>
          t.uploadStatus.equals('pending_download') & t.deletedAt.isNull())
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
