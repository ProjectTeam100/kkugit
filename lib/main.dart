import 'package:flutter/material.dart';
import 'package:kkugit/data/constant/preference_name.dart';
import 'package:kkugit/data/model/preference_data.dart';
import 'package:kkugit/data/service/category_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kkugit/data/service/preference_service.dart';
import 'package:kkugit/di/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kkugit/util/notification/notification.dart';
import 'package:kkugit/util/permission/request_android_permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';
import 'package:kkugit/layouts/main_layout.dart';
import 'package:timezone/data/latest.dart' as tz;

// ✅ main_layout.dart에 있어야 함:
// final GlobalKey<_MainLayoutState> mainLayoutKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones(); // Timezone 초기화
  await FlutterLocalNotifications.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final Future<void> _initialization = _initializeApp();

  static Future<void> _initializeApp() async {
    await initializeDateFormatting('ko_KR', null);
    await configureDependencies();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final preferenceService = getIt<PreferenceService>();
    final categoryService = getIt<CategoryService>();
    List<Permission> permissions = [
      Permission.notification,
      Permission.scheduleExactAlarm
    ];
    await RequestAndroidPermissions.requestPermissions(permissions); // 권한 요청
    preferenceService.reminderInitialize(); // 알림 시간 초기화
    await Future.wait([
      preferenceService.setDefaultPreferences(),
      categoryService.setDefaultCategories(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kkugit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return MainLayout(key: mainLayoutKey); // ✅ key 전달!
        },
      ),
    );
  }
}
