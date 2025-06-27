import 'package:injectable/injectable.dart';
import 'package:kkugit/data/model/preference.dart';
import 'package:kkugit/data/model/preferenceData.dart';
import 'package:kkugit/data/repository/preference_repository.dart';
import 'package:kkugit/di/injection.dart';

@LazySingleton()
class PreferenceService {
  final _preferenceRepository = getIt<PreferenceRepository>();

  Future<void> add(String name, PreferenceData data) async {
    final preference = Preference(name: name, data: data);
    await _preferenceRepository.add(preference);
  }

  Future<void> update(Preference preference) async {
    await _preferenceRepository.update(preference);
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
}
