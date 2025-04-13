import 'package:hive/hive.dart';
import 'package:kkugit/data/model/category.dart';

class CategoryRepository {
  final Box<Category> _categoryBox = Hive.box<Category>('categoryBox');

  List<Category> getAll() => _categoryBox.values.toList();

  Category? getById(int id) => _categoryBox.get(id);

  void add(Category category) {
    _categoryBox.add(category);
  }

  void update(Category category) {
    _categoryBox.put(category.id, category);
  }

  void delete(int id) {
    _categoryBox.delete(id);
  }

}