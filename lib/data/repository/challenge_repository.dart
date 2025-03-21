import 'package:hive/hive.dart';
import 'package:kkugit/data/model/challenge.dart';

class ChallengeRepository {
  final Box<Challenge> _challengeBox = Hive.box<Challenge>('challengeBox');

  List<Challenge> getAll() => _challengeBox.values.toList();
}