import 'package:flutter/material.dart';

class BalanceSummary extends StatelessWidget {
  const BalanceSummary({super.key});

  @override
  Widget build(BuildContext context) {
    // 임시 데이터
    final income = 500000;
    final expense = 300000;
    final total = income - expense;

    // 총액에 따라 표시할 기호 결정
    final totalSign = total < 0 ? '-' : '';
    final totalAmount = total.abs().toString();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBalanceColumn(
            title: '수입',
            amount: _formatNumber(income),
            color: Colors.blue,
          ),
          _buildBalanceColumn(
            title: '지출',
            amount: _formatNumber(expense),
            color: Colors.red,
          ),
          _buildBalanceColumn(
            title: '합계',
            amount: '$totalSign${_formatNumber(total.abs())}',
            color: total >= 0 ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  //숫자 포맷 메서드
  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  // 수입, 지출, 합계 컬럼을 생성하는 메서드
  Widget _buildBalanceColumn({
    required String title,
    required String amount,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '₩$amount',
              style: TextStyle(
                fontSize: 14,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
