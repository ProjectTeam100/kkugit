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
}

extension MessagesExtension on Messages {
  static final _data = {
    Messages.reminderEnabled: const EnumData(description: '리마인더 활성화'),
    Messages.reminderDisabled: const EnumData(description: '리마인더 비활성화'),
    Messages.defaultNotificationId:
        const EnumData(id: 0, description: '기본 알림 ID'),
    Messages.scheduleNotificationId:
        const EnumData(id: 1, description: '예약 알림 ID'),
  };

  int get id => _data[this]?.id ?? -1;
}
