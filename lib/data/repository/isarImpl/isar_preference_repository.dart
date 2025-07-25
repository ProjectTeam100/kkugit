import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:kkugit/data/constant/preference_name.dart';
import 'package:kkugit/data/local/isar/isar_preference.dart';
import 'package:kkugit/data/model/preference.dart';
import 'package:kkugit/data/repository/preference_repository.dart';

@LazySingleton(as: PreferenceRepository)
class IsarPreferenceRepository implements PreferenceRepository {
  final Isar _isar;
  IsarPreferenceRepository(this._isar);

  @override
  Future<void> add(Preference preference) async {
    final entity = IsarPreference.fromDomain(preference);
    await _isar.writeTxn(() => _isar.isarPreferences.put(entity));
  }

  @override
  Future<void> update(Preference preference) async {
    final entity = IsarPreference.fromDomain(preference);
    await _isar.writeTxn(() => _isar.isarPreferences.put(entity));
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() => _isar.isarPreferences.delete(id));
  }

  @override
  Future<Preference?> getById(int id) async {
    final entity = await _isar.isarPreferences.get(id);
    return entity?.toDomain();
  }

  @override
  Future<List<Preference>> getAll() async {
    final entities = await _isar.isarPreferences.where().findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Preference>> getByName(PreferenceName name) async {
    final entities = await _isar.isarPreferences.filter()
        .nameEqualTo(name)
        .findAll();
    return entities.map((e) => e.toDomain()).toList();
  }
}