import 'package:flutter/material.dart';
import 'package:kkugit/screens/home_screen.dart';
import 'package:kkugit/screens/statistics_screen.dart';
import 'package:kkugit/screens/settings_screen.dart';
import 'package:kkugit/screens/budget_screen.dart';

// 외부에서 접근 가능한 key
final GlobalKey<_MainLayoutState> mainLayoutKey = GlobalKey();

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

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
