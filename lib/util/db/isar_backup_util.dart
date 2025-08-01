import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:kkugit/data/constant/messages.dart';
import 'package:kkugit/data/isar_service.dart';
import 'package:kkugit/util/db/backup_util.dart';

@LazySingleton(as: BackupUtil)
class IsarBackupUtil implements BackupUtil {
  final Isar _isar;
  IsarBackupUtil(this._isar);

  @override
  Future<void> saveBackup(String filePath) async {
    if (_isar.isOpen == false) {
      throw Exception(Messages.isarNotOpen.description);
    }
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
    try {
      await _isar.copyToFile(file.path);
    } catch (e) {
      throw Exception(e);
    }
    IsarService.getInstance();
  }

  @override
  Future<String?> loadBackup(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await IsarService.openInstanceFromFile(file);
      return filePath;
    } else {
      throw Exception(Messages.backupFileNotFound.description);
    }
  }

  @override
  Future<void> deleteBackup(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    } else {
      throw Exception(Messages.backupFileNotFound.description);
    }
  }

  @override
  Future<bool> hasBackup(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }
}
