import 'package:hive/hive.dart';
import 'package:kkugit/data/model/income.dart';

class IncomeRepository {
  final Box<Income> _incomeBox = Hive.box<Income>('incomeBox');

  List<Income> getAll() => _incomeBox.values.toList();

  Income? getById(int id) => _incomeBox.get(id);

  void add(Income income) {
    _incomeBox.add(income);
  }

  void update(Income income) {
    _incomeBox.put(income.id, income);
  }

  void delete(int id) {
    _incomeBox.delete(id);
  }
}