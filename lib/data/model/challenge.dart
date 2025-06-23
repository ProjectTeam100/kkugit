enum ChallengeType {
  NO_SPEND, // 무지출
  THREE_DAYS, // 3일 챌린지
  WEEKLY, // 주간 챌린지
  TWO_WEEKLY, // 2주 챌린지
}

enum ChallengeStatus {
  NOT_STARTED, // 시작 전
  ONGOING, // 진행 중
  SUCCESS, // 성공
  FAIL, // 실패
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