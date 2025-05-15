import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  bool isIncome;

  Category({
    required this.id,
    required this.name,
    required this.isIncome,
  });
}
