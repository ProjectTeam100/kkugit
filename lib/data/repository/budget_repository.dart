import 'package:hive/hive.dart';
import 'package:kkugit/data/model/budget.dart';

class BudgetRepository {
  final Box<Budget> _budgetBox = Hive.box<Budget>('budgetBox');

  List<Budget> getAll() => _budgetBox.values.toList();

  Budget? getById(int id) => _budgetBox.get(id);

  void add(Budget budget) {
    _budgetBox.add(budget);
  }

  void update(Budget budget) {
    _budgetBox.put(budget.id, budget);
  }

  void delete(int id) {
    _budgetBox.delete(id);
  }
}