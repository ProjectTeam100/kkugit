import 'package:kkugit/data/model/challenge.dart';

abstract class ChallengeRepository {
  Future<void> add(Challenge challenge);
  Future<void> update(Challenge challenge);
  Future<void> delete(int id);
  Future<Challenge?> getById(int id);
  Future<List<Challenge>> getAll();
  Future<List<Challenge>> getByStatus(ChallengeStatus status);
  Future<List<Challenge>> getByType(ChallengeType type);
}