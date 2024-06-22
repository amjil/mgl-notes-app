// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_use_package_imports, depend_on_referenced_packages
// ignore_for_file: prefer_double_quotes

import 'package:drift/drift.dart';
import 'package:electricsql/drivers/drift.dart';
import 'package:electricsql/electricsql.dart';

import './migrations.dart';
import './pg_migrations.dart';

const kElectricMigrations = ElectricMigrations(
  sqliteMigrations: kSqliteMigrations,
  pgMigrations: kPostgresMigrations,
);
const kElectrifiedTables = [
  Folders,
  NoteTags,
  Notes,
  SchemaMigrations,
  Tags,
];

class Folders extends Table with ElectricTableMixin {
  TextColumn get id => customType(ElectricTypes.uuid).named('id')();

  TextColumn get parentId =>
      customType(ElectricTypes.uuid).named('parent_id').nullable()();

  TextColumn get electricUserId =>
      customType(ElectricTypes.uuid).named('electric_user_id')();

  TextColumn get name => text().named('name').nullable()();

  IntColumn get orderNum =>
      customType(ElectricTypes.int4).named('order_num').nullable()();

  IntColumn get relatedNum =>
      customType(ElectricTypes.int4).named('related_num').nullable()();

  @override
  String? get tableName => 'folders';

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  $FoldersTableRelations get $relations => const $FoldersTableRelations();
}

class NoteTags extends Table with ElectricTableMixin {
  TextColumn get id => customType(ElectricTypes.uuid).named('id')();

  TextColumn get electricUserId =>
      customType(ElectricTypes.uuid).named('electric_user_id')();

  TextColumn get tagId =>
      customType(ElectricTypes.uuid).named('tag_id').nullable()();

  TextColumn get noteId =>
      customType(ElectricTypes.uuid).named('note_id').nullable()();

  @override
  String? get tableName => 'note_tags';

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  $NoteTagsTableRelations get $relations => const $NoteTagsTableRelations();
}

class Notes extends Table with ElectricTableMixin {
  TextColumn get id => customType(ElectricTypes.uuid).named('id')();

  TextColumn get folderId =>
      customType(ElectricTypes.uuid).named('folder_id').nullable()();

  TextColumn get electricUserId =>
      customType(ElectricTypes.uuid).named('electric_user_id')();

  TextColumn get content => text().named('content').nullable()();

  IntColumn get flag => customType(ElectricTypes.int2).named('flag')();

  IntColumn get status => customType(ElectricTypes.int2).named('status')();

  Column<DateTime> get createdAt =>
      customType(ElectricTypes.timestamp).named('created_at').nullable()();

  Column<DateTime> get updatedAt =>
      customType(ElectricTypes.timestamp).named('updated_at').nullable()();

  @override
  String? get tableName => 'notes';

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  $NotesTableRelations get $relations => const $NotesTableRelations();
}

class SchemaMigrations extends Table {
  TextColumn get version => text().named('version')();

  @override
  String? get tableName => 'schema_migrations';

  @override
  Set<Column<Object>>? get primaryKey => {version};
}

class Tags extends Table with ElectricTableMixin {
  TextColumn get id => customType(ElectricTypes.uuid).named('id')();

  TextColumn get electricUserId =>
      customType(ElectricTypes.uuid).named('electric_user_id')();

  TextColumn get name => text().named('name').nullable()();

  IntColumn get relatedNum =>
      customType(ElectricTypes.int4).named('related_num').nullable()();

  @override
  String? get tableName => 'tags';

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  $TagsTableRelations get $relations => const $TagsTableRelations();
}

// ------------------------------ RELATIONS ------------------------------

class $FoldersTableRelations implements TableRelations {
  const $FoldersTableRelations();

  TableRelation<Notes> get notes => const TableRelation<Notes>(
        fromField: '',
        toField: '',
        relationName: 'NotesToFolders',
      );

  @override
  List<TableRelation<Table>> get $relationsList => [notes];
}

class $NoteTagsTableRelations implements TableRelations {
  const $NoteTagsTableRelations();

  TableRelation<Notes> get notes => const TableRelation<Notes>(
        fromField: 'note_id',
        toField: 'id',
        relationName: 'NoteTagsToNotes',
      );

  TableRelation<Tags> get tags => const TableRelation<Tags>(
        fromField: 'tag_id',
        toField: 'id',
        relationName: 'NoteTagsToTags',
      );

  @override
  List<TableRelation<Table>> get $relationsList => [
        notes,
        tags,
      ];
}

class $NotesTableRelations implements TableRelations {
  const $NotesTableRelations();

  TableRelation<NoteTags> get noteTags => const TableRelation<NoteTags>(
        fromField: '',
        toField: '',
        relationName: 'NoteTagsToNotes',
      );

  TableRelation<Folders> get folders => const TableRelation<Folders>(
        fromField: 'folder_id',
        toField: 'id',
        relationName: 'NotesToFolders',
      );

  @override
  List<TableRelation<Table>> get $relationsList => [
        noteTags,
        folders,
      ];
}

class $TagsTableRelations implements TableRelations {
  const $TagsTableRelations();

  TableRelation<NoteTags> get noteTags => const TableRelation<NoteTags>(
        fromField: '',
        toField: '',
        relationName: 'NoteTagsToTags',
      );

  @override
  List<TableRelation<Table>> get $relationsList => [noteTags];
}
