import 'package:hive/hive.dart';

part 'preference.g.dart';

@HiveType(typeId: 5)
class Preference extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name; //설정 이름

  @HiveField(2)
  final Object data; //설정 값

  Preference({
    required this.id,
    required this.name,
    required this.data,
  });
}