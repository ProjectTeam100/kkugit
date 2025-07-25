import 'package:kkugit/data/constant/preference_name.dart';
import 'package:kkugit/data/model/preference_data.dart';

class Preference {
  final int? id;
  final PreferenceName name; // 설정 이름
  final PreferenceData data; // 설정 값

  Preference({
    this.id,
    required this.name,
    required this.data,
  });
}