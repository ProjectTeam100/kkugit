import 'package:hive_flutter/hive_flutter.dart';
import 'package:kkugit/data/model/budget.dart';
import 'package:kkugit/data/model/category.dart';
import 'package:kkugit/data/model/challenge.dart';
import 'package:kkugit/data/model/group.dart';
import 'package:kkugit/data/model/preference.dart';
import 'package:kkugit/data/model/spending.dart';

class HiveConfig {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(SpendingAdapter()); // typeId: 0
    Hive.registerAdapter(CategoryAdapter()); // typeId: 1
    Hive.registerAdapter(GroupAdapter()); // typeId: 2
    Hive.registerAdapter(BudgetAdapter()); // typeId: 3
    Hive.registerAdapter(GroupBudgetAdapter()); // typeId: 4
    Hive.registerAdapter(PreferenceAdapter()); // typeId: 5
    Hive.registerAdapter(ChallengeAdapter()); // typeId: 6
    Hive.registerAdapter(ChallengeTypeAdapter()); // typeId: 7
    Hive.registerAdapter(ChallengeStatusAdapter()); // typeId: 8
  }
}