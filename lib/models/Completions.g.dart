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
    r'dateCompleted': PropertySchema(
      id: 0,
      name: r'dateCompleted',
      type: IsarType.dateTime,
    ),
    r'habitID': PropertySchema(
      id: 1,
      name: r'habitID',
      type: IsarType.long,
    ),
    r'isCompleted': PropertySchema(
      id: 2,
      name: r'isCompleted',
      type: IsarType.bool,
    )
  },
  estimateSize: _completionsEstimateSize,
  serialize: _completionsSerialize,
  deserialize: _completionsDeserialize,
  deserializeProp: _completionsDeserializeProp,
  idName: r'id',
  indexes: {},
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
  return bytesCount;
}

void _completionsSerialize(
  Completions object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateCompleted);
  writer.writeLong(offsets[1], object.habitID);
  writer.writeBool(offsets[2], object.isCompleted);
}

Completions _completionsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Completions(
    dateCompleted: reader.readDateTimeOrNull(offsets[0]),
    habitID: reader.readLongOrNull(offsets[1]),
    isCompleted: reader.readBoolOrNull(offsets[2]),
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
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
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
}

extension CompletionsQueryFilter
    on QueryBuilder<Completions, Completions, QFilterCondition> {
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
}

extension CompletionsQueryObject
    on QueryBuilder<Completions, Completions, QFilterCondition> {}

extension CompletionsQueryLinks
    on QueryBuilder<Completions, Completions, QFilterCondition> {}

extension CompletionsQuerySortBy
    on QueryBuilder<Completions, Completions, QSortBy> {
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
}

extension CompletionsQuerySortThenBy
    on QueryBuilder<Completions, Completions, QSortThenBy> {
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
}

extension CompletionsQueryWhereDistinct
    on QueryBuilder<Completions, Completions, QDistinct> {
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
}

extension CompletionsQueryProperty
    on QueryBuilder<Completions, Completions, QQueryProperty> {
  QueryBuilder<Completions, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
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
}
