import 'package:hive/hive.dart';
import 'package:kkugit/data/model/group.dart';

class GroupRepository {
  final Box<Group> _groupBox = Hive.box<Group>('groupBox');

  List<Group> getAll() => _groupBox.values.toList();
}