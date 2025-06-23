import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:kkugit/data/local/isar/isar_budget.dart';
import 'package:kkugit/data/model/budget.dart';
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
}