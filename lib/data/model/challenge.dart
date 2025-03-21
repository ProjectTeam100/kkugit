import 'package:hive/hive.dart';

part 'challenge.g.dart';

@HiveType(typeId: 6)
class Challenge extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final DateTime dateTime; //기준 날짜

  @HiveField(2)
  final ChallengeType type; //챌린지 종류

  @HiveField(3)
  final int budget;

  @HiveField(4)
  final ChallengeStatus status; //챌린지 상태

  Challenge({
    required this.id,
    required this.dateTime,
    required this.type,
    required this.budget,
    required this.status,
  });
}

@HiveType(typeId: 7)
enum ChallengeType {
  @HiveField(0)
  noSpend,
  @HiveField(1)
  threeDays,
  @HiveField(2)
  weekly,
  @HiveField(3)
  twoWeeks,
}

@HiveType(typeId: 8)
enum ChallengeStatus {
  @HiveField(0)
  ongoing,
  @HiveField(1)
  success,
  @HiveField(2)
  fail,
}
