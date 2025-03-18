import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 2)
class Group extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Group({
    required this.id,
    required this.name,
  });
}