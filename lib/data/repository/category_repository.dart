import 'package:hive/hive.dart';
import 'package:kkugit/data/model/category.dart';

class CategoryRepository {
  final Box<Category> _categoryBox = Hive.box<Category>('categoryBox');

  List<Category> getAll() => _categoryBox.values.toList();
}