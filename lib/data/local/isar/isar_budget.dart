import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:kkugit/data/model/budget.dart';
import 'package:kkugit/data/model/group_budget.dart';

part 'isar_budget.g.dart';

@collection
class IsarBudget {
  Id id = Isar.autoIncrement;
  late DateTime dateTime; // 날짜
  late String unit; // 단위
  late int amount; // 예산
  late List<String> groupBudgets; // 그룹별 예산

  Budget toDomain() => Budget(
        id: id,
        dateTime: dateTime,
        unit: unit,
        amount: amount,
        groupBudgets: groupBudgets.map((e) => GroupBudget.fromJson(jsonDecode(e))).toList(),
  );

  static IsarBudget fromDomain(Budget budget) {
    return IsarBudget()
      ..id = budget.id ?? Isar.autoIncrement
      ..dateTime = budget.dateTime
      ..unit = budget.unit
      ..amount = budget.amount
      ..groupBudgets = budget.groupBudgets.map((e) => jsonEncode(e.toJson())).toList();
  }
}