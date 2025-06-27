import 'package:injectable/injectable.dart';
import 'package:kkugit/data/model/budget.dart';
import 'package:kkugit/data/model/group_budget.dart';
import 'package:kkugit/data/repository/budget_repository.dart';

import '../../di/injection.dart';

@LazySingleton()
class BudgetService {

  final _budgetRepository = getIt<BudgetRepository>();

  Future<void> add(
      DateTime dateTime,
      String unit,
      int amount,
      ) async {
    final List<GroupBudget> groupBudgets = [];
    final budget = Budget(
      dateTime: dateTime,
      unit: unit,
      amount: amount,
      groupBudgets: groupBudgets,
    );
    await _budgetRepository.add(budget);
  }

  Future<void> update(Budget budget) async {
    await _budgetRepository.update(budget);
  }

  Future<void> delete(int id) async {
    await _budgetRepository.delete(id);
  }

  Future<Budget?> getById(int id) async {
    return await _budgetRepository.getById(id);
  }

  Future<List<Budget>> getAll() async {
    return await _budgetRepository.getAll();
  }

  // 새 그룹 예산 추가
  Future<void> addGroupBudget(int budgetId, int groupId, int amount) async {
    final groupBudget = GroupBudget(
      groupId: groupId,
      amount: amount,
    );
    await _budgetRepository.addGroupBudget(budgetId, groupBudget);
  }

  // 그룹 예산 업데이트
  Future<void> updateGroupBudget(int budgetId, GroupBudget groupBudget) async {
    await _budgetRepository.updateGroupBudget(budgetId, groupBudget);
  }

  // 그룹 예산 목록 조회
  Future<List<GroupBudget>> getGroupBudgets(int budgetId) async {
    return await _budgetRepository.getGroupBudgets(budgetId);
  }

  // 특정 그룹의 예산 조회
  Future<GroupBudget?> getGroupBudget(int budgetId, int groupId) async {
    return await _budgetRepository.getGroupBudget(budgetId, groupId);
  }
  // 그룹 예산 삭제
  Future<void> deleteGroupBudget(int budgetId, int groupId) async {
    await _budgetRepository.deleteGroupBudget(budgetId, groupId);
  }
}