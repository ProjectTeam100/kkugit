import 'package:kkugit/data/model/category.dart';
import 'package:kkugit/data/repository/category_repository.dart';

class CategoryService {
  final CategoryRepository _categoryRepository = CategoryRepository();

  List<Category> fetchAllCategories() {
    return _categoryRepository.getAll();
  }

  Category? fetchCategoryById(int id) {
    return _categoryRepository.getById(id);
  }

  void addCategory(Category category) {
    _categoryRepository.add(category);
  }

  void updateCategory(Category category) {
    _categoryRepository.update(category);
  }

  void deleteCategory(int id) {
    _categoryRepository.delete(id);
  }

  // 기본 카테고리 설정
  Future<void> setDefaultCategories() async {
    if (_categoryRepository.getAll().isEmpty) {
      final defaultCategories = [
        Category(id: 1, name: '카테고리1'),
        Category(id: 2, name: '카테고리2'), 
        Category(id: 3, name: '카테고리3'),
        Category(id: 4, name: '카테고리4'),
      ];
      
      for (var category in defaultCategories) {
        _categoryRepository.add(category);
      }
    }
  }
}