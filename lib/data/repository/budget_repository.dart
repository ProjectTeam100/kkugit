import 'package:kkugit/data/model/budget.dart';
import 'package:kkugit/data/model/group_budget.dart';

abstract class BudgetRepository {
  Future<void> add(Budget budget);
  Future<void> update(Budget budget);
  Future<void> delete(int id);
  Future<Budget?> getById(int id);
  Future<List<Budget>> getAll();
  Future<void> addGroupBudget(int budgetId, GroupBudget groupBudget);
  Future<void> updateGroupBudget(int budgetId, GroupBudget groupBudget);
  Future<List<GroupBudget>> getGroupBudgets(int budgetId);
  Future<GroupBudget?> getGroupBudget(int budgetId, int groupId);
  Future<void> deleteGroupBudget(int budgetId, int groupId);
}