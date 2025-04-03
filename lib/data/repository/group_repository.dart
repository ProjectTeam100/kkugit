import 'package:hive/hive.dart';
import 'package:kkugit/data/model/group.dart';

class GroupRepository {
  final Box<Group> _groupBox = Hive.box<Group>('groupBox');

  List<Group> getAll() => _groupBox.values.toList();

  Group? getById(int id) => _groupBox.get(id);

  void add(Group group) {
    _groupBox.put(group.id, group);
  }

  void update(Group group) {
    _groupBox.put(group.id, group);
  }

  void delete(int id) {
    _groupBox.delete(id);
  }
}