import 'package:kkugit/data/model/income.dart';
import 'package:kkugit/data/repository/income_repository.dart';

class IncomeService {
  final IncomeRepository _incomeRepository = IncomeRepository();

  List<Income> fetchAllIncomes() {
    return _incomeRepository.getAll();
  }

    int getMonthlyIncomeSum(DateTime date) {
    final imcomes = _incomeRepository.getAll();
    final filteredIncomes = imcomes.where((income) {
      return income.dateTime.year == date.year &&
          income.dateTime.month == date.month;
    }).toList();
    return filteredIncomes.fold(0, (sum, income) => sum + income.price);
  }

  void addIncome(Income income) {
    _incomeRepository.add(income);
  }

  void updateIncome(Income income) {
    _incomeRepository.update(income);
  }

  void deleteIncome(int id) {
    _incomeRepository.delete(id);
  }
}