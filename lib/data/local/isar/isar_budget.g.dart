// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_budget.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarBudgetCollection on Isar {
  IsarCollection<IsarBudget> get isarBudgets => this.collection();
}

const IsarBudgetSchema = CollectionSchema(
  name: r'IsarBudget',
  id: -8370091448436913409,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.long,
    ),
    r'dateTime': PropertySchema(
      id: 1,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'groupBudgets': PropertySchema(
      id: 2,
      name: r'groupBudgets',
      type: IsarType.stringList,
    ),
    r'unit': PropertySchema(
      id: 3,
      name: r'unit',
      type: IsarType.string,
    )
  },
  estimateSize: _isarBudgetEstimateSize,
  serialize: _isarBudgetSerialize,
  deserialize: _isarBudgetDeserialize,
  deserializeProp: _isarBudgetDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarBudgetGetId,
  getLinks: _isarBudgetGetLinks,
  attach: _isarBudgetAttach,
  version: '3.1.8',
);

int _isarBudgetEstimateSize(
  IsarBudget object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.groupBudgets.length * 3;
  {
    for (var i = 0; i < object.groupBudgets.length; i++) {
      final value = object.groupBudgets[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.unit.length * 3;
  return bytesCount;
}

void _isarBudgetSerialize(
  IsarBudget object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeDateTime(offsets[1], object.dateTime);
  writer.writeStringList(offsets[2], object.groupBudgets);
  writer.writeString(offsets[3], object.unit);
}

IsarBudget _isarBudgetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarBudget();
  object.amount = reader.readLong(offsets[0]);
  object.dateTime = reader.readDateTime(offsets[1]);
  object.groupBudgets = reader.readStringList(offsets[2]) ?? [];
  object.id = id;
  object.unit = reader.readString(offsets[3]);
  return object;
}

P _isarBudgetDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarBudgetGetId(IsarBudget object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarBudgetGetLinks(IsarBudget object) {
  return [];
}

void _isarBudgetAttach(IsarCollection<dynamic> col, Id id, IsarBudget object) {
  object.id = id;
}

extension IsarBudgetQueryWhereSort
    on QueryBuilder<IsarBudget, IsarBudget, QWhere> {
  QueryBuilder<IsarBudget, IsarBudget, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarBudgetQueryWhere
    on QueryBuilder<IsarBudget, IsarBudget, QWhereClause> {
  QueryBuilder<IsarBudget, IsarBudget, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<IsarBudget, IsarBudget, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterWhereClause> idBetween(
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

extension IsarBudgetQueryFilter
    on QueryBuilder<IsarBudget, IsarBudget, QFilterCondition> {
  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> amountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> amountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> amountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> amountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> dateTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupBudgets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupBudgets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupBudgets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupBudgets',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupBudgets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupBudgets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupBudgets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupBudgets',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupBudgets',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupBudgets',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'groupBudgets',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'groupBudgets',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'groupBudgets',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'groupBudgets',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'groupBudgets',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition>
      groupBudgetsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'groupBudgets',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> unitContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> unitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterFilterCondition> unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }
}

extension IsarBudgetQueryObject
    on QueryBuilder<IsarBudget, IsarBudget, QFilterCondition> {}

extension IsarBudgetQueryLinks
    on QueryBuilder<IsarBudget, IsarBudget, QFilterCondition> {}

extension IsarBudgetQuerySortBy
    on QueryBuilder<IsarBudget, IsarBudget, QSortBy> {
  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> sortByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> sortByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension IsarBudgetQuerySortThenBy
    on QueryBuilder<IsarBudget, IsarBudget, QSortThenBy> {
  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> thenByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QAfterSortBy> thenByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension IsarBudgetQueryWhereDistinct
    on QueryBuilder<IsarBudget, IsarBudget, QDistinct> {
  QueryBuilder<IsarBudget, IsarBudget, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QDistinct> distinctByGroupBudgets() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupBudgets');
    });
  }

  QueryBuilder<IsarBudget, IsarBudget, QDistinct> distinctByUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unit', caseSensitive: caseSensitive);
    });
  }
}

extension IsarBudgetQueryProperty
    on QueryBuilder<IsarBudget, IsarBudget, QQueryProperty> {
  QueryBuilder<IsarBudget, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarBudget, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<IsarBudget, DateTime, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<IsarBudget, List<String>, QQueryOperations>
      groupBudgetsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupBudgets');
    });
  }

  QueryBuilder<IsarBudget, String, QQueryOperations> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unit');
    });
  }
}
