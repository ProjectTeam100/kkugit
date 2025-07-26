import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('예산'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          '예산 화면입니다.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
