import 'package:kkugit/data/model/income.dart';
import 'package:kkugit/data/repository/income_repository.dart';

class IncomeService {
  final IncomeRepository _incomeRepository = IncomeRepository();

  List<Income> fetchAllIncomes() {
    return _incomeRepository.getAll();
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