import 'package:kkugit/data/model/category.dart';
import 'package:kkugit/data/repository/category_repository.dart';
import 'package:kkugit/di/injection.dart';

class CategoryService {
  final _categoryRepository = getIt<CategoryRepository>();

  Future<void> add(String name, CategoryType type) async {
    final category = Category(name: name, type: type);
    await _categoryRepository.add(category);
  }

  Future<void> update(Category category) async {
    await _categoryRepository.update(category);
  }

  Future<void> delete(int id) async {
    await _categoryRepository.delete(id);
  }

  Future<Category?> getById(int id) async {
    return await _categoryRepository.getById(id);
  }

  Future<List<Category>> getAll() async {
    return await _categoryRepository.getAll();
  }

  Future<List<Category>> getByType(CategoryType type) async {
    return await _categoryRepository.getByType(type);
  }
}