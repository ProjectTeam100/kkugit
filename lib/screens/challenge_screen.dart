import 'package:flutter/material.dart';
import '../components/challenge_popup.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  void _showChallengePopup(BuildContext context, String challengeName) {
    // 버튼 텍스트에 따라 ChallengeType 지정
    ChallengeType type;
    switch (challengeName) {
      case '무지출 챌린지':
        type = ChallengeType.noSpend;
        break;
      case '작심삼일 챌린지':
        type = ChallengeType.custom;
        break;
      case '일주일 챌린지':
        type = ChallengeType.oneMonth; // 7일 정도 커스텀으로 바꿀 수 있음
        break;
      case '2주 챌린지':
        type = ChallengeType.twoWeeks;
        break;
      default:
        type = ChallengeType.custom;
    }

    // 아까 만든 함수 호출
    showChallengeDialog(context, type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
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
            const CircleAvatar(radius: 80, backgroundColor: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              '챌린지 시작하기!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _challengeButton(context, '무지출 챌린지'),
                  _challengeButton(context, '작심삼일 챌린지'),
                  _challengeButton(context, '일주일 챌린지'),
                  _challengeButton(context, '2주 챌린지'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _challengeButton(BuildContext context, String text) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          elevation: 0,
        ),
        onPressed: () => _showChallengePopup(context, text),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
