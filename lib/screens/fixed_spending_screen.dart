import 'package:flutter/material.dart';

class FixedSpendingScreen extends StatelessWidget {
  const FixedSpendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('고정지출 관리'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '000원(합계금)',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          _buildCategorySection(),
          const SizedBox(height: 12),
          _buildSpendingItem(),
          _buildSpendingItem(),

          const SizedBox(height: 20),
          _buildCategorySection(),
          const SizedBox(height: 12),
          _buildSpendingItem(),
          _buildSpendingItem(),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.grey[300],
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('카테고리', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('소계', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSpendingItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.grey[300],
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('00원', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('결제처'),
            ],
          ),
          Text('결제 예정일', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}