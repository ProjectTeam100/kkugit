import 'dart:developer' as console show log;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkugit/data/constant/messages.dart';
import 'package:kkugit/data/service/preference_service.dart';
import 'package:kkugit/di/injection.dart';
import 'package:kkugit/screens/home_screen.dart';
import 'package:kkugit/screens/statistics_screen.dart';
import 'package:kkugit/screens/settings_screen.dart';
import 'package:kkugit/screens/budget_screen.dart';
import 'package:kkugit/util/notification/notification.dart';

// 외부에서 접근 가능한 key
final GlobalKey<_MainLayoutState> mainLayoutKey = GlobalKey();

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  final _preferenceService = getIt<PreferenceService>();

  final List<Widget> _screens = [
    const HomeScreen(),
    const StatisticsScreen(),
    const BudgetScreen(),
    const SettingsScreen(),
  ];

  // 외부에서 접근 가능한 탭 변경 함수
  void navigateToTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 리마인더 시간 변경 리스너 구독
    _preferenceService.reminderStream.listen((message) async {
      console.log('리마인더 시간 변경: $message');
      await FlutterLocalNotifications.cancelNotification(
          Messages.scheduleNotificationId.id);
      if (message != Messages.reminderDisabled.name &&
          message != Messages.reminderEnabled.name) {
        final formatter = DateFormat.jm();
        try {
          final newTime = formatter.parse(message);
          FlutterLocalNotifications.showNotification(newTime);
        } catch (e) {
          // do nothing if parsing fails
          console.log('리마인더 시간 파싱 실패: $e');
        }
      }
    });

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[300],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) => navigateToTab(index),
        items: const [
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: '달력'),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: '통계'),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: '예산'),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: '설정'),
        ],
      ),
    );
  }
}
