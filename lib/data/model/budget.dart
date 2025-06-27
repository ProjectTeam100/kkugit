import 'package:kkugit/data/model/group_budget.dart';

class Budget {
  final int? id;
  final DateTime dateTime; // 기준 날짜
  final String unit; // 단위
  final int amount; // 예산 금액
  final List<GroupBudget> groupBudgets; // 그룹별 예산

  Budget({
    this.id,
    required this.dateTime,
    required this.unit,
    required this.amount,
    required this.groupBudgets,
  });
}