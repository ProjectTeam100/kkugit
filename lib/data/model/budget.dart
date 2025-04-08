import 'package:hive/hive.dart';

part 'budget.g.dart';

@HiveType(typeId: 3)
class Budget extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final DateTime dateTime; //기준 날짜

  @HiveField(2)
  final String unit; //단위

  @HiveField(3)
  final int budget;

  @HiveField(4)
  final GroupBudget groupBudget; //그룹별 예산

  Budget({
    required this.id,
    required this.dateTime,
    required this.unit,
    required this.budget,
    required this.groupBudget,
  });
}

@HiveType(typeId: 4)
class GroupBudget {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int groupId;

  @HiveField(2)
  final int budget;

  GroupBudget({
    required this.id,
    required this.groupId,
    required this.budget,
  });
}