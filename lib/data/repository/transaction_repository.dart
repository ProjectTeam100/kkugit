import 'package:kkugit/data/model/transaction.dart';

abstract class TransactionRepository {
  Future<void> add(Transaction transaction);
  Future<void> update(Transaction transaction);
  Future<void> delete(int id);
  Future<Transaction?> getById(int id);
  Future<List<Transaction>> getAll();
  Future<List<Transaction>> getByCategoryId(int categoryId);
  Future<List<Transaction>> getByGroupId(int groupId);
  Future<List<Transaction>> getByClient(String clientName);
  Future<List<Transaction>> getByPayment(String paymentMethod);
  Future<List<Transaction>> getByType(TransactionType type);
  Future<List<Transaction>> getByDateRange(DateTime start, DateTime end);
  Future<List<Transaction>> getByMonth(DateTime date);
  Future<int> getMonthlySumByType(TransactionType type, DateTime date);
}