import 'package:kkugit/data/model/challenge.dart';
import 'package:kkugit/data/repository/challenge_repository.dart';

class ChallengeService {
  final ChallengeRepository _challengeRepository = ChallengeRepository();

  List<Challenge> fetchAllChallenges() {
    return _challengeRepository.getAll();
  }

  Challenge? fetchChallengeById(int id) {
    return _challengeRepository.getById(id);
  }

  void addChallenge(Challenge challenge) {
    _challengeRepository.add(challenge);
  }

  void updateChallenge(Challenge challenge) {
    _challengeRepository.update(challenge);
  }

  void deleteChallenge(int id) {
    _challengeRepository.delete(id);
  }
}