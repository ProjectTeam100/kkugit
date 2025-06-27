import 'package:kkugit/data/model/category.dart';

abstract class CategoryRepository {
  Future<void> add(Category category);
  Future<void> update(Category category);
  Future<void> delete(int id);
  Future<Category?> getById(int id);
  Future<List<Category>> getAll();
  Future<Category?> getByName(String name);
  Future<List<Category>> getByType(CategoryType type);
}