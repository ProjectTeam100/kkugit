import 'package:hive/hive.dart';

part 'income.g.dart';

@HiveType(typeId: 9)
class Income extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final DateTime dateTime;

  @HiveField(2)
  final String client; //내역

  @HiveField(3)
  final int category; //카테고리 id

  @HiveField(4)
  final int group; //그룹 id

  @HiveField(5)
  final int price;

  @HiveField(6)
  final String memo;

  Income({
    required this.id,
    required this.dateTime,
    required this.client,
    required this.category,
    required this.group,
    required this.price,
    required this.memo,
  });
}