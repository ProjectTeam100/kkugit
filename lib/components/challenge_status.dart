import 'package:flutter/material.dart';

class ChallengeStatus extends StatelessWidget {
  final bool hasChallenge;
  final String? challengeTitle;

  const ChallengeStatus({
    super.key,
    required this.hasChallenge,
    this.challengeTitle,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasChallenge) return const SizedBox.shrink();

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
      child: const Text(
        '무지출 챌린지 진행 중!',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
