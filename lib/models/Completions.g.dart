// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Completions.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompletionsCollection on Isar {
  IsarCollection<Completions> get completions => this.collection();
}

const CompletionsSchema = CollectionSchema(
  name: r'Completions',
  id: -2694847889342375707,
  properties: {
    r'ID': PropertySchema(
      id: 0,
      name: r'ID',
      type: IsarType.string,
    ),
    r'dateCompleted': PropertySchema(
      id: 1,
      name: r'dateCompleted',
      type: IsarType.dateTime,
    ),
    r'habitID': PropertySchema(
      id: 2,
      name: r'habitID',
      type: IsarType.long,
    ),
    r'isCompleted': PropertySchema(
      id: 3,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'lastModified': PropertySchema(
      id: 4,
      name: r'lastModified',
      type: IsarType.dateTime,
    ),
    r'needsSync': PropertySchema(
      id: 5,
      name: r'needsSync',
      type: IsarType.bool,
    ),
    r'userEmail': PropertySchema(
      id: 6,
      name: r'userEmail',
      type: IsarType.string,
    )
  },
  estimateSize: _completionsEstimateSize,
  serialize: _completionsSerialize,
  deserialize: _completionsDeserialize,
  deserializeProp: _completionsDeserializeProp,
  idName: r'id',
  indexes: {
    r'isCompleted': IndexSchema(
      id: -7936144632215868537,
      name: r'isCompleted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isCompleted',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'dateCompleted': IndexSchema(
      id: -681137986614012213,
      name: r'dateCompleted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateCompleted',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'needsSync': IndexSchema(
      id: 582046641891238027,
      name: r'needsSync',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'needsSync',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _completionsGetId,
  getLinks: _completionsGetLinks,
  attach: _completionsAttach,
  version: '3.1.0+1',
);

int _completionsEstimateSize(
  Completions object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.ID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userEmail;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _completionsSerialize(
  Completions object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ID);
  writer.writeDateTime(offsets[1], object.dateCompleted);
  writer.writeLong(offsets[2], object.habitID);
  writer.writeBool(offsets[3], object.isCompleted);
  writer.writeDateTime(offsets[4], object.lastModified);
  writer.writeBool(offsets[5], object.needsSync);
  writer.writeString(offsets[6], object.userEmail);
}

Completions _completionsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Completions(
    ID: reader.readStringOrNull(offsets[0]),
    dateCompleted: reader.readDateTimeOrNull(offsets[1]),
    habitID: reader.readLongOrNull(offsets[2]),
    isCompleted: reader.readBoolOrNull(offsets[3]),
    lastModified: reader.readDateTimeOrNull(offsets[4]),
    needsSync: reader.readBoolOrNull(offsets[5]) ?? false,
    userEmail: reader.readStringOrNull(offsets[6]),
  );
  object.id = id;
  return object;
}

P _completionsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _completionsGetId(Completions object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _completionsGetLinks(Completions object) {
  return [];
}

void _completionsAttach(
    IsarCollection<dynamic> col, Id id, Completions object) {
  object.id = id;
}

extension CompletionsQueryWhereSort
    on QueryBuilder<Completions, Completions, QWhere> {
  QueryBuilder<Completions, Completions, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhere> anyIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isCompleted'),
      );
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhere> anyDateCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dateCompleted'),
      );
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhere> anyNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'needsSync'),
      );
    });
  }
}

