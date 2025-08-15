import 'package:flutter/material.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('챌린지'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.emoji_events_outlined, size: 28),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              '챌린지 시작하기!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // 버튼들을 Expanded로 감싸서 화면에 균등 배치
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _challengeButton('무지출 챌린지'),
                  _challengeButton('작심삼일 챌린지'),
                  _challengeButton('일주일 챌린지'),
                  _challengeButton('2주 챌린지'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _challengeButton(String text) {
    return SizedBox(
      width: double.infinity,
      height: 60, // 버튼 높이 키움
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          elevation: 0,
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
