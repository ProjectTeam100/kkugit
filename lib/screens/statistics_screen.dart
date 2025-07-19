import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // 예시용 데이터 - 실제론 DB/로직에서 가져와야 함
  final Map<String, double> categoryData = {
    '식비': 50000,
    '교통비': 20000,
    '쇼핑': 35000,
    '기타': 15000,
  };

  // 1일부터 30일까지 일별 지출
  final List<double> dailySpending = List.generate(30, (index) => (index * 1000 + 5000).toDouble());

  // 요일별 지출 (월~일)
  final List<double> weekdaySpending = [10000, 15000, 12000, 18000, 14000, 20000, 16000];

  String selectedMonth = DateFormat('yyyy-MM').format(DateTime.now());

  List<String> last12Months = List.generate(12, (index) {
    final date = DateTime(DateTime.now().year, DateTime.now().month - index, 1);
    return DateFormat('yyyy-MM').format(date);
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('통계'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 달 선택 Dropdown
            Row(
              children: [
                const Text('월 선택: ', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedMonth,
                  items: last12Months
                      .map((month) => DropdownMenuItem(
                    value: month,
                    child: Text(month),
                  ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedMonth = value;
                        // TODO: 선택된 달에 맞게 데이터 갱신
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 1. 카테고리별 원 그래프
            const Text('카테고리별 지출', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: categoryData.entries.map((entry) {
                    final percent = entry.value /
                        categoryData.values.fold(0, (prev, el) => prev + el) *
                        100;
                    return PieChartSectionData(
                      value: entry.value,
                      title: '${entry.key}\n${percent.toStringAsFixed(1)}%',
                      radius: 60,
                      titleStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 2. 매일매일 사용 금액 (줄 그래프)
            const Text('일별 지출 금액', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        getTitlesWidget: (value, _) {
                          int day = value.toInt();
                          if (day < 1 || day > dailySpending.length) return const SizedBox.shrink();
                          return Text('$day일', style: const TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, interval: 10000),
                    ),
                  ),
                  minX: 1,
                  maxX: dailySpending.length.toDouble(),
                  minY: 0,
                  maxY: dailySpending.reduce((a, b) => a > b ? a : b) * 1.2,
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(dailySpending.length,
                              (i) => FlSpot((i + 1).toDouble(), dailySpending[i])),
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.blue,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 3. 요일별 사용 금액 (막대 그래프)
            const Text('요일별 지출 금액', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['월', '화', '수', '목', '금', '토', '일'];
                          if (value.toInt() < 0 || value.toInt() >= days.length) return const SizedBox.shrink();
                          return Text(days[value.toInt()], style: const TextStyle(fontSize: 12));
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, interval: 5000),
                    ),
                  ),
                  maxY: weekdaySpending.reduce((a, b) => a > b ? a : b) * 1.2,
                  barGroups: List.generate(weekdaySpending.length, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: weekdaySpending[i],
                          color: Colors.green,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}