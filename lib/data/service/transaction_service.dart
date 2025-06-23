import 'package:kkugit/data/model/transaction.dart';
import 'package:kkugit/data/repository/transaction_repository.dart';
import 'package:kkugit/di/injection.dart';

class TransactionService {
  final _transactionRepository = getIt<TransactionRepository>();

  Future<void> add(
      DateTime dateTime,
      String client,
      String payment,
      int category,
      int group,
      int amount,
      String memo,
      TransactionType type
      ) async {
    final transaction = Transaction(
      dateTime: dateTime,
      client: client ?? '',
      payment: payment ?? '',
      categoryId: category,
      groupId: group,
      amount: amount ?? 0,
      memo: memo ?? '',
      type: type
    );
    await _transactionRepository.add(transaction);
  }

  Future<void> update(Transaction transaction) async {
    await _transactionRepository.update(transaction);
  }

  Future<void> delete(int id) async {
    await _transactionRepository.delete(id);
  }

  Future<Transaction?> getById(int id) async {
    return await _transactionRepository.getById(id);
  }

  Future<List<Transaction>> getAll() async {
    return await _transactionRepository.getAll();
  }

  Future<List<Transaction>> getByCategoryId(int categoryId) async {
    return await _transactionRepository.getByCategoryId(categoryId);
  }

  Future<List<Transaction>> getByGroupId(int groupId) async {
    return await _transactionRepository.getByGroupId(groupId);
  }

  Future<List<Transaction>> getByClient(String clientName) async {
    return await _transactionRepository.getByClient(clientName);
  }

  Future<List<Transaction>> getByPayment(String paymentMethod) async {
    return await _transactionRepository.getByPayment(paymentMethod);
  }

  Future<List<Transaction>> getByType(TransactionType type) async {
    return await _transactionRepository.getByType(type);
  }

  Future<List<Transaction>> getByDateRange(DateTime start, DateTime end) async {
    return await _transactionRepository.getByDateRange(start, end);
  }

  Future<int> getMonthlySumByType(TransactionType type, DateTime date) async {
    return await _transactionRepository.getMonthlySumByType(type, date);
  }

}