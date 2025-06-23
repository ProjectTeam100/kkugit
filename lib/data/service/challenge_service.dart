import 'package:kkugit/data/model/challenge.dart';
import 'package:kkugit/data/repository/challenge_repository.dart';
import 'package:kkugit/di/injection.dart';

class ChallengeService {
  final _challengeRepository = getIt<ChallengeRepository>();

  Future<void> add(
      DateTime dateTime,
      ChallengeType type,
      int amount,
      ChallengeStatus status
      ) async {
    final challenge = Challenge(
      dateTime: dateTime,
      type: type,
      amount: amount,
      status: status,
    );
    await _challengeRepository.add(challenge);
  }

  Future<void> update(Challenge challenge) async {
    await _challengeRepository.update(challenge);
  }

  Future<void> delete(int id) async {
    await _challengeRepository.delete(id);
  }

  Future<Challenge?> getById(int id) async {
    return await _challengeRepository.getById(id);
  }

  Future<List<Challenge>> getAll() async {
    return await _challengeRepository.getAll();
  }

  Future<List<Challenge>> getByStatus(ChallengeStatus status) async {
    return await _challengeRepository.getByStatus(status);
  }

  Future<List<Challenge>> getByType(ChallengeType type) async {
    return await _challengeRepository.getByType(type);
  }
}