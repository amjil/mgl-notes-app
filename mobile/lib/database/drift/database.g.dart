// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FoldersTable extends Folders with TableInfo<$FoldersTable, Folder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoldersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
      'parent_id', aliasedName, true,
      type: ElectricTypes.uuid, requiredDuringInsert: false);
  static const VerificationMeta _electricUserIdMeta =
      const VerificationMeta('electricUserId');
  @override
  late final GeneratedColumn<String> electricUserId = GeneratedColumn<String>(
      'electric_user_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderNumMeta =
      const VerificationMeta('orderNum');
  @override
  late final GeneratedColumn<int> orderNum = GeneratedColumn<int>(
      'order_num', aliasedName, true,
      type: ElectricTypes.int4, requiredDuringInsert: false);
  static const VerificationMeta _relatedNumMeta =
      const VerificationMeta('relatedNum');
  @override
  late final GeneratedColumn<int> relatedNum = GeneratedColumn<int>(
      'related_num', aliasedName, true,
      type: ElectricTypes.int4, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, parentId, electricUserId, name, orderNum, relatedNum];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'folders';
  @override
  VerificationContext validateIntegrity(Insertable<Folder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('electric_user_id')) {
      context.handle(
          _electricUserIdMeta,
          electricUserId.isAcceptableOrUnknown(
              data['electric_user_id']!, _electricUserIdMeta));
    } else if (isInserting) {
      context.missing(_electricUserIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('order_num')) {
      context.handle(_orderNumMeta,
          orderNum.isAcceptableOrUnknown(data['order_num']!, _orderNumMeta));
    }
    if (data.containsKey('related_num')) {
      context.handle(
          _relatedNumMeta,
          relatedNum.isAcceptableOrUnknown(
              data['related_num']!, _relatedNumMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Folder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Folder(
      id: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}id'])!,
      parentId: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}parent_id']),
      electricUserId: attachedDatabase.typeMapping.read(
          ElectricTypes.uuid, data['${effectivePrefix}electric_user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      orderNum: attachedDatabase.typeMapping
          .read(ElectricTypes.int4, data['${effectivePrefix}order_num']),
      relatedNum: attachedDatabase.typeMapping
          .read(ElectricTypes.int4, data['${effectivePrefix}related_num']),
    );
  }

  @override
  $FoldersTable createAlias(String alias) {
    return $FoldersTable(attachedDatabase, alias);
  }
}

class Folder extends DataClass implements Insertable<Folder> {
  final String id;
  final String? parentId;
  final String electricUserId;
  final String? name;
  final int? orderNum;
  final int? relatedNum;
  const Folder(
      {required this.id,
      this.parentId,
      required this.electricUserId,
      this.name,
      this.orderNum,
      this.relatedNum});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id, ElectricTypes.uuid);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId, ElectricTypes.uuid);
    }
    map['electric_user_id'] =
        Variable<String>(electricUserId, ElectricTypes.uuid);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || orderNum != null) {
      map['order_num'] = Variable<int>(orderNum, ElectricTypes.int4);
    }
    if (!nullToAbsent || relatedNum != null) {
      map['related_num'] = Variable<int>(relatedNum, ElectricTypes.int4);
    }
    return map;
  }

  FoldersCompanion toCompanion(bool nullToAbsent) {
    return FoldersCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      electricUserId: Value(electricUserId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      orderNum: orderNum == null && nullToAbsent
          ? const Value.absent()
          : Value(orderNum),
      relatedNum: relatedNum == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedNum),
    );
  }

  factory Folder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Folder(
      id: serializer.fromJson<String>(json['id']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      electricUserId: serializer.fromJson<String>(json['electricUserId']),
      name: serializer.fromJson<String?>(json['name']),
      orderNum: serializer.fromJson<int?>(json['orderNum']),
      relatedNum: serializer.fromJson<int?>(json['relatedNum']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'parentId': serializer.toJson<String?>(parentId),
      'electricUserId': serializer.toJson<String>(electricUserId),
      'name': serializer.toJson<String?>(name),
      'orderNum': serializer.toJson<int?>(orderNum),
      'relatedNum': serializer.toJson<int?>(relatedNum),
    };
  }

  Folder copyWith(
          {String? id,
          Value<String?> parentId = const Value.absent(),
          String? electricUserId,
          Value<String?> name = const Value.absent(),
          Value<int?> orderNum = const Value.absent(),
          Value<int?> relatedNum = const Value.absent()}) =>
      Folder(
        id: id ?? this.id,
        parentId: parentId.present ? parentId.value : this.parentId,
        electricUserId: electricUserId ?? this.electricUserId,
        name: name.present ? name.value : this.name,
        orderNum: orderNum.present ? orderNum.value : this.orderNum,
        relatedNum: relatedNum.present ? relatedNum.value : this.relatedNum,
      );
  @override
  String toString() {
    return (StringBuffer('Folder(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('name: $name, ')
          ..write('orderNum: $orderNum, ')
          ..write('relatedNum: $relatedNum')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, parentId, electricUserId, name, orderNum, relatedNum);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Folder &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.electricUserId == this.electricUserId &&
          other.name == this.name &&
          other.orderNum == this.orderNum &&
          other.relatedNum == this.relatedNum);
}

class FoldersCompanion extends UpdateCompanion<Folder> {
  final Value<String> id;
  final Value<String?> parentId;
  final Value<String> electricUserId;
  final Value<String?> name;
  final Value<int?> orderNum;
  final Value<int?> relatedNum;
  final Value<int> rowid;
  const FoldersCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.electricUserId = const Value.absent(),
    this.name = const Value.absent(),
    this.orderNum = const Value.absent(),
    this.relatedNum = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoldersCompanion.insert({
    required String id,
    this.parentId = const Value.absent(),
    required String electricUserId,
    this.name = const Value.absent(),
    this.orderNum = const Value.absent(),
    this.relatedNum = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        electricUserId = Value(electricUserId);
  static Insertable<Folder> custom({
    Expression<String>? id,
    Expression<String>? parentId,
    Expression<String>? electricUserId,
    Expression<String>? name,
    Expression<int>? orderNum,
    Expression<int>? relatedNum,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (electricUserId != null) 'electric_user_id': electricUserId,
      if (name != null) 'name': name,
      if (orderNum != null) 'order_num': orderNum,
      if (relatedNum != null) 'related_num': relatedNum,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoldersCompanion copyWith(
      {Value<String>? id,
      Value<String?>? parentId,
      Value<String>? electricUserId,
      Value<String?>? name,
      Value<int?>? orderNum,
      Value<int?>? relatedNum,
      Value<int>? rowid}) {
    return FoldersCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      electricUserId: electricUserId ?? this.electricUserId,
      name: name ?? this.name,
      orderNum: orderNum ?? this.orderNum,
      relatedNum: relatedNum ?? this.relatedNum,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value, ElectricTypes.uuid);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value, ElectricTypes.uuid);
    }
    if (electricUserId.present) {
      map['electric_user_id'] =
          Variable<String>(electricUserId.value, ElectricTypes.uuid);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (orderNum.present) {
      map['order_num'] = Variable<int>(orderNum.value, ElectricTypes.int4);
    }
    if (relatedNum.present) {
      map['related_num'] = Variable<int>(relatedNum.value, ElectricTypes.int4);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoldersCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('name: $name, ')
          ..write('orderNum: $orderNum, ')
          ..write('relatedNum: $relatedNum, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NoteTagsTable extends NoteTags with TableInfo<$NoteTagsTable, NoteTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _electricUserIdMeta =
      const VerificationMeta('electricUserId');
  @override
  late final GeneratedColumn<String> electricUserId = GeneratedColumn<String>(
      'electric_user_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
      'tag_id', aliasedName, true,
      type: ElectricTypes.uuid, requiredDuringInsert: false);
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<String> noteId = GeneratedColumn<String>(
      'note_id', aliasedName, true,
      type: ElectricTypes.uuid, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, electricUserId, tagId, noteId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'note_tags';
  @override
  VerificationContext validateIntegrity(Insertable<NoteTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('electric_user_id')) {
      context.handle(
          _electricUserIdMeta,
          electricUserId.isAcceptableOrUnknown(
              data['electric_user_id']!, _electricUserIdMeta));
    } else if (isInserting) {
      context.missing(_electricUserIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    }
    if (data.containsKey('note_id')) {
      context.handle(_noteIdMeta,
          noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteTag(
      id: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}id'])!,
      electricUserId: attachedDatabase.typeMapping.read(
          ElectricTypes.uuid, data['${effectivePrefix}electric_user_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}tag_id']),
      noteId: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}note_id']),
    );
  }

  @override
  $NoteTagsTable createAlias(String alias) {
    return $NoteTagsTable(attachedDatabase, alias);
  }
}

class NoteTag extends DataClass implements Insertable<NoteTag> {
  final String id;
  final String electricUserId;
  final String? tagId;
  final String? noteId;
  const NoteTag(
      {required this.id,
      required this.electricUserId,
      this.tagId,
      this.noteId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id, ElectricTypes.uuid);
    map['electric_user_id'] =
        Variable<String>(electricUserId, ElectricTypes.uuid);
    if (!nullToAbsent || tagId != null) {
      map['tag_id'] = Variable<String>(tagId, ElectricTypes.uuid);
    }
    if (!nullToAbsent || noteId != null) {
      map['note_id'] = Variable<String>(noteId, ElectricTypes.uuid);
    }
    return map;
  }

  NoteTagsCompanion toCompanion(bool nullToAbsent) {
    return NoteTagsCompanion(
      id: Value(id),
      electricUserId: Value(electricUserId),
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
      noteId:
          noteId == null && nullToAbsent ? const Value.absent() : Value(noteId),
    );
  }

  factory NoteTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteTag(
      id: serializer.fromJson<String>(json['id']),
      electricUserId: serializer.fromJson<String>(json['electricUserId']),
      tagId: serializer.fromJson<String?>(json['tagId']),
      noteId: serializer.fromJson<String?>(json['noteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'electricUserId': serializer.toJson<String>(electricUserId),
      'tagId': serializer.toJson<String?>(tagId),
      'noteId': serializer.toJson<String?>(noteId),
    };
  }

  NoteTag copyWith(
          {String? id,
          String? electricUserId,
          Value<String?> tagId = const Value.absent(),
          Value<String?> noteId = const Value.absent()}) =>
      NoteTag(
        id: id ?? this.id,
        electricUserId: electricUserId ?? this.electricUserId,
        tagId: tagId.present ? tagId.value : this.tagId,
        noteId: noteId.present ? noteId.value : this.noteId,
      );
  @override
  String toString() {
    return (StringBuffer('NoteTag(')
          ..write('id: $id, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('tagId: $tagId, ')
          ..write('noteId: $noteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, electricUserId, tagId, noteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteTag &&
          other.id == this.id &&
          other.electricUserId == this.electricUserId &&
          other.tagId == this.tagId &&
          other.noteId == this.noteId);
}

class NoteTagsCompanion extends UpdateCompanion<NoteTag> {
  final Value<String> id;
  final Value<String> electricUserId;
  final Value<String?> tagId;
  final Value<String?> noteId;
  final Value<int> rowid;
  const NoteTagsCompanion({
    this.id = const Value.absent(),
    this.electricUserId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.noteId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NoteTagsCompanion.insert({
    required String id,
    required String electricUserId,
    this.tagId = const Value.absent(),
    this.noteId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        electricUserId = Value(electricUserId);
  static Insertable<NoteTag> custom({
    Expression<String>? id,
    Expression<String>? electricUserId,
    Expression<String>? tagId,
    Expression<String>? noteId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (electricUserId != null) 'electric_user_id': electricUserId,
      if (tagId != null) 'tag_id': tagId,
      if (noteId != null) 'note_id': noteId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NoteTagsCompanion copyWith(
      {Value<String>? id,
      Value<String>? electricUserId,
      Value<String?>? tagId,
      Value<String?>? noteId,
      Value<int>? rowid}) {
    return NoteTagsCompanion(
      id: id ?? this.id,
      electricUserId: electricUserId ?? this.electricUserId,
      tagId: tagId ?? this.tagId,
      noteId: noteId ?? this.noteId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value, ElectricTypes.uuid);
    }
    if (electricUserId.present) {
      map['electric_user_id'] =
          Variable<String>(electricUserId.value, ElectricTypes.uuid);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value, ElectricTypes.uuid);
    }
    if (noteId.present) {
      map['note_id'] = Variable<String>(noteId.value, ElectricTypes.uuid);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteTagsCompanion(')
          ..write('id: $id, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('tagId: $tagId, ')
          ..write('noteId: $noteId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _folderIdMeta =
      const VerificationMeta('folderId');
  @override
  late final GeneratedColumn<String> folderId = GeneratedColumn<String>(
      'folder_id', aliasedName, true,
      type: ElectricTypes.uuid, requiredDuringInsert: false);
  static const VerificationMeta _electricUserIdMeta =
      const VerificationMeta('electricUserId');
  @override
  late final GeneratedColumn<String> electricUserId = GeneratedColumn<String>(
      'electric_user_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _flagMeta = const VerificationMeta('flag');
  @override
  late final GeneratedColumn<int> flag = GeneratedColumn<int>(
      'flag', aliasedName, false,
      type: ElectricTypes.int2, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: ElectricTypes.int2, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: ElectricTypes.timestamp, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: ElectricTypes.timestamp, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        folderId,
        electricUserId,
        content,
        flag,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('folder_id')) {
      context.handle(_folderIdMeta,
          folderId.isAcceptableOrUnknown(data['folder_id']!, _folderIdMeta));
    }
    if (data.containsKey('electric_user_id')) {
      context.handle(
          _electricUserIdMeta,
          electricUserId.isAcceptableOrUnknown(
              data['electric_user_id']!, _electricUserIdMeta));
    } else if (isInserting) {
      context.missing(_electricUserIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('flag')) {
      context.handle(
          _flagMeta, flag.isAcceptableOrUnknown(data['flag']!, _flagMeta));
    } else if (isInserting) {
      context.missing(_flagMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}id'])!,
      folderId: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}folder_id']),
      electricUserId: attachedDatabase.typeMapping.read(
          ElectricTypes.uuid, data['${effectivePrefix}electric_user_id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      flag: attachedDatabase.typeMapping
          .read(ElectricTypes.int2, data['${effectivePrefix}flag'])!,
      status: attachedDatabase.typeMapping
          .read(ElectricTypes.int2, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(ElectricTypes.timestamp, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(ElectricTypes.timestamp, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final String id;
  final String? folderId;
  final String electricUserId;
  final String? content;
  final int flag;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Note(
      {required this.id,
      this.folderId,
      required this.electricUserId,
      this.content,
      required this.flag,
      required this.status,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id, ElectricTypes.uuid);
    if (!nullToAbsent || folderId != null) {
      map['folder_id'] = Variable<String>(folderId, ElectricTypes.uuid);
    }
    map['electric_user_id'] =
        Variable<String>(electricUserId, ElectricTypes.uuid);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['flag'] = Variable<int>(flag, ElectricTypes.int2);
    map['status'] = Variable<int>(status, ElectricTypes.int2);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] =
          Variable<DateTime>(createdAt, ElectricTypes.timestamp);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] =
          Variable<DateTime>(updatedAt, ElectricTypes.timestamp);
    }
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      folderId: folderId == null && nullToAbsent
          ? const Value.absent()
          : Value(folderId),
      electricUserId: Value(electricUserId),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      flag: Value(flag),
      status: Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<String>(json['id']),
      folderId: serializer.fromJson<String?>(json['folderId']),
      electricUserId: serializer.fromJson<String>(json['electricUserId']),
      content: serializer.fromJson<String?>(json['content']),
      flag: serializer.fromJson<int>(json['flag']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'folderId': serializer.toJson<String?>(folderId),
      'electricUserId': serializer.toJson<String>(electricUserId),
      'content': serializer.toJson<String?>(content),
      'flag': serializer.toJson<int>(flag),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Note copyWith(
          {String? id,
          Value<String?> folderId = const Value.absent(),
          String? electricUserId,
          Value<String?> content = const Value.absent(),
          int? flag,
          int? status,
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Note(
        id: id ?? this.id,
        folderId: folderId.present ? folderId.value : this.folderId,
        electricUserId: electricUserId ?? this.electricUserId,
        content: content.present ? content.value : this.content,
        flag: flag ?? this.flag,
        status: status ?? this.status,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('folderId: $folderId, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('content: $content, ')
          ..write('flag: $flag, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, folderId, electricUserId, content, flag,
      status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.folderId == this.folderId &&
          other.electricUserId == this.electricUserId &&
          other.content == this.content &&
          other.flag == this.flag &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<String?> folderId;
  final Value<String> electricUserId;
  final Value<String?> content;
  final Value<int> flag;
  final Value<int> status;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.folderId = const Value.absent(),
    this.electricUserId = const Value.absent(),
    this.content = const Value.absent(),
    this.flag = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    this.folderId = const Value.absent(),
    required String electricUserId,
    this.content = const Value.absent(),
    required int flag,
    required int status,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        electricUserId = Value(electricUserId),
        flag = Value(flag),
        status = Value(status);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<String>? folderId,
    Expression<String>? electricUserId,
    Expression<String>? content,
    Expression<int>? flag,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (folderId != null) 'folder_id': folderId,
      if (electricUserId != null) 'electric_user_id': electricUserId,
      if (content != null) 'content': content,
      if (flag != null) 'flag': flag,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith(
      {Value<String>? id,
      Value<String?>? folderId,
      Value<String>? electricUserId,
      Value<String?>? content,
      Value<int>? flag,
      Value<int>? status,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return NotesCompanion(
      id: id ?? this.id,
      folderId: folderId ?? this.folderId,
      electricUserId: electricUserId ?? this.electricUserId,
      content: content ?? this.content,
      flag: flag ?? this.flag,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value, ElectricTypes.uuid);
    }
    if (folderId.present) {
      map['folder_id'] = Variable<String>(folderId.value, ElectricTypes.uuid);
    }
    if (electricUserId.present) {
      map['electric_user_id'] =
          Variable<String>(electricUserId.value, ElectricTypes.uuid);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (flag.present) {
      map['flag'] = Variable<int>(flag.value, ElectricTypes.int2);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value, ElectricTypes.int2);
    }
    if (createdAt.present) {
      map['created_at'] =
          Variable<DateTime>(createdAt.value, ElectricTypes.timestamp);
    }
    if (updatedAt.present) {
      map['updated_at'] =
          Variable<DateTime>(updatedAt.value, ElectricTypes.timestamp);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('folderId: $folderId, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('content: $content, ')
          ..write('flag: $flag, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SchemaMigrationsTable extends SchemaMigrations
    with TableInfo<$SchemaMigrationsTable, SchemaMigration> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchemaMigrationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
      'version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [version];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schema_migrations';
  @override
  VerificationContext validateIntegrity(Insertable<SchemaMigration> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {version};
  @override
  SchemaMigration map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SchemaMigration(
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version'])!,
    );
  }

  @override
  $SchemaMigrationsTable createAlias(String alias) {
    return $SchemaMigrationsTable(attachedDatabase, alias);
  }
}

class SchemaMigration extends DataClass implements Insertable<SchemaMigration> {
  final String version;
  const SchemaMigration({required this.version});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<String>(version);
    return map;
  }

  SchemaMigrationsCompanion toCompanion(bool nullToAbsent) {
    return SchemaMigrationsCompanion(
      version: Value(version),
    );
  }

  factory SchemaMigration.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SchemaMigration(
      version: serializer.fromJson<String>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<String>(version),
    };
  }

  SchemaMigration copyWith({String? version}) => SchemaMigration(
        version: version ?? this.version,
      );
  @override
  String toString() {
    return (StringBuffer('SchemaMigration(')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => version.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SchemaMigration && other.version == this.version);
}

class SchemaMigrationsCompanion extends UpdateCompanion<SchemaMigration> {
  final Value<String> version;
  final Value<int> rowid;
  const SchemaMigrationsCompanion({
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SchemaMigrationsCompanion.insert({
    required String version,
    this.rowid = const Value.absent(),
  }) : version = Value(version);
  static Insertable<SchemaMigration> custom({
    Expression<String>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SchemaMigrationsCompanion copyWith(
      {Value<String>? version, Value<int>? rowid}) {
    return SchemaMigrationsCompanion(
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchemaMigrationsCompanion(')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _electricUserIdMeta =
      const VerificationMeta('electricUserId');
  @override
  late final GeneratedColumn<String> electricUserId = GeneratedColumn<String>(
      'electric_user_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _relatedNumMeta =
      const VerificationMeta('relatedNum');
  @override
  late final GeneratedColumn<int> relatedNum = GeneratedColumn<int>(
      'related_num', aliasedName, true,
      type: ElectricTypes.int4, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, electricUserId, name, relatedNum];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('electric_user_id')) {
      context.handle(
          _electricUserIdMeta,
          electricUserId.isAcceptableOrUnknown(
              data['electric_user_id']!, _electricUserIdMeta));
    } else if (isInserting) {
      context.missing(_electricUserIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('related_num')) {
      context.handle(
          _relatedNumMeta,
          relatedNum.isAcceptableOrUnknown(
              data['related_num']!, _relatedNumMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}id'])!,
      electricUserId: attachedDatabase.typeMapping.read(
          ElectricTypes.uuid, data['${effectivePrefix}electric_user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      relatedNum: attachedDatabase.typeMapping
          .read(ElectricTypes.int4, data['${effectivePrefix}related_num']),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String id;
  final String electricUserId;
  final String? name;
  final int? relatedNum;
  const Tag(
      {required this.id,
      required this.electricUserId,
      this.name,
      this.relatedNum});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id, ElectricTypes.uuid);
    map['electric_user_id'] =
        Variable<String>(electricUserId, ElectricTypes.uuid);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || relatedNum != null) {
      map['related_num'] = Variable<int>(relatedNum, ElectricTypes.int4);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      electricUserId: Value(electricUserId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      relatedNum: relatedNum == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedNum),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<String>(json['id']),
      electricUserId: serializer.fromJson<String>(json['electricUserId']),
      name: serializer.fromJson<String?>(json['name']),
      relatedNum: serializer.fromJson<int?>(json['relatedNum']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'electricUserId': serializer.toJson<String>(electricUserId),
      'name': serializer.toJson<String?>(name),
      'relatedNum': serializer.toJson<int?>(relatedNum),
    };
  }

  Tag copyWith(
          {String? id,
          String? electricUserId,
          Value<String?> name = const Value.absent(),
          Value<int?> relatedNum = const Value.absent()}) =>
      Tag(
        id: id ?? this.id,
        electricUserId: electricUserId ?? this.electricUserId,
        name: name.present ? name.value : this.name,
        relatedNum: relatedNum.present ? relatedNum.value : this.relatedNum,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('name: $name, ')
          ..write('relatedNum: $relatedNum')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, electricUserId, name, relatedNum);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.electricUserId == this.electricUserId &&
          other.name == this.name &&
          other.relatedNum == this.relatedNum);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> id;
  final Value<String> electricUserId;
  final Value<String?> name;
  final Value<int?> relatedNum;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.electricUserId = const Value.absent(),
    this.name = const Value.absent(),
    this.relatedNum = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String electricUserId,
    this.name = const Value.absent(),
    this.relatedNum = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        electricUserId = Value(electricUserId);
  static Insertable<Tag> custom({
    Expression<String>? id,
    Expression<String>? electricUserId,
    Expression<String>? name,
    Expression<int>? relatedNum,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (electricUserId != null) 'electric_user_id': electricUserId,
      if (name != null) 'name': name,
      if (relatedNum != null) 'related_num': relatedNum,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith(
      {Value<String>? id,
      Value<String>? electricUserId,
      Value<String?>? name,
      Value<int?>? relatedNum,
      Value<int>? rowid}) {
    return TagsCompanion(
      id: id ?? this.id,
      electricUserId: electricUserId ?? this.electricUserId,
      name: name ?? this.name,
      relatedNum: relatedNum ?? this.relatedNum,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value, ElectricTypes.uuid);
    }
    if (electricUserId.present) {
      map['electric_user_id'] =
          Variable<String>(electricUserId.value, ElectricTypes.uuid);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (relatedNum.present) {
      map['related_num'] = Variable<int>(relatedNum.value, ElectricTypes.int4);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('name: $name, ')
          ..write('relatedNum: $relatedNum, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $FoldersTable folders = $FoldersTable(this);
  late final $NoteTagsTable noteTags = $NoteTagsTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $SchemaMigrationsTable schemaMigrations =
      $SchemaMigrationsTable(this);
  late final $TagsTable tags = $TagsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [folders, noteTags, notes, schemaMigrations, tags];
}

typedef $$FoldersTableInsertCompanionBuilder = FoldersCompanion Function({
  required String id,
  Value<String?> parentId,
  required String electricUserId,
  Value<String?> name,
  Value<int?> orderNum,
  Value<int?> relatedNum,
  Value<int> rowid,
});
typedef $$FoldersTableUpdateCompanionBuilder = FoldersCompanion Function({
  Value<String> id,
  Value<String?> parentId,
  Value<String> electricUserId,
  Value<String?> name,
  Value<int?> orderNum,
  Value<int?> relatedNum,
  Value<int> rowid,
});

class $$FoldersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoldersTable,
    Folder,
    $$FoldersTableFilterComposer,
    $$FoldersTableOrderingComposer,
    $$FoldersTableProcessedTableManager,
    $$FoldersTableInsertCompanionBuilder,
    $$FoldersTableUpdateCompanionBuilder> {
  $$FoldersTableTableManager(_$AppDatabase db, $FoldersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$FoldersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$FoldersTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$FoldersTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<String> electricUserId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> orderNum = const Value.absent(),
            Value<int?> relatedNum = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FoldersCompanion(
            id: id,
            parentId: parentId,
            electricUserId: electricUserId,
            name: name,
            orderNum: orderNum,
            relatedNum: relatedNum,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            Value<String?> parentId = const Value.absent(),
            required String electricUserId,
            Value<String?> name = const Value.absent(),
            Value<int?> orderNum = const Value.absent(),
            Value<int?> relatedNum = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FoldersCompanion.insert(
            id: id,
            parentId: parentId,
            electricUserId: electricUserId,
            name: name,
            orderNum: orderNum,
            relatedNum: relatedNum,
            rowid: rowid,
          ),
        ));
}

class $$FoldersTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $FoldersTable,
    Folder,
    $$FoldersTableFilterComposer,
    $$FoldersTableOrderingComposer,
    $$FoldersTableProcessedTableManager,
    $$FoldersTableInsertCompanionBuilder,
    $$FoldersTableUpdateCompanionBuilder> {
  $$FoldersTableProcessedTableManager(super.$state);
}

class $$FoldersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $FoldersTable> {
  $$FoldersTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get parentId => $state.composableBuilder(
      column: $state.table.parentId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderNum => $state.composableBuilder(
      column: $state.table.orderNum,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get relatedNum => $state.composableBuilder(
      column: $state.table.relatedNum,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$FoldersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $FoldersTable> {
  $$FoldersTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get parentId => $state.composableBuilder(
      column: $state.table.parentId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderNum => $state.composableBuilder(
      column: $state.table.orderNum,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get relatedNum => $state.composableBuilder(
      column: $state.table.relatedNum,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$NoteTagsTableInsertCompanionBuilder = NoteTagsCompanion Function({
  required String id,
  required String electricUserId,
  Value<String?> tagId,
  Value<String?> noteId,
  Value<int> rowid,
});
typedef $$NoteTagsTableUpdateCompanionBuilder = NoteTagsCompanion Function({
  Value<String> id,
  Value<String> electricUserId,
  Value<String?> tagId,
  Value<String?> noteId,
  Value<int> rowid,
});

class $$NoteTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NoteTagsTable,
    NoteTag,
    $$NoteTagsTableFilterComposer,
    $$NoteTagsTableOrderingComposer,
    $$NoteTagsTableProcessedTableManager,
    $$NoteTagsTableInsertCompanionBuilder,
    $$NoteTagsTableUpdateCompanionBuilder> {
  $$NoteTagsTableTableManager(_$AppDatabase db, $NoteTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$NoteTagsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$NoteTagsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$NoteTagsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> electricUserId = const Value.absent(),
            Value<String?> tagId = const Value.absent(),
            Value<String?> noteId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NoteTagsCompanion(
            id: id,
            electricUserId: electricUserId,
            tagId: tagId,
            noteId: noteId,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String electricUserId,
            Value<String?> tagId = const Value.absent(),
            Value<String?> noteId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NoteTagsCompanion.insert(
            id: id,
            electricUserId: electricUserId,
            tagId: tagId,
            noteId: noteId,
            rowid: rowid,
          ),
        ));
}

class $$NoteTagsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $NoteTagsTable,
    NoteTag,
    $$NoteTagsTableFilterComposer,
    $$NoteTagsTableOrderingComposer,
    $$NoteTagsTableProcessedTableManager,
    $$NoteTagsTableInsertCompanionBuilder,
    $$NoteTagsTableUpdateCompanionBuilder> {
  $$NoteTagsTableProcessedTableManager(super.$state);
}

class $$NoteTagsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $NoteTagsTable> {
  $$NoteTagsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tagId => $state.composableBuilder(
      column: $state.table.tagId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get noteId => $state.composableBuilder(
      column: $state.table.noteId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$NoteTagsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $NoteTagsTable> {
  $$NoteTagsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tagId => $state.composableBuilder(
      column: $state.table.tagId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get noteId => $state.composableBuilder(
      column: $state.table.noteId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$NotesTableInsertCompanionBuilder = NotesCompanion Function({
  required String id,
  Value<String?> folderId,
  required String electricUserId,
  Value<String?> content,
  required int flag,
  required int status,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({
  Value<String> id,
  Value<String?> folderId,
  Value<String> electricUserId,
  Value<String?> content,
  Value<int> flag,
  Value<int> status,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$NotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableProcessedTableManager,
    $$NotesTableInsertCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder> {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$NotesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$NotesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$NotesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String?> folderId = const Value.absent(),
            Value<String> electricUserId = const Value.absent(),
            Value<String?> content = const Value.absent(),
            Value<int> flag = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotesCompanion(
            id: id,
            folderId: folderId,
            electricUserId: electricUserId,
            content: content,
            flag: flag,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            Value<String?> folderId = const Value.absent(),
            required String electricUserId,
            Value<String?> content = const Value.absent(),
            required int flag,
            required int status,
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotesCompanion.insert(
            id: id,
            folderId: folderId,
            electricUserId: electricUserId,
            content: content,
            flag: flag,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$NotesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableProcessedTableManager,
    $$NotesTableInsertCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder> {
  $$NotesTableProcessedTableManager(super.$state);
}

class $$NotesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get folderId => $state.composableBuilder(
      column: $state.table.folderId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get flag => $state.composableBuilder(
      column: $state.table.flag,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$NotesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get folderId => $state.composableBuilder(
      column: $state.table.folderId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get flag => $state.composableBuilder(
      column: $state.table.flag,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SchemaMigrationsTableInsertCompanionBuilder
    = SchemaMigrationsCompanion Function({
  required String version,
  Value<int> rowid,
});
typedef $$SchemaMigrationsTableUpdateCompanionBuilder
    = SchemaMigrationsCompanion Function({
  Value<String> version,
  Value<int> rowid,
});

class $$SchemaMigrationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SchemaMigrationsTable,
    SchemaMigration,
    $$SchemaMigrationsTableFilterComposer,
    $$SchemaMigrationsTableOrderingComposer,
    $$SchemaMigrationsTableProcessedTableManager,
    $$SchemaMigrationsTableInsertCompanionBuilder,
    $$SchemaMigrationsTableUpdateCompanionBuilder> {
  $$SchemaMigrationsTableTableManager(
      _$AppDatabase db, $SchemaMigrationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SchemaMigrationsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SchemaMigrationsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$SchemaMigrationsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> version = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SchemaMigrationsCompanion(
            version: version,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String version,
            Value<int> rowid = const Value.absent(),
          }) =>
              SchemaMigrationsCompanion.insert(
            version: version,
            rowid: rowid,
          ),
        ));
}

class $$SchemaMigrationsTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $SchemaMigrationsTable,
        SchemaMigration,
        $$SchemaMigrationsTableFilterComposer,
        $$SchemaMigrationsTableOrderingComposer,
        $$SchemaMigrationsTableProcessedTableManager,
        $$SchemaMigrationsTableInsertCompanionBuilder,
        $$SchemaMigrationsTableUpdateCompanionBuilder> {
  $$SchemaMigrationsTableProcessedTableManager(super.$state);
}

class $$SchemaMigrationsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SchemaMigrationsTable> {
  $$SchemaMigrationsTableFilterComposer(super.$state);
  ColumnFilters<String> get version => $state.composableBuilder(
      column: $state.table.version,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SchemaMigrationsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SchemaMigrationsTable> {
  $$SchemaMigrationsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get version => $state.composableBuilder(
      column: $state.table.version,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TagsTableInsertCompanionBuilder = TagsCompanion Function({
  required String id,
  required String electricUserId,
  Value<String?> name,
  Value<int?> relatedNum,
  Value<int> rowid,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<String> id,
  Value<String> electricUserId,
  Value<String?> name,
  Value<int?> relatedNum,
  Value<int> rowid,
});

class $$TagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableProcessedTableManager,
    $$TagsTableInsertCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder> {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TagsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TagsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$TagsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> electricUserId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> relatedNum = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TagsCompanion(
            id: id,
            electricUserId: electricUserId,
            name: name,
            relatedNum: relatedNum,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String electricUserId,
            Value<String?> name = const Value.absent(),
            Value<int?> relatedNum = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TagsCompanion.insert(
            id: id,
            electricUserId: electricUserId,
            name: name,
            relatedNum: relatedNum,
            rowid: rowid,
          ),
        ));
}

class $$TagsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableProcessedTableManager,
    $$TagsTableInsertCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder> {
  $$TagsTableProcessedTableManager(super.$state);
}

class $$TagsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get relatedNum => $state.composableBuilder(
      column: $state.table.relatedNum,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TagsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get relatedNum => $state.composableBuilder(
      column: $state.table.relatedNum,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$FoldersTableTableManager get folders =>
      $$FoldersTableTableManager(_db, _db.folders);
  $$NoteTagsTableTableManager get noteTags =>
      $$NoteTagsTableTableManager(_db, _db.noteTags);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$SchemaMigrationsTableTableManager get schemaMigrations =>
      $$SchemaMigrationsTableTableManager(_db, _db.schemaMigrations);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
}
