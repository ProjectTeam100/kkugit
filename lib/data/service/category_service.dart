import 'package:hive/hive.dart';
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
    final box = await Hive.openBox<Category>('categoryBox');

    if (box.isEmpty) {
      await box.addAll([
        Category(id: 1, name: '🍽️ 식비'),
        Category(id: 2, name: '🚗 교통/차량'),
        Category(id: 3, name: '🎬 문화생활'),
        Category(id: 4, name: '🛒 마트/편의점'),
        Category(id: 5, name: '👗 패션/미용'),
        Category(id: 6, name: '🧻 생활용품'),
        Category(id: 7, name: '🏠 주거/통신'),
        Category(id: 8, name: '🏥 건강'),
        Category(id: 9, name: '📚 교육'),
        Category(id: 10, name: '🎁 경조사/회비'),
        Category(id: 11, name: '👨‍👩‍👧 부모님'),
        Category(id: 12, name: '📦 기타'),
      ]);
    }
  }
}