extension CompletionsQueryWhere
    on QueryBuilder<Completions, Completions, QWhereClause> {
  QueryBuilder<Completions, Completions, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<Completions, Completions, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause> idBetween(
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

  QueryBuilder<Completions, Completions, QAfterWhereClause>
      isCompletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isCompleted',
        value: [null],
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause>
      isCompletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isCompleted',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause> isCompletedEqualTo(
      bool? isCompleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isCompleted',
        value: [isCompleted],
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause>
      isCompletedNotEqualTo(bool? isCompleted) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCompleted',
              lower: [],
              upper: [isCompleted],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCompleted',
              lower: [isCompleted],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCompleted',
              lower: [isCompleted],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCompleted',
              lower: [],
              upper: [isCompleted],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause>
      dateCompletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateCompleted',
        value: [null],
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause>
      dateCompletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateCompleted',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause>
      dateCompletedEqualTo(DateTime? dateCompleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateCompleted',
        value: [dateCompleted],
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause>
      dateCompletedNotEqualTo(DateTime? dateCompleted) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateCompleted',
              lower: [],
              upper: [dateCompleted],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateCompleted',
              lower: [dateCompleted],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateCompleted',
              lower: [dateCompleted],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateCompleted',
              lower: [],
              upper: [dateCompleted],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause>
      dateCompletedGreaterThan(
    DateTime? dateCompleted, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateCompleted',
        lower: [dateCompleted],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause>
      dateCompletedLessThan(
    DateTime? dateCompleted, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateCompleted',
        lower: [],
        upper: [dateCompleted],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause>
      dateCompletedBetween(
    DateTime? lowerDateCompleted,
    DateTime? upperDateCompleted, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateCompleted',
        lower: [lowerDateCompleted],
        includeLower: includeLower,
        upper: [upperDateCompleted],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause> needsSyncEqualTo(
      bool needsSync) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'needsSync',
        value: [needsSync],
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterWhereClause> needsSyncNotEqualTo(
      bool needsSync) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'needsSync',
              lower: [],
              upper: [needsSync],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'needsSync',
              lower: [needsSync],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'needsSync',
              lower: [needsSync],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'needsSync',
              lower: [],
              upper: [needsSync],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CompletionsQueryFilter
    on QueryBuilder<Completions, Completions, QFilterCondition> {
  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ID',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ID',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ID',
        value: '',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> iDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ID',
        value: '',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      dateCompletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateCompleted',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      dateCompletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateCompleted',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      dateCompletedEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      dateCompletedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      dateCompletedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      dateCompletedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateCompleted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      habitIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'habitID',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      habitIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'habitID',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> habitIDEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'habitID',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      habitIDGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'habitID',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> habitIDLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'habitID',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> habitIDBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'habitID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Completions, Completions, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Completions, Completions, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      isCompletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isCompleted',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      isCompletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isCompleted',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      isCompletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      lastModifiedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastModified',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      lastModifiedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastModified',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      lastModifiedEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastModified',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      lastModifiedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastModified',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      lastModifiedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastModified',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      lastModifiedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastModified',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      needsSyncEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'needsSync',
        value: value,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userEmail',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userEmail',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userEmail',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userEmail',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<Completions, Completions, QAfterFilterCondition>
      userEmailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userEmail',
        value: '',
      ));
    });
  }
}

extension CompletionsQueryObject
    on QueryBuilder<Completions, Completions, QFilterCondition> {}

extension CompletionsQueryLinks
    on QueryBuilder<Completions, Completions, QFilterCondition> {}

extension CompletionsQuerySortBy
    on QueryBuilder<Completions, Completions, QSortBy> {
  QueryBuilder<Completions, Completions, QAfterSortBy> sortByID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ID', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> sortByIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ID', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> sortByDateCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateCompleted', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy>
      sortByDateCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateCompleted', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> sortByHabitID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitID', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> sortByHabitIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitID', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> sortByLastModified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy>
      sortByLastModifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> sortByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> sortByNeedsSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> sortByUserEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userEmail', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> sortByUserEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userEmail', Sort.desc);
    });
  }
}

extension CompletionsQuerySortThenBy
    on QueryBuilder<Completions, Completions, QSortThenBy> {
  QueryBuilder<Completions, Completions, QAfterSortBy> thenByID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ID', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ID', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByDateCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateCompleted', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy>
      thenByDateCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateCompleted', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByHabitID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitID', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByHabitIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitID', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByLastModified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy>
      thenByLastModifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByNeedsSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.desc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByUserEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userEmail', Sort.asc);
    });
  }

  QueryBuilder<Completions, Completions, QAfterSortBy> thenByUserEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userEmail', Sort.desc);
    });
  }
}

extension CompletionsQueryWhereDistinct
    on QueryBuilder<Completions, Completions, QDistinct> {
  QueryBuilder<Completions, Completions, QDistinct> distinctByID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Completions, Completions, QDistinct> distinctByDateCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateCompleted');
    });
  }

  QueryBuilder<Completions, Completions, QDistinct> distinctByHabitID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'habitID');
    });
  }

  QueryBuilder<Completions, Completions, QDistinct> distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<Completions, Completions, QDistinct> distinctByLastModified() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastModified');
    });
  }

  QueryBuilder<Completions, Completions, QDistinct> distinctByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'needsSync');
    });
  }

  QueryBuilder<Completions, Completions, QDistinct> distinctByUserEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userEmail', caseSensitive: caseSensitive);
    });
  }
}

extension CompletionsQueryProperty
    on QueryBuilder<Completions, Completions, QQueryProperty> {
  QueryBuilder<Completions, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Completions, String?, QQueryOperations> IDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ID');
    });
  }

  QueryBuilder<Completions, DateTime?, QQueryOperations>
      dateCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateCompleted');
    });
  }

  QueryBuilder<Completions, int?, QQueryOperations> habitIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'habitID');
    });
  }

  QueryBuilder<Completions, bool?, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<Completions, DateTime?, QQueryOperations>
      lastModifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastModified');
    });
  }

  QueryBuilder<Completions, bool, QQueryOperations> needsSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'needsSync');
    });
  }

  QueryBuilder<Completions, String?, QQueryOperations> userEmailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userEmail');
    });
  }
}
