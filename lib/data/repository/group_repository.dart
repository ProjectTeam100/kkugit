import 'package:kkugit/data/model/group.dart';

abstract class GroupRepository {
  Future<void> add(Group group);
  Future<void> update(Group group);
  Future<void> delete(int id);
  Future<Group?> getById(int id);
  Future<List<Group>> getAll();
  Future<List<Group>> getByType(GroupType type);
}