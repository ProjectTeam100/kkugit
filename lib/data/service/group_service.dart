import 'package:kkugit/data/model/group.dart';
import 'package:kkugit/data/repository/group_repository.dart';

class GroupService {
  final GroupRepository _groupRepository = GroupRepository();

  List<Group> fetchAllGroups() {
    return _groupRepository.getAll();
  }

  Group? fetchGroupById(int id) {
    return _groupRepository.getById(id);
  }

  void addGroup(Group group) {
    _groupRepository.add(group);
  }

  void updateGroup(Group group) {
    _groupRepository.update(group);
  }

  void deleteGroup(int id) {
    _groupRepository.delete(id);
  }
}