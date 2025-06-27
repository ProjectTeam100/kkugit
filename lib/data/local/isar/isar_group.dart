import 'package:isar/isar.dart';
import 'package:kkugit/data/model/group.dart';

part 'isar_group.g.dart';

@collection
class IsarGroup {
  Id id = Isar.autoIncrement;
  late String name; // 그룹 이름
  @enumerated
  late GroupType type; // 그룹 유형

  Group toDomain() => Group(id: id, name: name, type: type);

  static IsarGroup fromDomain(Group group) {
    return IsarGroup()
      ..id = group.id ?? Isar.autoIncrement
      ..name = group.name
      ..type = group.type;
  }
}