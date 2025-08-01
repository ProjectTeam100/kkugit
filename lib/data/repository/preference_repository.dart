import 'package:kkugit/data/constant/preference_name.dart';
import 'package:kkugit/data/model/preference.dart';

abstract class PreferenceRepository {
  Future<void> add(Preference preference);
  Future<void> update(Preference preference);
  Future<void> delete(int id);
  Future<Preference?> getById(int id);
  Future<List<Preference>> getAll();
  Future<Preference?> getByName(PreferenceName name);
}
