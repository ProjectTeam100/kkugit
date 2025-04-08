import 'package:kkugit/data/model/spending.dart';
import 'package:kkugit/data/repository/spending_repository.dart';

class SpendingService {
  final SpendingRepository _spendingRepository = SpendingRepository();

  List<Spending> fetchAllSpendings() {
    return _spendingRepository.getAll();
  }
}