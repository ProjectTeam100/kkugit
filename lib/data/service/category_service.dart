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

    if (_categoryRepository.isEmpty) {
      _categoryRepository.addAll([
        //지출 카테고리
        Category(id: 1, name: '🍽️ 식비', isIncome: false),
        Category(id: 2, name: '🚗 교통/차량', isIncome: false),
        Category(id: 3, name: '🎬 문화생활', isIncome: false),
        Category(id: 4, name: '🛒 마트/편의점', isIncome: false),
        Category(id: 5, name: '👗 패션/미용', isIncome: false),
        Category(id: 6, name: '🧻 생활용품', isIncome: false),
        Category(id: 7, name: '🏠 주거/통신', isIncome: false),
        Category(id: 8, name: '🏥 건강', isIncome: false),
        Category(id: 9, name: '📚 교육', isIncome: false),
        Category(id: 10, name: '🎁 경조사/회비', isIncome: false),
        Category(id: 11, name: '👨‍👩‍👧 부모님', isIncome: false),
        Category(id: 12, name: '📦 기타', isIncome: false),

        //수입 카테고리
        Category(id: 101, name: '💰 월급', isIncome: true),
        Category(id: 102, name: '💵 부수입', isIncome: true),
        Category(id: 103, name: '🤑 용돈', isIncome: true),
        Category(id: 104, name: '🏅 상여', isIncome: true),
      ]);
    }
  }
}
