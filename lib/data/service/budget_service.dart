import 'package:kkugit/data/model/budget.dart';
import 'package:kkugit/data/repository/budget_repository.dart';

class BudgetService {
  final BudgetRepository _budgetRepository = BudgetRepository();

  List<Budget> fetchAllBudgets() {
    return _budgetRepository.getAll();
  }

  Budget? fetchBudgetById(int id) {
    return _budgetRepository.getById(id);
  }

  void addBudget(Budget budget) {
    _budgetRepository.add(budget);
  }

  void updateBudget(Budget budget) {
    _budgetRepository.update(budget);
  }

  void deleteBudget(int id) {
    _budgetRepository.delete(id);
  }
}