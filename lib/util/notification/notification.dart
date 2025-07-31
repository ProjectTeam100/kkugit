import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kkugit/data/constant/messages.dart';
import 'package:timezone/timezone.dart' as tz;

class FlutterLocalNotifications {
  FlutterLocalNotifications._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        // Handle notification response
      },
    );
  }

  static requestNotificationPermission() async {
    final bool? grantedIOS = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    return grantedIOS ?? false;
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> showNotification(DateTime? scheduleTime) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(badgeNumber: 1),
    );

    if (scheduleTime == null) {
      await flutterLocalNotificationsPlugin.show(
        Messages.defaultNotificationId.id,
        'test title',
        'test body',
        notificationDetails,
        payload: 'test payload',
      );
      return;
    } else {
      final now = DateTime.now();
      final newTime = DateTime(
        now.year,
        now.month,
        now.day,
        scheduleTime.hour,
        scheduleTime.minute,
      ).add(const Duration(days: -1));
      await flutterLocalNotificationsPlugin.zonedSchedule(
        Messages.scheduleNotificationId.id,
        '가계부 정리할 시간!',
        '오늘의 가계부를 정리해보세요.',
        tz.TZDateTime.from(newTime, tz.local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: 'test payload',
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }
}
