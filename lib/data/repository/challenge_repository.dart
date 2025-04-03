import 'package:hive/hive.dart';
import 'package:kkugit/data/model/challenge.dart';

class ChallengeRepository {
  final Box<Challenge> _challengeBox = Hive.box<Challenge>('challengeBox');

  List<Challenge> getAll() => _challengeBox.values.toList();

  Challenge? getById(int id) => _challengeBox.get(id);

  void add(Challenge challenge) {
    _challengeBox.put(challenge.id, challenge);
  }

  void update(Challenge challenge) {
    _challengeBox.put(challenge.id, challenge);
  }

  void delete(int id) {
    _challengeBox.delete(id);
  }
}