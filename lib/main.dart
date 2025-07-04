import 'package:flutter/material.dart';
import 'package:kkugit/data/service/category_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kkugit/data/service/preference_service.dart';
import 'package:kkugit/di/injection.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final Future<void> _initialization = _initializeApp();

  static Future<void> _initializeApp() async {
    // 날짜 형식 초기화
    await initializeDateFormatting('ko_KR', null);
    // DI 설정
    await configureDependencies();
    final preferenceService = getIt<PreferenceService>();
    final categoryService = getIt<CategoryService>();
    // 기본 설정 및 카테고리 추가
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
          return const HomeScreen();
        },
      ),
    );
  }
}
