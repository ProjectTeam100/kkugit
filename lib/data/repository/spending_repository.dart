import 'package:hive/hive.dart';
import 'package:kkugit/data/model/spending.dart';

class SpendingRepository {
  final Box<Spending> _spendingBox = Hive.box<Spending>('spendingBox');

  List<Spending> getAll() => _spendingBox.values.toList();
}