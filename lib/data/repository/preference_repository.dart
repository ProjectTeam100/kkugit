import 'package:hive/hive.dart';
import 'package:kkugit/data/model/preference.dart';

class PreferenceRepository {
  final Box<Preference> _preferenceBox = Hive.box<Preference>('preferenceBox');

  List<Preference> getAll() => _preferenceBox.values.toList();
}