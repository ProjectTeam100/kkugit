import 'package:injectable/injectable.dart';
import 'package:kkugit/data/model/category.dart';
import 'package:kkugit/data/repository/category_repository.dart';
import 'package:kkugit/di/injection.dart';

@LazySingleton()
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

  // 수입/지출 카테고리 조회 (CategoryType.INCOME, CategoryType.EXPENSE)
  Future<List<Category>> getByType(CategoryType type) async {
    return await _categoryRepository.getByType(type);
  }

  // 기본 카테고리 설정 (최초 실행 시)
  Future<void> setDefaultCategories() async {
    final incomeDefault = [ // 수입 카테고리
      '🍽️ 식비', '🚗 교통/차량', '🎬 문화생활', '🛒 마트/편의점',
      '👗 패션/미용', '🧻 생활용품', '🏠 주거/통신', '🏥 건강',
      '📚 교육', '🎁 경조사/회비', '👨‍👩‍👧 부모님', '📦 기타',
    ];
    final expenseDefault = [ // 지출 카테고리
      '💰 월급', '💵 부수입', '🤑 용돈', '🏅 상여',
    ];

    for (var name in incomeDefault) {
      final category = Category(name: name, type: CategoryType.expense);
      if (await _categoryRepository.getByName(name) == null) {
        await _categoryRepository.add(category);
      }
    }

    for (var name in expenseDefault) {
      final category = Category(name: name, type: CategoryType.income);
      if (await _categoryRepository.getByName(name) == null) {
        await _categoryRepository.add(category);
      }
    }
  }
}