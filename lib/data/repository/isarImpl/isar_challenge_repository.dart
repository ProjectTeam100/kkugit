import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:kkugit/data/local/isar/isar_challenge.dart';
import 'package:kkugit/data/model/challenge.dart';
import 'package:kkugit/data/repository/challenge_repository.dart';

@LazySingleton(as: ChallengeRepository)
class IsarChallengeRepository implements ChallengeRepository {
  final Isar _isar;

  IsarChallengeRepository(this._isar);

  @override
  Future<void> add(Challenge challenge) async {
    final entity = IsarChallenge.fromDomain(challenge);
    await _isar.writeTxn(() => _isar.isarChallenges.put(entity));
  }

  @override
  Future<void> update(Challenge challenge) async {
    final entity = IsarChallenge.fromDomain(challenge);
    await _isar.writeTxn(() => _isar.isarChallenges.put(entity));
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() => _isar.isarChallenges.delete(id));
  }

  @override
  Future<Challenge?> getById(int id) async {
    final entity = await _isar.isarChallenges.get(id);
    return entity?.toDomain();
  }

  @override
  Future<List<Challenge>> getAll() async {
    final entities = await _isar.isarChallenges.where().findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Challenge>> getByStatus(ChallengeStatus status) async {
    final entities = await _isar.isarChallenges.filter()
        .statusEqualTo(status)
        .findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Challenge>> getByType(ChallengeType type) async {
    final entities = await _isar.isarChallenges.filter()
        .typeEqualTo(type)
        .findAll();
    return entities.map((e) => e.toDomain()).toList();
  }
}