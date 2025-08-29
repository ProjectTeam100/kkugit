import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkugit/data/model/transaction.dart';
import 'package:kkugit/data/service/transaction_service.dart';
import 'package:kkugit/components/challenge_status.dart';
import 'package:kkugit/di/injection.dart';
import 'package:table_calendar/table_calendar.dart';
import '../components/balance_summary.dart';
import 'package:kkugit/screens/add_screen.dart';
import 'package:kkugit/screens/fixed_spending_screen.dart';
import 'package:kkugit/layouts/main_layout.dart';
import 'package:kkugit/components/transaction_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _transactionService = getIt<TransactionService>();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  int _monthlyIncomeSum = 0;
  int _monthlySpendingSum = 0;

  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final now = DateTime.now();
    final results = await Future.wait([
      _transactionService.getMonthlySumByType(TransactionType.income, now),
      _transactionService.getMonthlySumByType(TransactionType.expense, now),
      _transactionService.getAll(),
    ]);
    setState(() {
      _monthlyIncomeSum = results[0] as int;
      _monthlySpendingSum = results[1] as int;
      _transactions = results[2] as List<Transaction>;
    });
  }

  Future<void> fetchTransactions(selectedDay) async {
    final date = selectedDay ?? DateTime.now();
    final results = await Future.wait([
      _transactionService.getMonthlySumByType(TransactionType.income, date),
      _transactionService.getMonthlySumByType(TransactionType.expense, date),
      _transactionService.getByMonth(date),
    ]);
    setState(() {
      _monthlyIncomeSum = results[0] as int;
      _monthlySpendingSum = results[1] as int;
      _transactions = results[2] as List<Transaction>;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentMonth = DateFormat('M월', 'ko_KR').format(
      _selectedDay ?? DateTime.now(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentMonth,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FixedSpendingScreen(),
                ),
              );
            },
            child: const Text(
              '고정지출',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BalanceSummary(
                income: _monthlyIncomeSum,
                expense: _monthlySpendingSum,
              ),
              const ChallengeStatus(hasChallenge: true),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TableCalendar(
                  locale: 'ko_KR',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      fetchTransactions(selectedDay);
                    }
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: const CalendarStyle(
                    outsideDaysVisible: false,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '수입/지출내역',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  key: const PageStorageKey('transactionList'),
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = _transactions[index];
                    return TransactionCard(
                      key: ValueKey(transaction.id),
                      price: transaction.amount,
                      dateTime: transaction.dateTime,
                      client: transaction.client,
                      isIncome: transaction.type == TransactionType.income,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddScreen(),
            ),
          );
          if (result == true) {
            _initialize();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
