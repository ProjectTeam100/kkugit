import 'package:flutter/material.dart';

class BudgetSettingScreen extends StatefulWidget {
  const BudgetSettingScreen({super.key});

  @override
  State<BudgetSettingScreen> createState() => _BudgetSettingScreenState();
}

class _BudgetSettingScreenState extends State<BudgetSettingScreen> {
  final _budgetController = TextEditingController();
  final Map<String, int> _groupBudgets = {
    '그룹A': 0,
    '그룹B': 0,
    '그룹C': 0,
  };

  String _selectedPeriod = '한달'; // '하루', '한달', '1년'

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  int get _dailyBudget {
    final budget = int.tryParse(_budgetController.text) ?? 0;
    switch (_selectedPeriod) {
      case '하루':
        return budget;
      case '한달':
        return (budget / 30).floor();
      case '1년':
        return (budget / 365).floor();
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('예산 설정'),
                    centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // 챌린지 시작 or 상태 표시 등
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
              ),
              child: const Text(
                '챌린지 시작하기/진행중',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),

            // 드롭다운 메뉴
            Row(
              children: [
                DropdownButton<String>(
                  value: _selectedPeriod,
                  items: ['하루', '한달', '1년']
                      .map((period) => DropdownMenuItem(
                    value: period,
                    child: Text(period),
                  ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedPeriod = value);
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 전체 예산 입력
            TextField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                hintText: '000원',
                border: InputBorder.none,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 4),
            Text('하루예산: ${_dailyBudget}원'),

            const SizedBox(height: 24),

            // 그룹별 예산
            Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('그룹별 예산 설정'),
                      Text('편집'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._groupBudgets.entries.map((entry) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key),
                      Text('${entry.value}원'),
                    ],
                  )),
                ],
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                // 저장 로직
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
              ),
              child: const Text(
                '저장하기',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
