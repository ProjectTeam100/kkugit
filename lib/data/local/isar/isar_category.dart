import 'package:isar/isar.dart';
import 'package:kkugit/data/model/category.dart';

part 'isar_category.g.dart';

@collection
class IsarCategory {
  Id id = Isar.autoIncrement;
  late String name; // 카테고리 이름
  @enumerated
  late CategoryType type; // 카테고리 유형 (수입/지출)

  Category toDomain() => Category(id: id, name: name, type: type);

  static IsarCategory fromDomain(Category category) {
    return IsarCategory()
      ..id = category.id ?? Isar.autoIncrement
      ..name = category.name
      ..type = category.type;
  }
}