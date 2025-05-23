// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Habit.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHabitCollection on Isar {
  IsarCollection<Habit> get habits => this.collection();
}

const HabitSchema = CollectionSchema(
  name: r'Habit',
  id: 3896650575830519340,
  properties: {
    r'ID': PropertySchema(
      id: 0,
      name: r'ID',
      type: IsarType.string,
    ),
    r'color': PropertySchema(
      id: 1,
      name: r'color',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'due_date': PropertySchema(
      id: 3,
      name: r'due_date',
      type: IsarType.dateTime,
    ),
    r'due_time': PropertySchema(
      id: 4,
      name: r'due_time',
      type: IsarType.dateTime,
    ),
    r'frequency_type': PropertySchema(
      id: 5,
      name: r'frequency_type',
      type: IsarType.long,
    ),
    r'isCompleted': PropertySchema(
      id: 6,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'start_date': PropertySchema(
      id: 7,
      name: r'start_date',
      type: IsarType.long,
    ),
    r'target_count': PropertySchema(
      id: 8,
      name: r'target_count',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 9,
      name: r'title',
      type: IsarType.string,
    ),
    r'userEmail': PropertySchema(
      id: 10,
      name: r'userEmail',
      type: IsarType.string,
    )
  },
  estimateSize: _habitEstimateSize,
  serialize: _habitSerialize,
  deserialize: _habitDeserialize,
  deserializeProp: _habitDeserializeProp,
  idName: r'id',
  indexes: {
    r'due_date': IndexSchema(
      id: 5383724208350099907,
      name: r'due_date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'due_date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
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
    r'userEmail': IndexSchema(
      id: -7139880982916714350,
      name: r'userEmail',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userEmail',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _habitGetId,
  getLinks: _habitGetLinks,
  attach: _habitAttach,
  version: '3.1.0+1',
);

int _habitEstimateSize(
  Habit object,
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
    final value = object.color;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
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

void _habitSerialize(
  Habit object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ID);
  writer.writeString(offsets[1], object.color);
  writer.writeString(offsets[2], object.description);
  writer.writeDateTime(offsets[3], object.due_date);
  writer.writeDateTime(offsets[4], object.due_time);
  writer.writeLong(offsets[5], object.frequency_type);
  writer.writeBool(offsets[6], object.isCompleted);
  writer.writeLong(offsets[7], object.start_date);
  writer.writeLong(offsets[8], object.target_count);
  writer.writeString(offsets[9], object.title);
  writer.writeString(offsets[10], object.userEmail);
}

Habit _habitDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Habit(
    ID: reader.readStringOrNull(offsets[0]),
    color: reader.readStringOrNull(offsets[1]),
    description: reader.readStringOrNull(offsets[2]),
    due_date: reader.readDateTimeOrNull(offsets[3]),
    due_time: reader.readDateTimeOrNull(offsets[4]),
    frequency_type: reader.readLongOrNull(offsets[5]),
    isCompleted: reader.readBoolOrNull(offsets[6]),
    start_date: reader.readLongOrNull(offsets[7]),
    target_count: reader.readLongOrNull(offsets[8]),
    title: reader.readStringOrNull(offsets[9]),
    userEmail: reader.readStringOrNull(offsets[10]),
  );
  object.id = id;
  return object;
}

P _habitDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _habitGetId(Habit object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _habitGetLinks(Habit object) {
  return [];
}

void _habitAttach(IsarCollection<dynamic> col, Id id, Habit object) {
  object.id = id;
}

extension HabitQueryWhereSort on QueryBuilder<Habit, Habit, QWhere> {
  QueryBuilder<Habit, Habit, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhere> anyDue_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'due_date'),
      );
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhere> anyIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isCompleted'),
      );
    });
  }
}

