enum ChallengeType {
  noSpend, // 무지출
  threeDays, // 3일 챌린지
  weekly, // 주간 챌린지
  twoWeeks, // 2주 챌린지
}

enum ChallengeStatus {
  notStarted, // 시작 전
  ongoing, // 진행 중
  success, // 성공
  fail, // 실패
}

class Challenge {
  final int? id;
  final DateTime dateTime; // 기준 날짜
  final ChallengeType type; // 챌린지 종류
  final int amount; // 예산
  final ChallengeStatus status; // 챌린지 상태

  Challenge({
    this.id,
    required this.dateTime,
    required this.type,
    required this.amount,
    required this.status,
  });
}