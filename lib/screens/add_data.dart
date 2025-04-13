import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kkugit/data/model/income.dart';
import 'package:kkugit/data/model/spending.dart';
import 'package:kkugit/data/service/income_service.dart';
import 'package:kkugit/data/service/spending_service.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final SpendingService _spendingService = SpendingService();
  final IncomeService _incomeService = IncomeService();
  DateTime selectedDate = DateTime.now();
  final TextEditingController _amountController = TextEditingController();
  String transactionType = 'expense'; // 'income' or 'expense'

  @override
  void dispose() {
    _amountController.dispose(); // TextEditingController 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '내역 추가',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Row(
            // 날짜 선택
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Text(
                  '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          // 금액 입력칸
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8.0,
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: '0',
                    ),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                  ),
                ),
                const Text(
                  '원',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 수입/지출 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16.0,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    transactionType = 'income';
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  backgroundColor: transactionType == 'income'
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondaryContainer,
                  foregroundColor: transactionType == 'income'
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                child: const Text(
                  '수입',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    transactionType = 'expense';
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  backgroundColor: transactionType == 'expense'
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondaryContainer,
                  foregroundColor: transactionType == 'expense'
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                child: const Text(
                  '지출',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 저장 버튼
          ElevatedButton(
            onPressed: _saveTransaction,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
              ),
            ),
            child: const Text(
              '저장하기',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    )));
  }

  void _saveTransaction() {
    final int amount = int.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) {
      // 금액이 0 이하인 경우 처리
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('금액을 입력하세요.'),
        ),
      );
      return;
    }

    // 수입/지출에 따라 객체 생성 및 저장
    if (transactionType == 'income') {
      // 수입 객체 생성 및 저장
      final income = Income(
        id: DateTime.now().millisecondsSinceEpoch,
        dateTime: selectedDate,
        client: '내역', //임시 값
        category: 1, //임시 카테고리 id
        group: 1, //임시 그룹 id
        price: amount,
        memo: '메모', //임시 메모
      );

      _incomeService.addIncome(income); // 수입 저장
      // 임시 토스트 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('수입이 저장되었습니다.'),
        ),
      );
      Navigator.pop(context); // 화면 닫기
    } else {
      // 지출 객체 생성 및 저장
      final spending = Spending(
        id: DateTime.now().millisecondsSinceEpoch,
        dateTime: selectedDate,
        client: '내역', //임시 값
        payment: '현금', //임시 값
        category: 1, //임시 카테고리 id
        group: 1, //임시 그룹 id
        price: amount,
        memo: '메모', //임시 메모
      );
      _spendingService.addSpending(spending); // 지출 저장
      // 임시 토스트 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('지출이 저장되었습니다.'),
        ),
      );
      Navigator.pop(context); // 화면 닫기
    }
  }
}
