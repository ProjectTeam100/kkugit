class EnumData {
  final int? id;
  final String? description;

  const EnumData({this.id, this.description});
}

enum Messages {
  // 리마인더 관련 메시지
  reminderEnabled,
  reminderDisabled,

  // 알림 ID 상수
  defaultNotificationId,
  scheduleNotificationId,

  // 오류 메시지
  backupFileNotFound,
  backupFailed,
  storagePermissionRequired,
  isarNotOpen,
}

extension MessagesExtension on Messages {
  static final _data = {
    Messages.reminderEnabled: const EnumData(description: '리마인더 활성화'),
    Messages.reminderDisabled: const EnumData(description: '리마인더 비활성화'),
    Messages.defaultNotificationId:
        const EnumData(id: 0, description: '기본 알림 ID'),
    Messages.scheduleNotificationId:
        const EnumData(id: 1, description: '예약 알림 ID'),
    Messages.backupFileNotFound:
        const EnumData(description: '백업 파일을 찾을 수 없습니다.'),
    Messages.backupFailed: const EnumData(description: '백업에 실패했습니다.'),
    Messages.storagePermissionRequired:
        const EnumData(description: '저장소 권한이 필요합니다.'),
    Messages.isarNotOpen:
        const EnumData(description: 'Isar 데이터베이스가 열려 있지 않습니다.'),
  };

  int get id => _data[this]?.id ?? -1;
  String get description => _data[this]?.description ?? '';
}
