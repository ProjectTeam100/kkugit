import 'package:isar/isar.dart';
import 'package:kkugit/data/local/isar/isar_budget.dart';
import 'package:path_provider/path_provider.dart';

import 'local/isar/isar_category.dart';
import 'local/isar/isar_challenge.dart';
import 'local/isar/isar_group.dart';
import 'local/isar/isar_preference.dart';
import 'local/isar/isar_transaction.dart';

class IsarService {
  static Isar? _isar;

  static Future<Isar> getInstance() async {
    final dir = await getApplicationDocumentsDirectory();
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
        directory: dir.path, // Specify the directory for Isar database files
      );
    return _isar!;
  }
}