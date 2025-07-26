import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kkugit/data/service/category_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kkugit/data/service/preference_service.dart';
import 'package:kkugit/di/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:kkugit/layouts/main_layout.dart';

// ✅ main_layout.dart에 있어야 함:
// final GlobalKey<_MainLayoutState> mainLayoutKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
