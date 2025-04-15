import 'package:kkugit/data/model/preference.dart';
import 'package:kkugit/data/repository/preference_repository.dart';

class PreferenceService {
  final PreferenceRepository _preferenceRepository = PreferenceRepository();

  List<Preference> fetchAllPreferences() {
    return _preferenceRepository.getAll();
  }

  Preference? fetchPreferenceById(int id) {
    return _preferenceRepository.getById(id);
  }

  void addPreference(Preference preference) {
    _preferenceRepository.add(preference);
  }

  void updatePreference(Preference preference) {
    _preferenceRepository.update(preference);
  }

  void deletePreference(int id) {
    _preferenceRepository.delete(id);
  }

}
