import 'package:kkugit/data/model/budget.dart';

abstract class BudgetRepository {
  Future<void> add(Budget budget);
  Future<void> update(Budget budget);
  Future<void> delete(int id);
  Future<Budget?> getById(int id);
  Future<List<Budget>> getAll();
}