import 'package:kkugit/data/model/group.dart';
import 'package:kkugit/data/repository/group_repository.dart';
import 'package:kkugit/di/injection.dart';

class GroupService {
  final _groupRepository = getIt<GroupRepository>();

  Future<void> add(String name, GroupType type) async {
    final group = Group(name: name, type: type);
    await _groupRepository.add(group);
  }

  Future<void> update(Group group) async {
    await _groupRepository.update(group);
  }

  Future<void> delete(int id) async {
    await _groupRepository.delete(id);
  }

  Future<Group?> getById(int id) async {
    return await _groupRepository.getById(id);
  }

  Future<List<Group>> getAll() async {
    return await _groupRepository.getAll();
  }

  Future<List<Group>> getByType(GroupType type) async {
    return await _groupRepository.getByType(type);
  }

}