extension HabitQueryWhere on QueryBuilder<Habit, Habit, QWhereClause> {
  QueryBuilder<Habit, Habit, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Habit, Habit, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> idBetween(
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

  QueryBuilder<Habit, Habit, QAfterWhereClause> due_dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'due_date',
        value: [null],
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> due_dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'due_date',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> due_dateEqualTo(
      DateTime? due_date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'due_date',
        value: [due_date],
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> due_dateNotEqualTo(
      DateTime? due_date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'due_date',
              lower: [],
              upper: [due_date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'due_date',
              lower: [due_date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'due_date',
              lower: [due_date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'due_date',
              lower: [],
              upper: [due_date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> due_dateGreaterThan(
    DateTime? due_date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'due_date',
        lower: [due_date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> due_dateLessThan(
    DateTime? due_date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'due_date',
        lower: [],
        upper: [due_date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> due_dateBetween(
    DateTime? lowerDue_date,
    DateTime? upperDue_date, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'due_date',
        lower: [lowerDue_date],
        includeLower: includeLower,
        upper: [upperDue_date],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> isCompletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isCompleted',
        value: [null],
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> isCompletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isCompleted',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> isCompletedEqualTo(
      bool? isCompleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isCompleted',
        value: [isCompleted],
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> isCompletedNotEqualTo(
      bool? isCompleted) {
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

  QueryBuilder<Habit, Habit, QAfterWhereClause> userEmailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userEmail',
        value: [null],
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> userEmailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userEmail',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> userEmailEqualTo(
      String? userEmail) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userEmail',
        value: [userEmail],
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterWhereClause> userEmailNotEqualTo(
      String? userEmail) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userEmail',
              lower: [],
              upper: [userEmail],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userEmail',
              lower: [userEmail],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userEmail',
              lower: [userEmail],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userEmail',
              lower: [],
              upper: [userEmail],
              includeUpper: false,
            ));
      }
    });
  }
}

extension HabitQueryFilter on QueryBuilder<Habit, Habit, QFilterCondition> {
  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ID',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ID',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDEqualTo(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDGreaterThan(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDLessThan(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDBetween(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDStartsWith(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDEndsWith(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ID',
        value: '',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> iDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ID',
        value: '',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'due_date',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'due_date',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_dateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'due_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_dateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'due_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_dateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'due_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_dateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'due_date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_timeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'due_time',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_timeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'due_time',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_timeEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'due_time',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_timeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'due_time',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_timeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'due_time',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> due_timeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'due_time',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> frequency_typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'frequency_type',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> frequency_typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'frequency_type',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> frequency_typeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency_type',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> frequency_typeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequency_type',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> frequency_typeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequency_type',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> frequency_typeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequency_type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> isCompletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isCompleted',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> isCompletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isCompleted',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> isCompletedEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> start_dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'start_date',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> start_dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'start_date',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> start_dateEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'start_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> start_dateGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'start_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> start_dateLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'start_date',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> start_dateBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'start_date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> target_countIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'target_count',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> target_countIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'target_count',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> target_countEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'target_count',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> target_countGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'target_count',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> target_countLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'target_count',
        value: value,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> target_countBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'target_count',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userEmail',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userEmail',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailEqualTo(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailGreaterThan(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailLessThan(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailBetween(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailStartsWith(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailEndsWith(
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

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userEmail',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<Habit, Habit, QAfterFilterCondition> userEmailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userEmail',
        value: '',
      ));
    });
  }
}

extension HabitQueryObject on QueryBuilder<Habit, Habit, QFilterCondition> {}

extension HabitQueryLinks on QueryBuilder<Habit, Habit, QFilterCondition> {}

extension HabitQuerySortBy on QueryBuilder<Habit, Habit, QSortBy> {
  QueryBuilder<Habit, Habit, QAfterSortBy> sortByID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ID', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ID', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByDue_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due_date', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByDue_dateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due_date', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByDue_time() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due_time', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByDue_timeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due_time', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByFrequency_type() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency_type', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByFrequency_typeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency_type', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByStart_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start_date', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByStart_dateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start_date', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByTarget_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target_count', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByTarget_countDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target_count', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByUserEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userEmail', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> sortByUserEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userEmail', Sort.desc);
    });
  }
}

extension HabitQuerySortThenBy on QueryBuilder<Habit, Habit, QSortThenBy> {
  QueryBuilder<Habit, Habit, QAfterSortBy> thenByID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ID', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ID', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByDue_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due_date', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByDue_dateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due_date', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByDue_time() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due_time', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByDue_timeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due_time', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByFrequency_type() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency_type', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByFrequency_typeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency_type', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByStart_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start_date', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByStart_dateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start_date', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByTarget_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target_count', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByTarget_countDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target_count', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByUserEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userEmail', Sort.asc);
    });
  }

  QueryBuilder<Habit, Habit, QAfterSortBy> thenByUserEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userEmail', Sort.desc);
    });
  }
}

extension HabitQueryWhereDistinct on QueryBuilder<Habit, Habit, QDistinct> {
  QueryBuilder<Habit, Habit, QDistinct> distinctByID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Habit, Habit, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Habit, Habit, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Habit, Habit, QDistinct> distinctByDue_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'due_date');
    });
  }

  QueryBuilder<Habit, Habit, QDistinct> distinctByDue_time() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'due_time');
    });
  }

  QueryBuilder<Habit, Habit, QDistinct> distinctByFrequency_type() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frequency_type');
    });
  }

  QueryBuilder<Habit, Habit, QDistinct> distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<Habit, Habit, QDistinct> distinctByStart_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'start_date');
    });
  }

  QueryBuilder<Habit, Habit, QDistinct> distinctByTarget_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'target_count');
    });
  }

  QueryBuilder<Habit, Habit, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Habit, Habit, QDistinct> distinctByUserEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userEmail', caseSensitive: caseSensitive);
    });
  }
}

extension HabitQueryProperty on QueryBuilder<Habit, Habit, QQueryProperty> {
  QueryBuilder<Habit, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Habit, String?, QQueryOperations> IDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ID');
    });
  }

  QueryBuilder<Habit, String?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<Habit, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Habit, DateTime?, QQueryOperations> due_dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'due_date');
    });
  }

  QueryBuilder<Habit, DateTime?, QQueryOperations> due_timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'due_time');
    });
  }

  QueryBuilder<Habit, int?, QQueryOperations> frequency_typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequency_type');
    });
  }

  QueryBuilder<Habit, bool?, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<Habit, int?, QQueryOperations> start_dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'start_date');
    });
  }

  QueryBuilder<Habit, int?, QQueryOperations> target_countProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'target_count');
    });
  }

  QueryBuilder<Habit, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<Habit, String?, QQueryOperations> userEmailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userEmail');
    });
  }
}
