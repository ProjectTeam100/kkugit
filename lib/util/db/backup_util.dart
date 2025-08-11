import 'dart:io';

abstract class BackupUtil {
  static Directory createBaseDir() {
    final baseDir = Directory('storage/emulated/0/KKugit/Backups');
    if (!baseDir.existsSync()) {
      baseDir.createSync(recursive: true);
    }
    return baseDir;
  }
  Future<void> saveBackup(String filePath);
  Future<String?> loadBackup(String filePath);
  Future<void> deleteBackup(String filePath);
  Future<bool> hasBackup(String filePath);

  static String get backupFilePath {
    final dir = createBaseDir();
    return dir.path;
  }
}
