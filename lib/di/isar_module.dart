import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:kkugit/data/isar_service.dart';

@module
abstract class IsarModule {
  @preResolve
  Future<Isar> get isar => IsarService.getInstance();
}