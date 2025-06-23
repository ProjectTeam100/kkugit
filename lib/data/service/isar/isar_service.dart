import 'package:isar/isar.dart';
import 'package:kkugit/data/local/isar/isar_budget.dart';

import '../../local/isar/isar_category.dart';
import '../../local/isar/isar_challenge.dart';
import '../../local/isar/isar_group.dart';
import '../../local/isar/isar_preference.dart';
import '../../local/isar/isar_transaction.dart';

class IsarService {
  static Isar? _isar;

  static Future<Isar> getInstance() async {
    _isar ??= await Isar.open(
        [
          IsarBudgetSchema,
          IsarCategorySchema,
          IsarChallengeSchema,
          IsarGroupSchema,
          IsarPreferenceSchema,
          IsarTransactionSchema,
        ],
        inspector: true, // Enable inspector for debugging
        directory: 'isar', // Specify the directory for Isar database files
      );
    return _isar!;
  }
}