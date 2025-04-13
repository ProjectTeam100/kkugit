import 'package:kkugit/data/model/spending.dart';
import 'package:kkugit/data/repository/spending_repository.dart';

class SpendingService {
  final SpendingRepository _spendingRepository = SpendingRepository();

  List<Spending> fetchAllSpendings() {
    return _spendingRepository.getAll();
  }

  int getMonthlySpendingSum(DateTime date) {
    final spendings = _spendingRepository.getAll();
    final filteredSpendings = spendings.where((spending) {
      return spending.dateTime.year == date.year && spending.dateTime.month == date.month;
    }).toList();
    return filteredSpendings.fold(0, (sum, spending) => sum + spending.price);
  }

  Spending? fetchSpendingById(int id) {
    return _spendingRepository.getById(id);
  }

  void addSpending(Spending spending) {
    _spendingRepository.add(spending);
  }

  void updateSpending(Spending spending) {
    _spendingRepository.update(spending);
  }

  void deleteSpending(int id) {
    _spendingRepository.delete(id);
  }

}