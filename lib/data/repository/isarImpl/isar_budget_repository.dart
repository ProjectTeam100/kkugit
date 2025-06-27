import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:kkugit/data/local/isar/isar_budget.dart';
import 'package:kkugit/data/model/budget.dart';
import 'package:kkugit/data/model/group_budget.dart';
import 'package:kkugit/data/repository/budget_repository.dart';

@LazySingleton(as: BudgetRepository)
class IsarBudgetRepository implements BudgetRepository {
  final Isar _isar;

  IsarBudgetRepository(this._isar);

  @override
  Future<void> add(Budget budget) async {
    final entity = IsarBudget.fromDomain(budget);
    await _isar.writeTxn(() => _isar.isarBudgets.put(entity));
  }

  @override
  Future<void> update(Budget budget) async {
    final entity = IsarBudget.fromDomain(budget);
    await _isar.writeTxn(() => _isar.isarBudgets.put(entity));
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() => _isar.isarBudgets.delete(id));
  }

  @override
  Future<Budget?> getById(int id) async {
    final entity = await _isar.isarBudgets.get(id);
    return entity?.toDomain();
  }

  @override
  Future<List<Budget>> getAll() async {
    final entities = await _isar.isarBudgets.where().findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> addGroupBudget(int budgetId, GroupBudget groupBudget) async {
    final entity = await _isar.isarBudgets.get(budgetId);
    if (entity == null) {
      throw Exception('Budget with id $budgetId not found');
    }
    final groupBudgetEntity = entity.groupBudgets; //List<String> List of Json Strings
    groupBudgetEntity.add(jsonEncode(groupBudget.toJson()));
    await _isar.writeTxn(() => _isar.isarBudgets.put(entity));
  }


  @override
  Future<void> updateGroupBudget(int budgetId, GroupBudget groupBudget) async {
    final entity = await _isar.isarBudgets.get(budgetId);
    if (entity == null) {
      throw Exception('Budget with id $budgetId not found');
    }
    final groupBudgetEntity = entity.groupBudgets; //List<String> List of Json Strings
    final index = groupBudgetEntity.indexWhere(
      (gb) => jsonDecode(gb)['groupId'] == groupBudget.groupId,
    );
    if (index == -1) {
      throw Exception('GroupBudget with groupId ${groupBudget.groupId} not found in budget $budgetId');
    }
    groupBudgetEntity[index] = jsonEncode(groupBudget.toJson());
    await _isar.writeTxn(() => _isar.isarBudgets.put(entity));
  }

  @override
  Future<void> deleteGroupBudget(int budgetId, int groupId) async {
    final entity = await _isar.isarBudgets.get(budgetId);
    if (entity == null) {
      throw Exception('Budget with id $budgetId not found');
    }
    final groupBudgetEntity = entity.groupBudgets; //List<String> List of Json Strings
    groupBudgetEntity.remove(
      groupBudgetEntity.firstWhere(
        (gb) => jsonDecode(gb)['groupId'] == groupId,
      ),
    );
    entity.groupBudgets = groupBudgetEntity;
    await _isar.writeTxn(() => _isar.isarBudgets.put(entity));
  }

  @override
  Future<GroupBudget?> getGroupBudget(int budgetId, int groupId) async {
    final entity = await _isar.isarBudgets.get(budgetId);
    if (entity == null) {
      throw Exception('Budget with id $budgetId not found');
    }
    final groupBudgetEntity = entity.groupBudgets; //List<String> List of Json Strings
    final gb =  groupBudgetEntity
        .map((gb) => GroupBudget.fromJson(jsonDecode(gb)))
        .where((gb) => gb.groupId == groupId).toList();
    return gb.isNotEmpty ? gb.first : null;
  }

  @override
  Future<List<GroupBudget>> getGroupBudgets(int budgetId) async {
    final entity = await _isar.isarBudgets.get(budgetId);
    if (entity == null) {
      throw Exception('Budget with id $budgetId not found');
    }
    final groupBudgetEntity = entity.groupBudgets; //List<String> List of Json Strings
    return groupBudgetEntity
        .map((gb) => GroupBudget.fromJson(jsonDecode(gb)))
        .toList();
  }

}