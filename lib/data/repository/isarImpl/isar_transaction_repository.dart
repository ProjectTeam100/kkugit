import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:kkugit/data/local/isar/isar_transaction.dart';
import 'package:kkugit/data/model/transaction.dart';
import 'package:kkugit/data/repository/transaction_repository.dart';

@LazySingleton(as: TransactionRepository)
class IsarTransactionRepository implements TransactionRepository {
  final Isar _isar;
  IsarTransactionRepository(this._isar);

  @override
  Future<void> add(Transaction transaction) async {
    final entity = IsarTransaction.fromDomain(transaction);
    await _isar.writeTxn(() => _isar.isarTransactions.put(entity));
  }

  @override
  Future<void> update(Transaction transaction) async {
    final entity = IsarTransaction.fromDomain(transaction);
    await _isar.writeTxn(() => _isar.isarTransactions.put(entity));
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() => _isar.isarTransactions.delete(id));
  }

  @override
  Future<Transaction?> getById(int id) async {
    final entity = await _isar.isarTransactions.get(id);
    return entity?.toDomain();
  }

  @override
  Future<List<Transaction>> getAll() async {
    final entities = await _isar.isarTransactions.where().findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Transaction>> getByCategoryId(int categoryId) async {
    final entities = await _isar.isarTransactions.filter()
        .categoryIdEqualTo(categoryId)
        .findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Transaction>> getByGroupId(int groupId) async {
    final entities = await _isar.isarTransactions.filter()
        .groupIdEqualTo(groupId)
        .findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Transaction>> getByClient(String client) async {
    final entities = await _isar.isarTransactions.filter()
        .clientContains(client)
        .findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Transaction>> getByPayment(String payment) async {
    final entities = await _isar.isarTransactions.filter()
        .paymentContains(payment)
        .findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Transaction>> getByType(TransactionType type) async {
    final entities = await _isar.isarTransactions.filter()
        .typeEqualTo(type)
        .findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Transaction>> getByDateRange(DateTime start, DateTime end) async {
    final entities = await _isar.isarTransactions.filter()
        .dateTimeBetween(start, end)
        .findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<int> getMonthlySumByType(TransactionType type, DateTime date) async {
    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month + 1, 0);

    final entities = await _isar.isarTransactions.filter()
        .dateTimeBetween(start, end)
        .typeEqualTo(type)
        .findAll();

    int sum = 0;
    for (final entity in entities) {
      sum += entity.amount;
    }
    return sum;
  }
}