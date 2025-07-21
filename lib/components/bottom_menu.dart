import 'package:flutter/material.dart';

void main() {
  runApp(BottomMenu());
}

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('달력 화면')),
    Center(child: Text('통계 화면')),
    Center(child: Text('예산 화면')),
    Center(child: Text('설정 화면')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[300], // 이미지의 회색 배경
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: SizedBox.shrink(), // 아이콘 없이 텍스트만
            label: '달력',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: '통계',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: '예산',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: '설정',
          ),
        ],
      ),
    );
  }
}
