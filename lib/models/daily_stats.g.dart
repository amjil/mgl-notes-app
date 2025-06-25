// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_stats.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyStatsCollection on Isar {
  IsarCollection<DailyStats> get dailyStats => this.collection();
}

const DailyStatsSchema = CollectionSchema(
  name: r'DailyStats',
  id: -7592871651347013517,
  properties: {
    r'blockCount': PropertySchema(
      id: 0,
      name: r'blockCount',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'hasActivity': PropertySchema(
      id: 2,
      name: r'hasActivity',
      type: IsarType.bool,
    ),
    r'noteCount': PropertySchema(
      id: 3,
      name: r'noteCount',
      type: IsarType.long,
    ),
    r'tags': PropertySchema(
      id: 4,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'wordCount': PropertySchema(
      id: 5,
      name: r'wordCount',
      type: IsarType.long,
    )
  },
  estimateSize: _dailyStatsEstimateSize,
  serialize: _dailyStatsSerialize,
  deserialize: _dailyStatsDeserialize,
  deserializeProp: _dailyStatsDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dailyStatsGetId,
  getLinks: _dailyStatsGetLinks,
  attach: _dailyStatsAttach,
  version: '3.1.0+1',
);

int _dailyStatsEstimateSize(
  DailyStats object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _dailyStatsSerialize(
  DailyStats object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.blockCount);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeBool(offsets[2], object.hasActivity);
  writer.writeLong(offsets[3], object.noteCount);
  writer.writeStringList(offsets[4], object.tags);
  writer.writeLong(offsets[5], object.wordCount);
}

DailyStats _dailyStatsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyStats(
    blockCount: reader.readLongOrNull(offsets[0]) ?? 0,
    date: reader.readDateTime(offsets[1]),
    noteCount: reader.readLongOrNull(offsets[3]) ?? 0,
    tags: reader.readStringList(offsets[4]) ?? [],
    wordCount: reader.readLongOrNull(offsets[5]) ?? 0,
  );
  object.id = id;
  return object;
}

P _dailyStatsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyStatsGetId(DailyStats object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyStatsGetLinks(DailyStats object) {
  return [];
}

void _dailyStatsAttach(IsarCollection<dynamic> col, Id id, DailyStats object) {
  object.id = id;
}

extension DailyStatsByIndex on IsarCollection<DailyStats> {
  Future<DailyStats?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  DailyStats? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<DailyStats?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<DailyStats?> getAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'date', values);
  }

  Future<int> deleteAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'date', values);
  }

  int deleteAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'date', values);
  }

  Future<Id> putByDate(DailyStats object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(DailyStats object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<DailyStats> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(List<DailyStats> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension DailyStatsQueryWhereSort
    on QueryBuilder<DailyStats, DailyStats, QWhere> {
  QueryBuilder<DailyStats, DailyStats, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension DailyStatsQueryWhere
    on QueryBuilder<DailyStats, DailyStats, QWhereClause> {
  QueryBuilder<DailyStats, DailyStats, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterWhereClause> dateEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterWhereClause> dateNotEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DailyStatsQueryFilter
    on QueryBuilder<DailyStats, DailyStats, QFilterCondition> {
  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> blockCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      blockCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      blockCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> blockCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      hasActivityEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasActivity',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> noteCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      noteCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'noteCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> noteCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'noteCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> noteCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'noteCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> tagsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> wordCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wordCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition>
      wordCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wordCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> wordCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wordCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterFilterCondition> wordCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wordCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DailyStatsQueryObject
    on QueryBuilder<DailyStats, DailyStats, QFilterCondition> {}

extension DailyStatsQueryLinks
    on QueryBuilder<DailyStats, DailyStats, QFilterCondition> {}

extension DailyStatsQuerySortBy
    on QueryBuilder<DailyStats, DailyStats, QSortBy> {
  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> sortByBlockCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCount', Sort.asc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> sortByBlockCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCount', Sort.desc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> sortByHasActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasActivity', Sort.asc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> sortByHasActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasActivity', Sort.desc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> sortByNoteCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteCount', Sort.asc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> sortByNoteCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteCount', Sort.desc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> sortByWordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wordCount', Sort.asc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> sortByWordCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wordCount', Sort.desc);
    });
  }
}

extension DailyStatsQuerySortThenBy
    on QueryBuilder<DailyStats, DailyStats, QSortThenBy> {
  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenByBlockCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCount', Sort.asc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenByBlockCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCount', Sort.desc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenByHasActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasActivity', Sort.asc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenByHasActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasActivity', Sort.desc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenByNoteCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteCount', Sort.asc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenByNoteCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteCount', Sort.desc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenByWordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wordCount', Sort.asc);
    });
  }

  QueryBuilder<DailyStats, DailyStats, QAfterSortBy> thenByWordCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wordCount', Sort.desc);
    });
  }
}

extension DailyStatsQueryWhereDistinct
    on QueryBuilder<DailyStats, DailyStats, QDistinct> {
  QueryBuilder<DailyStats, DailyStats, QDistinct> distinctByBlockCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockCount');
    });
  }

  QueryBuilder<DailyStats, DailyStats, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailyStats, DailyStats, QDistinct> distinctByHasActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasActivity');
    });
  }

  QueryBuilder<DailyStats, DailyStats, QDistinct> distinctByNoteCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'noteCount');
    });
  }

  QueryBuilder<DailyStats, DailyStats, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<DailyStats, DailyStats, QDistinct> distinctByWordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wordCount');
    });
  }
}

extension DailyStatsQueryProperty
    on QueryBuilder<DailyStats, DailyStats, QQueryProperty> {
  QueryBuilder<DailyStats, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyStats, int, QQueryOperations> blockCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockCount');
    });
  }

  QueryBuilder<DailyStats, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailyStats, bool, QQueryOperations> hasActivityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasActivity');
    });
  }

  QueryBuilder<DailyStats, int, QQueryOperations> noteCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'noteCount');
    });
  }

  QueryBuilder<DailyStats, List<String>, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<DailyStats, int, QQueryOperations> wordCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wordCount');
    });
  }
}
