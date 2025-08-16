import 'package:flutter/material.dart';

enum ChallengeType {
  noSpend,
  twoWeeks,
  oneMonth,
  custom,
}

void showChallengeDialog(BuildContext context, ChallengeType type) {
  final TextEditingController periodController = TextEditingController();
  final TextEditingController spendingController = TextEditingController();

  if (type == ChallengeType.noSpend) {
    spendingController.text = '0';
  }

  showDialog(
    context: context,
    builder: (context) {
      final mediaQuery = MediaQuery.of(context);
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: mediaQuery.size.height * 0.5, // 화면 높이 50%로 제한
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  type == ChallengeType.noSpend ? '무지출 챌린지' : '챌린지 설정',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: periodController,
                  decoration: const InputDecoration(
                    labelText: '기간(일)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: spendingController,
                  decoration: const InputDecoration(
                    labelText: '지출(원)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  enabled: type != ChallengeType.noSpend,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('취소'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        final period = periodController.text;
                        final spending = spendingController.text;
                        print('기간: $period, 지출: $spending');
                        Navigator.pop(context);
                      },
                      child: const Text('챌린지 시작!'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
