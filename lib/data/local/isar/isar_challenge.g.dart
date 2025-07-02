// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_challenge.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarChallengeCollection on Isar {
  IsarCollection<IsarChallenge> get isarChallenges => this.collection();
}

const IsarChallengeSchema = CollectionSchema(
  name: r'IsarChallenge',
  id: -3132415680451940567,
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
    r'status': PropertySchema(
      id: 2,
      name: r'status',
      type: IsarType.byte,
      enumMap: _IsarChallengestatusEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 3,
      name: r'type',
      type: IsarType.byte,
      enumMap: _IsarChallengetypeEnumValueMap,
    )
  },
  estimateSize: _isarChallengeEstimateSize,
  serialize: _isarChallengeSerialize,
  deserialize: _isarChallengeDeserialize,
  deserializeProp: _isarChallengeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarChallengeGetId,
  getLinks: _isarChallengeGetLinks,
  attach: _isarChallengeAttach,
  version: '3.1.8',
);

int _isarChallengeEstimateSize(
  IsarChallenge object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _isarChallengeSerialize(
  IsarChallenge object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeDateTime(offsets[1], object.dateTime);
  writer.writeByte(offsets[2], object.status.index);
  writer.writeByte(offsets[3], object.type.index);
}

IsarChallenge _isarChallengeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarChallenge();
  object.amount = reader.readLong(offsets[0]);
  object.dateTime = reader.readDateTime(offsets[1]);
  object.id = id;
  object.status =
      _IsarChallengestatusValueEnumMap[reader.readByteOrNull(offsets[2])] ??
          ChallengeStatus.notStarted;
  object.type =
      _IsarChallengetypeValueEnumMap[reader.readByteOrNull(offsets[3])] ??
          ChallengeType.noSpend;
  return object;
}

P _isarChallengeDeserializeProp<P>(
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
      return (_IsarChallengestatusValueEnumMap[reader.readByteOrNull(offset)] ??
          ChallengeStatus.notStarted) as P;
    case 3:
      return (_IsarChallengetypeValueEnumMap[reader.readByteOrNull(offset)] ??
          ChallengeType.noSpend) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarChallengestatusEnumValueMap = {
  'notStarted': 0,
  'ongoing': 1,
  'success': 2,
  'fail': 3,
};
const _IsarChallengestatusValueEnumMap = {
  0: ChallengeStatus.notStarted,
  1: ChallengeStatus.ongoing,
  2: ChallengeStatus.success,
  3: ChallengeStatus.fail,
};
const _IsarChallengetypeEnumValueMap = {
  'noSpend': 0,
  'threeDays': 1,
  'weekly': 2,
  'twoWeeks': 3,
};
const _IsarChallengetypeValueEnumMap = {
  0: ChallengeType.noSpend,
  1: ChallengeType.threeDays,
  2: ChallengeType.weekly,
  3: ChallengeType.twoWeeks,
};

Id _isarChallengeGetId(IsarChallenge object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarChallengeGetLinks(IsarChallenge object) {
  return [];
}

void _isarChallengeAttach(
    IsarCollection<dynamic> col, Id id, IsarChallenge object) {
  object.id = id;
}

extension IsarChallengeQueryWhereSort
    on QueryBuilder<IsarChallenge, IsarChallenge, QWhere> {
  QueryBuilder<IsarChallenge, IsarChallenge, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarChallengeQueryWhere
    on QueryBuilder<IsarChallenge, IsarChallenge, QWhereClause> {
  QueryBuilder<IsarChallenge, IsarChallenge, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterWhereClause> idBetween(
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

extension IsarChallengeQueryFilter
    on QueryBuilder<IsarChallenge, IsarChallenge, QFilterCondition> {
  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      amountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      amountGreaterThan(
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

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      amountLessThan(
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

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      amountBetween(
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

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
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

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      dateTimeLessThan(
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

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      dateTimeBetween(
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

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      statusEqualTo(ChallengeStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      statusGreaterThan(
    ChallengeStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      statusLessThan(
    ChallengeStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      statusBetween(
    ChallengeStatus lower,
    ChallengeStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition> typeEqualTo(
      ChallengeType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      typeGreaterThan(
    ChallengeType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition>
      typeLessThan(
    ChallengeType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterFilterCondition> typeBetween(
    ChallengeType lower,
    ChallengeType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarChallengeQueryObject
    on QueryBuilder<IsarChallenge, IsarChallenge, QFilterCondition> {}

extension IsarChallengeQueryLinks
    on QueryBuilder<IsarChallenge, IsarChallenge, QFilterCondition> {}

extension IsarChallengeQuerySortBy
    on QueryBuilder<IsarChallenge, IsarChallenge, QSortBy> {
  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension IsarChallengeQuerySortThenBy
    on QueryBuilder<IsarChallenge, IsarChallenge, QSortThenBy> {
  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension IsarChallengeQueryWhereDistinct
    on QueryBuilder<IsarChallenge, IsarChallenge, QDistinct> {
  QueryBuilder<IsarChallenge, IsarChallenge, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<IsarChallenge, IsarChallenge, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension IsarChallengeQueryProperty
    on QueryBuilder<IsarChallenge, IsarChallenge, QQueryProperty> {
  QueryBuilder<IsarChallenge, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarChallenge, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<IsarChallenge, DateTime, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<IsarChallenge, ChallengeStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<IsarChallenge, ChallengeType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
