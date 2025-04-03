import 'package:hive/hive.dart';
import 'package:kkugit/data/model/spending.dart';

class SpendingRepository {
  final Box<Spending> _spendingBox = Hive.box<Spending>('spendingBox');

  List<Spending> getAll() => _spendingBox.values.toList();

  Spending? getById(int id) => _spendingBox.get(id);

  void add(Spending spending) {
    _spendingBox.put(spending.id, spending);
  }

  void update(Spending spending) {
    _spendingBox.put(spending.id, spending);
  }

  void delete(int id) {
    _spendingBox.delete(id);
  }
}