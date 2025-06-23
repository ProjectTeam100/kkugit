import 'package:kkugit/data/model/budget.dart';
import 'package:kkugit/data/model/group_budget.dart';
import 'package:kkugit/data/repository/budget_repository.dart';

import '../../di/injection.dart';

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
}