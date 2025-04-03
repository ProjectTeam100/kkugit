import 'package:hive/hive.dart';
import 'package:kkugit/data/model/preference.dart';

class PreferenceRepository {
  final Box<Preference> _preferenceBox = Hive.box<Preference>('preferenceBox');

  List<Preference> getAll() => _preferenceBox.values.toList();

  Preference? getById(int id) => _preferenceBox.get(id);

  void add(Preference preference) {
    _preferenceBox.put(preference.id, preference);
  }

  void update(Preference preference) {
    _preferenceBox.put(preference.id, preference);
  }

  void delete(int id) {
    _preferenceBox.delete(id);
  }
}