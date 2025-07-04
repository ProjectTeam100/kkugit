import 'package:flutter/material.dart';
import 'package:kkugit/data/service/category_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kkugit/data/service/preference_service.dart';
import 'package:kkugit/di/injection.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final Future<void> _initialization = _initializeApp();

  static Future<void> _initializeApp() async {
    // DI 설정
    await configureDependencies();

    // 기본 카테고리/환경설정 초기화
    final categoryService = getIt<CategoryService>();
    final preferenceService = getIt<PreferenceService>();
    await Future.wait([
      () async {
        if (await categoryService.getAll().then((value) => value.isEmpty)) {
          await categoryService.setDefaultCategories();
        }
      }(),
      () async {
        if (await preferenceService.getAll().then((value) => value.isEmpty)) {
          await preferenceService.setDefaultPreferences();
        }
      }(),
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

