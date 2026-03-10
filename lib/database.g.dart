// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PagesTable extends Pages with TableInfo<$PagesTable, Page> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('page'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, name, type, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pages';
  @override
  VerificationContext validateIntegrity(Insertable<Page> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Page map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Page(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PagesTable createAlias(String alias) {
    return $PagesTable(attachedDatabase, alias);
  }
}

class Page extends DataClass implements Insertable<Page> {
  final int id;
  final String name;
  final String type;
  final DateTime createdAt;
  const Page(
      {required this.id,
      required this.name,
      required this.type,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PagesCompanion toCompanion(bool nullToAbsent) {
    return PagesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      createdAt: Value(createdAt),
    );
  }

  factory Page.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Page(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Page copyWith({int? id, String? name, String? type, DateTime? createdAt}) =>
      Page(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
      );
  Page copyWithCompanion(PagesCompanion data) {
    return Page(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Page(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Page &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.createdAt == this.createdAt);
}

class PagesCompanion extends UpdateCompanion<Page> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> type;
  final Value<DateTime> createdAt;
  const PagesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PagesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Page> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PagesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? type,
      Value<DateTime>? createdAt}) {
    return PagesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PagesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BlocksTable extends Blocks with TableInfo<$BlocksTable, Block> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pageIdMeta = const VerificationMeta('pageId');
  @override
  late final GeneratedColumn<String> pageId = GeneratedColumn<String>(
      'page_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES pages (name) ON DELETE CASCADE'));
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _indentMeta = const VerificationMeta('indent');
  @override
  late final GeneratedColumn<int> indent = GeneratedColumn<int>(
      'indent', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _dataJsonMeta =
      const VerificationMeta('dataJson');
  @override
  late final GeneratedColumn<String> dataJson = GeneratedColumn<String>(
      'data_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, pageId, orderIndex, indent, type, content, dataJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blocks';
  @override
  VerificationContext validateIntegrity(Insertable<Block> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('page_id')) {
      context.handle(_pageIdMeta,
          pageId.isAcceptableOrUnknown(data['page_id']!, _pageIdMeta));
    } else if (isInserting) {
      context.missing(_pageIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('indent')) {
      context.handle(_indentMeta,
          indent.isAcceptableOrUnknown(data['indent']!, _indentMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('data_json')) {
      context.handle(_dataJsonMeta,
          dataJson.isAcceptableOrUnknown(data['data_json']!, _dataJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Block map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Block(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      pageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}page_id'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
      indent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}indent'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      dataJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data_json'])!,
    );
  }

  @override
  $BlocksTable createAlias(String alias) {
    return $BlocksTable(attachedDatabase, alias);
  }
}

class Block extends DataClass implements Insertable<Block> {
  /// Block id (e.g. UUID string)
  final String id;

  /// Page identifier (page name)
  final String pageId;
  final int orderIndex;
  final int indent;
  final String type;
  final String content;
  final String dataJson;
  const Block(
      {required this.id,
      required this.pageId,
      required this.orderIndex,
      required this.indent,
      required this.type,
      required this.content,
      required this.dataJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['page_id'] = Variable<String>(pageId);
    map['order_index'] = Variable<int>(orderIndex);
    map['indent'] = Variable<int>(indent);
    map['type'] = Variable<String>(type);
    map['content'] = Variable<String>(content);
    map['data_json'] = Variable<String>(dataJson);
    return map;
  }

  BlocksCompanion toCompanion(bool nullToAbsent) {
    return BlocksCompanion(
      id: Value(id),
      pageId: Value(pageId),
      orderIndex: Value(orderIndex),
      indent: Value(indent),
      type: Value(type),
      content: Value(content),
      dataJson: Value(dataJson),
    );
  }

  factory Block.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Block(
      id: serializer.fromJson<String>(json['id']),
      pageId: serializer.fromJson<String>(json['pageId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      indent: serializer.fromJson<int>(json['indent']),
      type: serializer.fromJson<String>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      dataJson: serializer.fromJson<String>(json['dataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pageId': serializer.toJson<String>(pageId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'indent': serializer.toJson<int>(indent),
      'type': serializer.toJson<String>(type),
      'content': serializer.toJson<String>(content),
      'dataJson': serializer.toJson<String>(dataJson),
    };
  }

  Block copyWith(
          {String? id,
          String? pageId,
          int? orderIndex,
          int? indent,
          String? type,
          String? content,
          String? dataJson}) =>
      Block(
        id: id ?? this.id,
        pageId: pageId ?? this.pageId,
        orderIndex: orderIndex ?? this.orderIndex,
        indent: indent ?? this.indent,
        type: type ?? this.type,
        content: content ?? this.content,
        dataJson: dataJson ?? this.dataJson,
      );
  Block copyWithCompanion(BlocksCompanion data) {
    return Block(
      id: data.id.present ? data.id.value : this.id,
      pageId: data.pageId.present ? data.pageId.value : this.pageId,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      indent: data.indent.present ? data.indent.value : this.indent,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      dataJson: data.dataJson.present ? data.dataJson.value : this.dataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Block(')
          ..write('id: $id, ')
          ..write('pageId: $pageId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('indent: $indent, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('dataJson: $dataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pageId, orderIndex, indent, type, content, dataJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Block &&
          other.id == this.id &&
          other.pageId == this.pageId &&
          other.orderIndex == this.orderIndex &&
          other.indent == this.indent &&
          other.type == this.type &&
          other.content == this.content &&
          other.dataJson == this.dataJson);
}

class BlocksCompanion extends UpdateCompanion<Block> {
  final Value<String> id;
  final Value<String> pageId;
  final Value<int> orderIndex;
  final Value<int> indent;
  final Value<String> type;
  final Value<String> content;
  final Value<String> dataJson;
  final Value<int> rowid;
  const BlocksCompanion({
    this.id = const Value.absent(),
    this.pageId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.indent = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.dataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BlocksCompanion.insert({
    required String id,
    required String pageId,
    required int orderIndex,
    this.indent = const Value.absent(),
    required String type,
    this.content = const Value.absent(),
    this.dataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        pageId = Value(pageId),
        orderIndex = Value(orderIndex),
        type = Value(type);
  static Insertable<Block> custom({
    Expression<String>? id,
    Expression<String>? pageId,
    Expression<int>? orderIndex,
    Expression<int>? indent,
    Expression<String>? type,
    Expression<String>? content,
    Expression<String>? dataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pageId != null) 'page_id': pageId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (indent != null) 'indent': indent,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (dataJson != null) 'data_json': dataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BlocksCompanion copyWith(
      {Value<String>? id,
      Value<String>? pageId,
      Value<int>? orderIndex,
      Value<int>? indent,
      Value<String>? type,
      Value<String>? content,
      Value<String>? dataJson,
      Value<int>? rowid}) {
    return BlocksCompanion(
      id: id ?? this.id,
      pageId: pageId ?? this.pageId,
      orderIndex: orderIndex ?? this.orderIndex,
      indent: indent ?? this.indent,
      type: type ?? this.type,
      content: content ?? this.content,
      dataJson: dataJson ?? this.dataJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pageId.present) {
      map['page_id'] = Variable<String>(pageId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (indent.present) {
      map['indent'] = Variable<int>(indent.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (dataJson.present) {
      map['data_json'] = Variable<String>(dataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlocksCompanion(')
          ..write('id: $id, ')
          ..write('pageId: $pageId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('indent: $indent, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('dataJson: $dataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BlockLinksTable extends BlockLinks
    with TableInfo<$BlockLinksTable, BlockLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlockLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
      'source_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES blocks (id) ON DELETE CASCADE'));
  static const VerificationMeta _targetIdMeta =
      const VerificationMeta('targetId');
  @override
  late final GeneratedColumn<String> targetId = GeneratedColumn<String>(
      'target_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _linkTypeMeta =
      const VerificationMeta('linkType');
  @override
  late final GeneratedColumn<String> linkType = GeneratedColumn<String>(
      'link_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('ref'));
  @override
  List<GeneratedColumn> get $columns => [sourceId, targetId, linkType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'block_links';
  @override
  VerificationContext validateIntegrity(Insertable<BlockLink> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('target_id')) {
      context.handle(_targetIdMeta,
          targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta));
    } else if (isInserting) {
      context.missing(_targetIdMeta);
    }
    if (data.containsKey('link_type')) {
      context.handle(_linkTypeMeta,
          linkType.isAcceptableOrUnknown(data['link_type']!, _linkTypeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sourceId, targetId};
  @override
  BlockLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlockLink(
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_id'])!,
      targetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_id'])!,
      linkType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link_type'])!,
    );
  }

  @override
  $BlockLinksTable createAlias(String alias) {
    return $BlockLinksTable(attachedDatabase, alias);
  }
}

class BlockLink extends DataClass implements Insertable<BlockLink> {
  final String sourceId;
  final String targetId;
  final String linkType;
  const BlockLink(
      {required this.sourceId, required this.targetId, required this.linkType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['source_id'] = Variable<String>(sourceId);
    map['target_id'] = Variable<String>(targetId);
    map['link_type'] = Variable<String>(linkType);
    return map;
  }

  BlockLinksCompanion toCompanion(bool nullToAbsent) {
    return BlockLinksCompanion(
      sourceId: Value(sourceId),
      targetId: Value(targetId),
      linkType: Value(linkType),
    );
  }

  factory BlockLink.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlockLink(
      sourceId: serializer.fromJson<String>(json['sourceId']),
      targetId: serializer.fromJson<String>(json['targetId']),
      linkType: serializer.fromJson<String>(json['linkType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sourceId': serializer.toJson<String>(sourceId),
      'targetId': serializer.toJson<String>(targetId),
      'linkType': serializer.toJson<String>(linkType),
    };
  }

  BlockLink copyWith({String? sourceId, String? targetId, String? linkType}) =>
      BlockLink(
        sourceId: sourceId ?? this.sourceId,
        targetId: targetId ?? this.targetId,
        linkType: linkType ?? this.linkType,
      );
  BlockLink copyWithCompanion(BlockLinksCompanion data) {
    return BlockLink(
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      linkType: data.linkType.present ? data.linkType.value : this.linkType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlockLink(')
          ..write('sourceId: $sourceId, ')
          ..write('targetId: $targetId, ')
          ..write('linkType: $linkType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sourceId, targetId, linkType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlockLink &&
          other.sourceId == this.sourceId &&
          other.targetId == this.targetId &&
          other.linkType == this.linkType);
}

class BlockLinksCompanion extends UpdateCompanion<BlockLink> {
  final Value<String> sourceId;
  final Value<String> targetId;
  final Value<String> linkType;
  final Value<int> rowid;
  const BlockLinksCompanion({
    this.sourceId = const Value.absent(),
    this.targetId = const Value.absent(),
    this.linkType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BlockLinksCompanion.insert({
    required String sourceId,
    required String targetId,
    this.linkType = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : sourceId = Value(sourceId),
        targetId = Value(targetId);
  static Insertable<BlockLink> custom({
    Expression<String>? sourceId,
    Expression<String>? targetId,
    Expression<String>? linkType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sourceId != null) 'source_id': sourceId,
      if (targetId != null) 'target_id': targetId,
      if (linkType != null) 'link_type': linkType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BlockLinksCompanion copyWith(
      {Value<String>? sourceId,
      Value<String>? targetId,
      Value<String>? linkType,
      Value<int>? rowid}) {
    return BlockLinksCompanion(
      sourceId: sourceId ?? this.sourceId,
      targetId: targetId ?? this.targetId,
      linkType: linkType ?? this.linkType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (targetId.present) {
      map['target_id'] = Variable<String>(targetId.value);
    }
    if (linkType.present) {
      map['link_type'] = Variable<String>(linkType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlockLinksCompanion(')
          ..write('sourceId: $sourceId, ')
          ..write('targetId: $targetId, ')
          ..write('linkType: $linkType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PropertiesTable extends Properties
    with TableInfo<$PropertiesTable, Property> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _blockIdMeta =
      const VerificationMeta('blockId');
  @override
  late final GeneratedColumn<String> blockId = GeneratedColumn<String>(
      'block_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES blocks (id) ON DELETE CASCADE'));
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, blockId, key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'properties';
  @override
  VerificationContext validateIntegrity(Insertable<Property> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('block_id')) {
      context.handle(_blockIdMeta,
          blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta));
    } else if (isInserting) {
      context.missing(_blockIdMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {blockId, key},
      ];
  @override
  Property map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Property(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      blockId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}block_id'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $PropertiesTable createAlias(String alias) {
    return $PropertiesTable(attachedDatabase, alias);
  }
}

class Property extends DataClass implements Insertable<Property> {
  final int id;
  final String blockId;
  final String key;
  final String value;
  const Property(
      {required this.id,
      required this.blockId,
      required this.key,
      required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['block_id'] = Variable<String>(blockId);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  PropertiesCompanion toCompanion(bool nullToAbsent) {
    return PropertiesCompanion(
      id: Value(id),
      blockId: Value(blockId),
      key: Value(key),
      value: Value(value),
    );
  }

  factory Property.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Property(
      id: serializer.fromJson<int>(json['id']),
      blockId: serializer.fromJson<String>(json['blockId']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'blockId': serializer.toJson<String>(blockId),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  Property copyWith({int? id, String? blockId, String? key, String? value}) =>
      Property(
        id: id ?? this.id,
        blockId: blockId ?? this.blockId,
        key: key ?? this.key,
        value: value ?? this.value,
      );
  Property copyWithCompanion(PropertiesCompanion data) {
    return Property(
      id: data.id.present ? data.id.value : this.id,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Property(')
          ..write('id: $id, ')
          ..write('blockId: $blockId, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, blockId, key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Property &&
          other.id == this.id &&
          other.blockId == this.blockId &&
          other.key == this.key &&
          other.value == this.value);
}

class PropertiesCompanion extends UpdateCompanion<Property> {
  final Value<int> id;
  final Value<String> blockId;
  final Value<String> key;
  final Value<String> value;
  const PropertiesCompanion({
    this.id = const Value.absent(),
    this.blockId = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
  });
  PropertiesCompanion.insert({
    this.id = const Value.absent(),
    required String blockId,
    required String key,
    required String value,
  })  : blockId = Value(blockId),
        key = Value(key),
        value = Value(value);
  static Insertable<Property> custom({
    Expression<int>? id,
    Expression<String>? blockId,
    Expression<String>? key,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (blockId != null) 'block_id': blockId,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
    });
  }

  PropertiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? blockId,
      Value<String>? key,
      Value<String>? value}) {
    return PropertiesCompanion(
      id: id ?? this.id,
      blockId: blockId ?? this.blockId,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<String>(blockId.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PropertiesCompanion(')
          ..write('id: $id, ')
          ..write('blockId: $blockId, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PagesTable pages = $PagesTable(this);
  late final $BlocksTable blocks = $BlocksTable(this);
  late final $BlockLinksTable blockLinks = $BlockLinksTable(this);
  late final $PropertiesTable properties = $PropertiesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [pages, blocks, blockLinks, properties];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('pages',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('blocks', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('blocks',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('block_links', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('blocks',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('properties', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$PagesTableCreateCompanionBuilder = PagesCompanion Function({
  Value<int> id,
  required String name,
  Value<String> type,
  Value<DateTime> createdAt,
});
typedef $$PagesTableUpdateCompanionBuilder = PagesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> type,
  Value<DateTime> createdAt,
});

final class $$PagesTableReferences
    extends BaseReferences<_$AppDatabase, $PagesTable, Page> {
  $$PagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BlocksTable, List<Block>> _blocksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.blocks,
          aliasName: $_aliasNameGenerator(db.pages.name, db.blocks.pageId));

  $$BlocksTableProcessedTableManager get blocksRefs {
    final manager = $$BlocksTableTableManager($_db, $_db.blocks)
        .filter((f) => f.pageId.name.sqlEquals($_itemColumn<String>('name')!));

    final cache = $_typedResult.readTableOrNull(_blocksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PagesTableFilterComposer extends Composer<_$AppDatabase, $PagesTable> {
  $$PagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> blocksRefs(
      Expression<bool> Function($$BlocksTableFilterComposer f) f) {
    final $$BlocksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.name,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.pageId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableFilterComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PagesTableOrderingComposer
    extends Composer<_$AppDatabase, $PagesTable> {
  $$PagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$PagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PagesTable> {
  $$PagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> blocksRefs<T extends Object>(
      Expression<T> Function($$BlocksTableAnnotationComposer a) f) {
    final $$BlocksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.name,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.pageId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableAnnotationComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PagesTable,
    Page,
    $$PagesTableFilterComposer,
    $$PagesTableOrderingComposer,
    $$PagesTableAnnotationComposer,
    $$PagesTableCreateCompanionBuilder,
    $$PagesTableUpdateCompanionBuilder,
    (Page, $$PagesTableReferences),
    Page,
    PrefetchHooks Function({bool blocksRefs})> {
  $$PagesTableTableManager(_$AppDatabase db, $PagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PagesCompanion(
            id: id,
            name: name,
            type: type,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String> type = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PagesCompanion.insert(
            id: id,
            name: name,
            type: type,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PagesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({blocksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (blocksRefs) db.blocks],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (blocksRefs)
                    await $_getPrefetchedData<Page, $PagesTable, Block>(
                        currentTable: table,
                        referencedTable:
                            $$PagesTableReferences._blocksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PagesTableReferences(db, table, p0).blocksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.pageId == item.name),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PagesTable,
    Page,
    $$PagesTableFilterComposer,
    $$PagesTableOrderingComposer,
    $$PagesTableAnnotationComposer,
    $$PagesTableCreateCompanionBuilder,
    $$PagesTableUpdateCompanionBuilder,
    (Page, $$PagesTableReferences),
    Page,
    PrefetchHooks Function({bool blocksRefs})>;
typedef $$BlocksTableCreateCompanionBuilder = BlocksCompanion Function({
  required String id,
  required String pageId,
  required int orderIndex,
  Value<int> indent,
  required String type,
  Value<String> content,
  Value<String> dataJson,
  Value<int> rowid,
});
typedef $$BlocksTableUpdateCompanionBuilder = BlocksCompanion Function({
  Value<String> id,
  Value<String> pageId,
  Value<int> orderIndex,
  Value<int> indent,
  Value<String> type,
  Value<String> content,
  Value<String> dataJson,
  Value<int> rowid,
});

final class $$BlocksTableReferences
    extends BaseReferences<_$AppDatabase, $BlocksTable, Block> {
  $$BlocksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PagesTable _pageIdTable(_$AppDatabase db) => db.pages
      .createAlias($_aliasNameGenerator(db.blocks.pageId, db.pages.name));

  $$PagesTableProcessedTableManager get pageId {
    final $_column = $_itemColumn<String>('page_id')!;

    final manager = $$PagesTableTableManager($_db, $_db.pages)
        .filter((f) => f.name.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$BlockLinksTable, List<BlockLink>>
      _blockLinksRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.blockLinks,
              aliasName:
                  $_aliasNameGenerator(db.blocks.id, db.blockLinks.sourceId));

  $$BlockLinksTableProcessedTableManager get blockLinksRefs {
    final manager = $$BlockLinksTableTableManager($_db, $_db.blockLinks)
        .filter((f) => f.sourceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_blockLinksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PropertiesTable, List<Property>>
      _propertiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.properties,
          aliasName: $_aliasNameGenerator(db.blocks.id, db.properties.blockId));

  $$PropertiesTableProcessedTableManager get propertiesRefs {
    final manager = $$PropertiesTableTableManager($_db, $_db.properties)
        .filter((f) => f.blockId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_propertiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BlocksTableFilterComposer
    extends Composer<_$AppDatabase, $BlocksTable> {
  $$BlocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get indent => $composableBuilder(
      column: $table.indent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dataJson => $composableBuilder(
      column: $table.dataJson, builder: (column) => ColumnFilters(column));

  $$PagesTableFilterComposer get pageId {
    final $$PagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pageId,
        referencedTable: $db.pages,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PagesTableFilterComposer(
              $db: $db,
              $table: $db.pages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> blockLinksRefs(
      Expression<bool> Function($$BlockLinksTableFilterComposer f) f) {
    final $$BlockLinksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.blockLinks,
        getReferencedColumn: (t) => t.sourceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlockLinksTableFilterComposer(
              $db: $db,
              $table: $db.blockLinks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> propertiesRefs(
      Expression<bool> Function($$PropertiesTableFilterComposer f) f) {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.blockId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableFilterComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BlocksTableOrderingComposer
    extends Composer<_$AppDatabase, $BlocksTable> {
  $$BlocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get indent => $composableBuilder(
      column: $table.indent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dataJson => $composableBuilder(
      column: $table.dataJson, builder: (column) => ColumnOrderings(column));

  $$PagesTableOrderingComposer get pageId {
    final $$PagesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pageId,
        referencedTable: $db.pages,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PagesTableOrderingComposer(
              $db: $db,
              $table: $db.pages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlocksTable> {
  $$BlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);

  GeneratedColumn<int> get indent =>
      $composableBuilder(column: $table.indent, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get dataJson =>
      $composableBuilder(column: $table.dataJson, builder: (column) => column);

  $$PagesTableAnnotationComposer get pageId {
    final $$PagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pageId,
        referencedTable: $db.pages,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PagesTableAnnotationComposer(
              $db: $db,
              $table: $db.pages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> blockLinksRefs<T extends Object>(
      Expression<T> Function($$BlockLinksTableAnnotationComposer a) f) {
    final $$BlockLinksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.blockLinks,
        getReferencedColumn: (t) => t.sourceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlockLinksTableAnnotationComposer(
              $db: $db,
              $table: $db.blockLinks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> propertiesRefs<T extends Object>(
      Expression<T> Function($$PropertiesTableAnnotationComposer a) f) {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.blockId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableAnnotationComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BlocksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BlocksTable,
    Block,
    $$BlocksTableFilterComposer,
    $$BlocksTableOrderingComposer,
    $$BlocksTableAnnotationComposer,
    $$BlocksTableCreateCompanionBuilder,
    $$BlocksTableUpdateCompanionBuilder,
    (Block, $$BlocksTableReferences),
    Block,
    PrefetchHooks Function(
        {bool pageId, bool blockLinksRefs, bool propertiesRefs})> {
  $$BlocksTableTableManager(_$AppDatabase db, $BlocksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> pageId = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> indent = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> dataJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BlocksCompanion(
            id: id,
            pageId: pageId,
            orderIndex: orderIndex,
            indent: indent,
            type: type,
            content: content,
            dataJson: dataJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String pageId,
            required int orderIndex,
            Value<int> indent = const Value.absent(),
            required String type,
            Value<String> content = const Value.absent(),
            Value<String> dataJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BlocksCompanion.insert(
            id: id,
            pageId: pageId,
            orderIndex: orderIndex,
            indent: indent,
            type: type,
            content: content,
            dataJson: dataJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BlocksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {pageId = false,
              blockLinksRefs = false,
              propertiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (blockLinksRefs) db.blockLinks,
                if (propertiesRefs) db.properties
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (pageId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pageId,
                    referencedTable: $$BlocksTableReferences._pageIdTable(db),
                    referencedColumn:
                        $$BlocksTableReferences._pageIdTable(db).name,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (blockLinksRefs)
                    await $_getPrefetchedData<Block, $BlocksTable, BlockLink>(
                        currentTable: table,
                        referencedTable:
                            $$BlocksTableReferences._blockLinksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BlocksTableReferences(db, table, p0)
                                .blockLinksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.sourceId == item.id),
                        typedResults: items),
                  if (propertiesRefs)
                    await $_getPrefetchedData<Block, $BlocksTable, Property>(
                        currentTable: table,
                        referencedTable:
                            $$BlocksTableReferences._propertiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BlocksTableReferences(db, table, p0)
                                .propertiesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.blockId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BlocksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BlocksTable,
    Block,
    $$BlocksTableFilterComposer,
    $$BlocksTableOrderingComposer,
    $$BlocksTableAnnotationComposer,
    $$BlocksTableCreateCompanionBuilder,
    $$BlocksTableUpdateCompanionBuilder,
    (Block, $$BlocksTableReferences),
    Block,
    PrefetchHooks Function(
        {bool pageId, bool blockLinksRefs, bool propertiesRefs})>;
typedef $$BlockLinksTableCreateCompanionBuilder = BlockLinksCompanion Function({
  required String sourceId,
  required String targetId,
  Value<String> linkType,
  Value<int> rowid,
});
typedef $$BlockLinksTableUpdateCompanionBuilder = BlockLinksCompanion Function({
  Value<String> sourceId,
  Value<String> targetId,
  Value<String> linkType,
  Value<int> rowid,
});

final class $$BlockLinksTableReferences
    extends BaseReferences<_$AppDatabase, $BlockLinksTable, BlockLink> {
  $$BlockLinksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BlocksTable _sourceIdTable(_$AppDatabase db) => db.blocks
      .createAlias($_aliasNameGenerator(db.blockLinks.sourceId, db.blocks.id));

  $$BlocksTableProcessedTableManager get sourceId {
    final $_column = $_itemColumn<String>('source_id')!;

    final manager = $$BlocksTableTableManager($_db, $_db.blocks)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BlockLinksTableFilterComposer
    extends Composer<_$AppDatabase, $BlockLinksTable> {
  $$BlockLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get targetId => $composableBuilder(
      column: $table.targetId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkType => $composableBuilder(
      column: $table.linkType, builder: (column) => ColumnFilters(column));

  $$BlocksTableFilterComposer get sourceId {
    final $$BlocksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceId,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableFilterComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlockLinksTableOrderingComposer
    extends Composer<_$AppDatabase, $BlockLinksTable> {
  $$BlockLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get targetId => $composableBuilder(
      column: $table.targetId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkType => $composableBuilder(
      column: $table.linkType, builder: (column) => ColumnOrderings(column));

  $$BlocksTableOrderingComposer get sourceId {
    final $$BlocksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceId,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableOrderingComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlockLinksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlockLinksTable> {
  $$BlockLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get targetId =>
      $composableBuilder(column: $table.targetId, builder: (column) => column);

  GeneratedColumn<String> get linkType =>
      $composableBuilder(column: $table.linkType, builder: (column) => column);

  $$BlocksTableAnnotationComposer get sourceId {
    final $$BlocksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceId,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableAnnotationComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlockLinksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BlockLinksTable,
    BlockLink,
    $$BlockLinksTableFilterComposer,
    $$BlockLinksTableOrderingComposer,
    $$BlockLinksTableAnnotationComposer,
    $$BlockLinksTableCreateCompanionBuilder,
    $$BlockLinksTableUpdateCompanionBuilder,
    (BlockLink, $$BlockLinksTableReferences),
    BlockLink,
    PrefetchHooks Function({bool sourceId})> {
  $$BlockLinksTableTableManager(_$AppDatabase db, $BlockLinksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlockLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlockLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlockLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> sourceId = const Value.absent(),
            Value<String> targetId = const Value.absent(),
            Value<String> linkType = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BlockLinksCompanion(
            sourceId: sourceId,
            targetId: targetId,
            linkType: linkType,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String sourceId,
            required String targetId,
            Value<String> linkType = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BlockLinksCompanion.insert(
            sourceId: sourceId,
            targetId: targetId,
            linkType: linkType,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BlockLinksTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sourceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sourceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sourceId,
                    referencedTable:
                        $$BlockLinksTableReferences._sourceIdTable(db),
                    referencedColumn:
                        $$BlockLinksTableReferences._sourceIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BlockLinksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BlockLinksTable,
    BlockLink,
    $$BlockLinksTableFilterComposer,
    $$BlockLinksTableOrderingComposer,
    $$BlockLinksTableAnnotationComposer,
    $$BlockLinksTableCreateCompanionBuilder,
    $$BlockLinksTableUpdateCompanionBuilder,
    (BlockLink, $$BlockLinksTableReferences),
    BlockLink,
    PrefetchHooks Function({bool sourceId})>;
typedef $$PropertiesTableCreateCompanionBuilder = PropertiesCompanion Function({
  Value<int> id,
  required String blockId,
  required String key,
  required String value,
});
typedef $$PropertiesTableUpdateCompanionBuilder = PropertiesCompanion Function({
  Value<int> id,
  Value<String> blockId,
  Value<String> key,
  Value<String> value,
});

final class $$PropertiesTableReferences
    extends BaseReferences<_$AppDatabase, $PropertiesTable, Property> {
  $$PropertiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BlocksTable _blockIdTable(_$AppDatabase db) => db.blocks
      .createAlias($_aliasNameGenerator(db.properties.blockId, db.blocks.id));

  $$BlocksTableProcessedTableManager get blockId {
    final $_column = $_itemColumn<String>('block_id')!;

    final manager = $$BlocksTableTableManager($_db, $_db.blocks)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_blockIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PropertiesTableFilterComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  $$BlocksTableFilterComposer get blockId {
    final $$BlocksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.blockId,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableFilterComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PropertiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  $$BlocksTableOrderingComposer get blockId {
    final $$BlocksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.blockId,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableOrderingComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PropertiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  $$BlocksTableAnnotationComposer get blockId {
    final $$BlocksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.blockId,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableAnnotationComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PropertiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PropertiesTable,
    Property,
    $$PropertiesTableFilterComposer,
    $$PropertiesTableOrderingComposer,
    $$PropertiesTableAnnotationComposer,
    $$PropertiesTableCreateCompanionBuilder,
    $$PropertiesTableUpdateCompanionBuilder,
    (Property, $$PropertiesTableReferences),
    Property,
    PrefetchHooks Function({bool blockId})> {
  $$PropertiesTableTableManager(_$AppDatabase db, $PropertiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PropertiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PropertiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PropertiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> blockId = const Value.absent(),
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
          }) =>
              PropertiesCompanion(
            id: id,
            blockId: blockId,
            key: key,
            value: value,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String blockId,
            required String key,
            required String value,
          }) =>
              PropertiesCompanion.insert(
            id: id,
            blockId: blockId,
            key: key,
            value: value,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PropertiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({blockId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (blockId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.blockId,
                    referencedTable:
                        $$PropertiesTableReferences._blockIdTable(db),
                    referencedColumn:
                        $$PropertiesTableReferences._blockIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PropertiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PropertiesTable,
    Property,
    $$PropertiesTableFilterComposer,
    $$PropertiesTableOrderingComposer,
    $$PropertiesTableAnnotationComposer,
    $$PropertiesTableCreateCompanionBuilder,
    $$PropertiesTableUpdateCompanionBuilder,
    (Property, $$PropertiesTableReferences),
    Property,
    PrefetchHooks Function({bool blockId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PagesTableTableManager get pages =>
      $$PagesTableTableManager(_db, _db.pages);
  $$BlocksTableTableManager get blocks =>
      $$BlocksTableTableManager(_db, _db.blocks);
  $$BlockLinksTableTableManager get blockLinks =>
      $$BlockLinksTableTableManager(_db, _db.blockLinks);
  $$PropertiesTableTableManager get properties =>
      $$PropertiesTableTableManager(_db, _db.properties);
}
