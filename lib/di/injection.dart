import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:kkugit/data/isar_service.dart';
import 'package:kkugit/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();

  // Isar initialization
  final isar = await IsarService.getInstance();
  getIt.registerSingleton<Isar>(isar);
}