import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:kkugit/data/constant/messages.dart';
import 'package:kkugit/data/model/preference.dart';
import 'package:kkugit/data/model/preference_data.dart';
import 'package:kkugit/data/constant/preference_name.dart';
import 'package:kkugit/data/repository/preference_repository.dart';
import 'package:kkugit/di/injection.dart';

@LazySingleton()
class PreferenceService {
  final _preferenceRepository = getIt<PreferenceRepository>();

  // 리마인더 시간 변경 알림
  final _reminderController = StreamController<String>.broadcast();
  Stream<String> get reminderStream => _reminderController.stream;

  void reminderInitialize() async {
    // 리마인더 시간 초기화
    final isEnabled = await this.isEnabled(PreferenceName.enableReminder);
    if (isEnabled) {
      getByName(PreferenceName.reminderTime).then((preference) {
        if (preference != null && preference.data is StringData) {
          final timeString = (preference.data as StringData).value;
          _reminderController.add(timeString);
        }
      });
    }
  }

  Future<void> add(PreferenceName name, PreferenceData data) async {
    final preference = Preference(name: name, data: data);
    await _preferenceRepository.add(preference);
  }

  Future<void> addPreference(Preference preference) async {
    await _preferenceRepository.add(preference);
  }

  Future<void> update(Preference preference) async {
    await _preferenceRepository.update(preference);
  }

  Future<void> updateByName(PreferenceName name, PreferenceData data) async {
    final existingPreference = await _preferenceRepository.getByName(name);
    if (existingPreference != null) {
      final newPreference = Preference(
        id: existingPreference.id,
        name: name,
        data: data,
      );
      await _preferenceRepository.update(newPreference);
    } else {
      await add(name, data);
    }

    // 리마인더 설정 변경 알림
    if (name == PreferenceName.reminderTime) {
      final timeString = (data as StringData).value;
      _reminderController.add(timeString);
    }
    if (name == PreferenceName.enableReminder) {
      final isEnabled = (data as BoolData).value;
      if (isEnabled) {
        final timeString =
            (await getDataByName(PreferenceName.reminderTime) as StringData?)
                    ?.value ??
                '';
        _reminderController.add(timeString);
      } else {
        _reminderController.add(Messages.reminderDisabled.name);
      }
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

  Future<Preference?> getByName(PreferenceName name) async {
    return await _preferenceRepository.getByName(name);
  }

  Future<bool> isEnabled(PreferenceName name) async {
    final preference = await getByName(name);
    if (preference?.data is BoolData) {
      return (preference!.data as BoolData).value;
    }
    return false;
  }

  Future<PreferenceData?> getDataByName(PreferenceName name) async {
    final preference = await getByName(name);
    return preference?.data;
  }

  Future<void> setDefaultPreferences() async {
    final defaultPreferences = [
      Preference(name: PreferenceName.backupData, data: StringData('')),
      Preference(name: PreferenceName.restoreData, data: StringData('')),
      Preference(name: PreferenceName.enablePasscode, data: BoolData(false)),
      Preference(name: PreferenceName.passcode, data: StringData('')),
      Preference(name: PreferenceName.enableReminder, data: BoolData(false)),
      Preference(name: PreferenceName.reminderTime, data: StringData('08:00')),
    ];

    for (var preference in defaultPreferences) {
      final existingPreference = await getByName(preference.name);
      if (existingPreference == null) {
        await addPreference(preference);
      }
    }
  }
}
