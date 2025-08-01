import 'package:injectable/injectable.dart';
import 'package:kkugit/data/model/preference.dart';
import 'package:kkugit/data/model/preference_data.dart';
import 'package:kkugit/data/constant/preference_name.dart';
import 'package:kkugit/data/repository/preference_repository.dart';
import 'package:kkugit/di/injection.dart';

@LazySingleton()
class PreferenceService {
  final _preferenceRepository = getIt<PreferenceRepository>();

  Future<void> add(String name, PreferenceData data) async {
    final preference = Preference(name: name, data: data);
    await _preferenceRepository.add(preference);
  }

  Future<void> addPreference(Preference preference) async {
    await _preferenceRepository.add(preference);
  }

  Future<void> update(Preference preference) async {
    await _preferenceRepository.update(preference);
  }

  Future<void> updateByName(String name, PreferenceData data) async {
    final existingPreferences = await _preferenceRepository.getByName(name);
    if (existingPreferences.isNotEmpty) {
      final preference = existingPreferences.first;
      final newPreference = Preference(
        id: preference.id,
        name: name,
        data: data,
      );
      await _preferenceRepository.update(newPreference);
    } else {
      await add(name, data);
    }
  }

  Future<void> delete(int id) async {
    await _preferenceRepository.delete(id);
  }

  Future<Preference?> getById(int id) async {
    return await _preferenceRepository.getById(id);
  }

  Future<List<Preference>> getAll() async {
    return await _preferenceRepository.getAll();
  }

  Future<List<Preference>> getByName(String name) async {
    return await _preferenceRepository.getByName(name);
  }

  Future<void> setDefaultPreferences(void print) async {
    final defaultPreferences = [
      Preference(name: PreferenceName.backupData.name, data: StringData('')),
      Preference(name: PreferenceName.restoreData.name, data: StringData('')),
      Preference(
          name: PreferenceName.enablePasscode.name, data: BoolData(false)),
      Preference(name: PreferenceName.passcode.name, data: StringData('')),
      Preference(
          name: PreferenceName.enableReminder.name, data: BoolData(false)),
      Preference(
          name: PreferenceName.reminderTime.name, data: StringData('08:00')),
    ];

    for (var preference in defaultPreferences) {
      final existingPreferences = await getByName(preference.name);
      if (existingPreferences.isEmpty) {
        await addPreference(preference);
      }
    }
  }
}
