// lib/components/transaction_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final int price;
  final DateTime dateTime;
  final String client;
  final bool isIncome;

  const TransactionCard({
    super.key,
    required this.price,
    required this.dateTime,
    required this.client,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);
    final formattedPrice = NumberFormat('#,###').format(price);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          isIncome ? Icons.arrow_downward : Icons.arrow_upward,
          color: isIncome ? Colors.green : Colors.red,
        ),
        title: Text(
          client,
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text(formattedDate),
        trailing: Text(
          '${isIncome ? '+' : '-'}$formattedPrice원',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
