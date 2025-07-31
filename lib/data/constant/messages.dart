enum Messages {
  // 리마인더 관련 메시지
  reminderEnabled,
  reminderDisabled,

  // 알림 ID 상수
  defaultNotificationId,
  scheduleNotificationId,
}

extension MessagesExtension on Messages {
  int get id {
    switch (this) {
      case Messages.reminderEnabled:
        return 1;
      case Messages.reminderDisabled:
        return 0;
      case Messages.defaultNotificationId:
        return 0;
      case Messages.scheduleNotificationId:
        return 1;
    }
  }
}
