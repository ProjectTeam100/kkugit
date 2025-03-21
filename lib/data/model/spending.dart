import 'package:hive/hive.dart';

part 'spending.g.dart';

@HiveType(typeId: 0)
class Spending extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final DateTime dateTime;

  @HiveField(2)
  final String client; //내역

  @HiveField(3)
  final String payment; //결제수단

  @HiveField(4)
  final int category; //카테고리 id

  @HiveField(5)
  final int group; //그룹 id

  @HiveField(6)
  final int price;

  @HiveField(7)
  final String memo;

  Spending({
    required this.id,
    required this.dateTime,
    required this.client,
    required this.payment,
    required this.category,
    required this.group,
    required this.price,
    required this.memo,
  });
}

