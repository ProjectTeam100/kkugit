import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:kkugit/data/local/isar/isar_category.dart';
import 'package:kkugit/data/model/category.dart';
import 'package:kkugit/data/repository/category_repository.dart';

@LazySingleton(as: CategoryRepository)
class IsarCategoryRepository implements CategoryRepository {
  final Isar _isar;

  IsarCategoryRepository(this._isar);

  @override
  Future<void> add(Category category) async {
    final entity = IsarCategory.fromDomain(category);
    await _isar.writeTxn(() => _isar.isarCategorys.put(entity));
  }

  @override
  Future<void> update(Category category) async {
    final entity = IsarCategory.fromDomain(category);
    await _isar.writeTxn(() => _isar.isarCategorys.put(entity));
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() => _isar.isarCategorys.delete(id));
  }

  @override
  Future<Category?> getById(int id) async {
    final entity = await _isar.isarCategorys.get(id);
    return entity?.toDomain();
  }

  @override
  Future<Category?> getByName(String name) async {
    final entity = await _isar.isarCategorys.filter()
        .nameEqualTo(name)
        .findFirst();
    return entity?.toDomain();
  }

  @override
  Future<List<Category>> getAll() async {
    final entities = await _isar.isarCategorys.where().findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Category>> getByType(CategoryType type) async {
    final entities = await _isar.isarCategorys.filter()
        .typeEqualTo(type)
        .findAll();
    return entities.map((e) => e.toDomain()).toList();
  }
}