import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:kkugit/data/local/isar/isar_group.dart';
import 'package:kkugit/data/model/group.dart';
import 'package:kkugit/data/repository/group_repository.dart';

@LazySingleton(as: GroupRepository)
class IsarGroupRepository implements GroupRepository {
  final Isar _isar;

  IsarGroupRepository(this._isar);

  @override
  Future<void> add(Group group) async {
    final entity = IsarGroup.fromDomain(group);
    await _isar.writeTxn(() => _isar.isarGroups.put(entity));
  }

  @override
  Future<void> update(Group group) async {
    final entity = IsarGroup.fromDomain(group);
    await _isar.writeTxn(() => _isar.isarGroups.put(entity));
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() => _isar.isarGroups.delete(id));
  }

  @override
  Future<Group?> getById(int id) async {
    final entity = await _isar.isarGroups.get(id);
    return entity?.toDomain();
  }

  @override
  Future<List<Group>> getAll() async {
    final entities = await _isar.isarGroups.where().findAll();
    return entities.map((e) => e.toDomain()).toList();
  }
  
  @override
  Future<List<Group>> getByType(GroupType type) async {
    final entities = await _isar.isarGroups.filter()
        .typeEqualTo(type)
        .findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

}