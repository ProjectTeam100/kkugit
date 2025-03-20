import 'package:flutter/material.dart';
import 'components/popup.dart';
import 'components/square_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Square Button'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SquareButton(
              text: '기본 버튼',
              onPressed: () {
                print('버튼 클릭');
              },
            ),
            const SizedBox(height: 20),
            SquareButton(
              text: '초록색 버튼',
              onPressed: () {
                print('초록 버튼 눌림');
              },
              backgroundColor: Colors.green,
              textColor: Colors.white,
              borderColor: Colors.green,
            ),
            const SizedBox(height: 20),
            SquareButton(
              text: '팝업 보기',
              onPressed: () {
                showPopup(
                  context: context,
                  title: "팝업 제목",
                  content: "팝업 내용",
                  confirmText: "확인",
                  cancelText: "닫기",
                  onConfirm: () {
                    print('확인 버튼 클릭');
                    Navigator.of(context).pop();
                  },
                );
              },
              backgroundColor: const Color(0xFF5199FF),
              textColor: Colors.white,
              borderColor: const Color(0xFF5199FF),
            ),
          ],
        ),
      ),
    );
  }
}
