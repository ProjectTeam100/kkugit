import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('수입/지출 내역 추가 스크린'),
      ),
      body: const Center(
        child: Text('수입/지출 내역 추가 페이지 입니다.'),
      ),
    );
  }
}
