import 'package:hive_flutter/hive_flutter.dart';
import 'package:kkugit/data/model/budget.dart';
import 'package:kkugit/data/model/category.dart';
import 'package:kkugit/data/model/challenge.dart';
import 'package:kkugit/data/model/group.dart';
import 'package:kkugit/data/model/income.dart';
import 'package:kkugit/data/model/preference.dart';
import 'package:kkugit/data/model/spending.dart';

class HiveConfig {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(SpendingAdapter()); // typeId: 0  //지출
    Hive.registerAdapter(CategoryAdapter()); // typeId: 1  //카테고리
    Hive.registerAdapter(GroupAdapter()); // typeId: 2  //그룹
    Hive.registerAdapter(BudgetAdapter()); // typeId: 3  //예산
    Hive.registerAdapter(GroupBudgetAdapter()); // typeId: 4
    Hive.registerAdapter(PreferenceAdapter()); // typeId: 5  //설정
    Hive.registerAdapter(ChallengeAdapter()); // typeId: 6  //챌린지
    Hive.registerAdapter(ChallengeTypeAdapter()); // typeId: 7
    Hive.registerAdapter(ChallengeStatusAdapter()); // typeId: 8
    Hive.registerAdapter(IncomeAdapter()); // typeId: 9  //수입

    await Hive.openBox<Spending>('spendingBox');
    await Hive.openBox<Category>('categoryBox');
    await Hive.openBox<Group>('groupBox');
    await Hive.openBox<Budget>('budgetBox');
    await Hive.openBox<Preference>('preferenceBox');
    await Hive.openBox<Challenge>('challengeBox');
    await Hive.openBox<Income>('incomeBox');
  }
}
