import 'dart:io';

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
  static const String dbName = 'kkugit_isar';

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
      inspector: true, // for debugging
      directory: dir.path,
      name: dbName,
    );
    return _isar!;
  }

  static Future<void> openInstanceFromFile(File file) async {
    if (_isar != null && _isar!.isOpen) {
      await _isar!.close();
    }
    _isar = null; // 인스턴스 리셋

    final dir = await getApplicationDocumentsDirectory();
    final dbFile = File('${dir.path}/$dbName.isar');
    await file.copy(dbFile.path); // 백업 파일을 앱 디렉토리로 복사

    _isar = await Isar.open(
      [
        IsarBudgetSchema,
        IsarCategorySchema,
        IsarChallengeSchema,
        IsarGroupSchema,
        IsarPreferenceSchema,
        IsarTransactionSchema,
      ],
      inspector: true, // for debugging
      directory: dir.path, // 백업 파일 경로
      name: dbName, // 백업 파일 이름
    );
  }

  static void resetInstance() {
    _isar = null; // 인스턴스 리셋
  }
}
