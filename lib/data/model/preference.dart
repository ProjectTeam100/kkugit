import 'package:kkugit/data/model/preferenceData.dart';

class Preference {
  final int? id;
  final String name; // 설정 이름
  final PreferenceData data; // 설정 값

  Preference({
    this.id,
    required this.name,
    required this.data,
  });
}