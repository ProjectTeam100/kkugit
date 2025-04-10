import 'package:flutter/material.dart';
import 'package:kkugit/core/hive_config.dart';
import 'package:kkugit/data/service/category_service.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);
  runApp(const MyApp());
  await HiveConfig.initialize();

  // 기본 카테고리 초기화
  final CategoryService categoryService = CategoryService();
  await categoryService.setDefaultCategories();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}