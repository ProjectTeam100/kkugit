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
import 'package:kkugit/screens/settings_screen.dart';


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
  List<Transaction> _incomes = [];
  List<Transaction> _spendings = [];

  void _loadTransactions() {
    _transactionService.getAll().then((transactions) {
      setState(() {
        _transactions = transactions;
        _incomes = transactions.where((t) => t.type == TransactionType.income).toList();
        _spendings = transactions.where((t) => t.type == TransactionType.expense).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateMonthlySums();
    _loadTransactions();
  }

  void _calculateMonthlySums() async {
    final now = DateTime.now();
    _monthlyIncomeSum = await _transactionService.getMonthlySumByType(TransactionType.income, now);
    _monthlySpendingSum = await _transactionService.getMonthlySumByType(TransactionType.expense, now);
  }

  @override
  Widget build(BuildContext context) {
    final currentMonth = DateFormat('M월', 'ko_KR').format(DateTime.now());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 상단 헤더
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '검색',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
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
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(), // 여기로 연결
                            ),
                          );
                        },
                        child: const Text(
                          '설정',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 월 표시
              Text(
                currentMonth,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // 수입/지출/합계 카드

              BalanceSummary(
                income: _monthlyIncomeSum,
                expense: _monthlySpendingSum
              ),

              // 챌린지 상태 카드(임시로 true로 설정)
              const ChallengeStatus(
                hasChallenge: true,
              ),

              const SizedBox(height: 20),
              // 달력 카드
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
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
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
              // 수입/지출내역 카드
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
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = _transactions[index];
                    return TransactionCard(
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final int price;
  final DateTime dateTime;
  final String client;
  final bool isIncome;

  const TransactionCard({
    Key? key,
    required this.price,
    required this.dateTime,
    required this.client,
    required this.isIncome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isIncome ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            client,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${isIncome ? '+' : '-'}$price 원',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}