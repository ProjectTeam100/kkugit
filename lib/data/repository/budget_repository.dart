import 'package:hive/hive.dart';
import 'package:kkugit/data/model/budget.dart';

class BudgetRepository {
  final Box<Budget> _budgetBox = Hive.box<Budget>('budgetBox');

  List<Budget> getAll() => _budgetBox.values.toList();
}