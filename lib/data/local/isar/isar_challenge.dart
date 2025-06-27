import 'package:isar/isar.dart';
import 'package:kkugit/data/model/challenge.dart';

part 'isar_challenge.g.dart';

@collection
class IsarChallenge {
  Id id = Isar.autoIncrement;
  late DateTime dateTime; // 기준 날짜
  @enumerated
  late ChallengeType type;
  late int amount; // 예산
  @enumerated
  late ChallengeStatus status; // 챌린지 상태

  Challenge toDomain() => Challenge(
    id: id,
    dateTime: dateTime,
    type: type,
    amount: amount,
    status: status,
  );

  static IsarChallenge fromDomain(Challenge challenge) {
    return IsarChallenge()
      ..id = challenge.id ?? Isar.autoIncrement
      ..dateTime = challenge.dateTime
      ..type = challenge.type
      ..amount = challenge.amount
      ..status = challenge.status;
  }
}