// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar/isar.dart' as _i338;
import 'package:kkugit/data/repository/budget_repository.dart' as _i769;
import 'package:kkugit/data/repository/category_repository.dart' as _i93;
import 'package:kkugit/data/repository/challenge_repository.dart' as _i919;
import 'package:kkugit/data/repository/group_repository.dart' as _i1033;
import 'package:kkugit/data/repository/isarImpl/isar_budget_repository.dart'
    as _i1056;
import 'package:kkugit/data/repository/isarImpl/isar_category_repository.dart'
    as _i512;
import 'package:kkugit/data/repository/isarImpl/isar_challenge_repository.dart'
    as _i152;
import 'package:kkugit/data/repository/isarImpl/isar_group_repository.dart'
    as _i412;
import 'package:kkugit/data/repository/isarImpl/isar_preference_repository.dart'
    as _i849;
import 'package:kkugit/data/repository/isarImpl/isar_transaction_repository.dart'
    as _i642;
import 'package:kkugit/data/repository/preference_repository.dart' as _i578;
import 'package:kkugit/data/repository/transaction_repository.dart' as _i420;
import 'package:kkugit/data/service/budget_service.dart' as _i859;
import 'package:kkugit/data/service/category_service.dart' as _i612;
import 'package:kkugit/data/service/challenge_service.dart' as _i661;
import 'package:kkugit/data/service/group_service.dart' as _i51;
import 'package:kkugit/data/service/preference_service.dart' as _i269;
import 'package:kkugit/data/service/transaction_service.dart' as _i756;
import 'package:kkugit/di/isar_module.dart' as _i107;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final isarModule = _$IsarModule();
    await gh.factoryAsync<_i338.Isar>(
      () => isarModule.isar,
      preResolve: true,
    );
    gh.lazySingleton<_i859.BudgetService>(() => _i859.BudgetService());
    gh.lazySingleton<_i612.CategoryService>(() => _i612.CategoryService());
    gh.lazySingleton<_i661.ChallengeService>(() => _i661.ChallengeService());
    gh.lazySingleton<_i51.GroupService>(() => _i51.GroupService());
    gh.lazySingleton<_i269.PreferenceService>(() => _i269.PreferenceService());
    gh.lazySingleton<_i756.TransactionService>(
        () => _i756.TransactionService());
    gh.lazySingleton<_i420.TransactionRepository>(
        () => _i642.IsarTransactionRepository(gh<_i338.Isar>()));
    gh.lazySingleton<_i1033.GroupRepository>(
        () => _i412.IsarGroupRepository(gh<_i338.Isar>()));
    gh.lazySingleton<_i93.CategoryRepository>(
        () => _i512.IsarCategoryRepository(gh<_i338.Isar>()));
    gh.lazySingleton<_i769.BudgetRepository>(
        () => _i1056.IsarBudgetRepository(gh<_i338.Isar>()));
    gh.lazySingleton<_i578.PreferenceRepository>(
        () => _i849.IsarPreferenceRepository(gh<_i338.Isar>()));
    gh.lazySingleton<_i919.ChallengeRepository>(
        () => _i152.IsarChallengeRepository(gh<_i338.Isar>()));
    return this;
  }
}

class _$IsarModule extends _i107.IsarModule {}
