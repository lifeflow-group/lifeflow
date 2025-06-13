import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/local/dao/category_dao.dart';
import '../datasources/local/database_provider.dart';
import '../domain/models/habit_category.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final categoryDao = ref.read(appDatabaseProvider).categoryDao;
  return CategoryRepository(categoryDao);
});

class CategoryRepository {
  final CategoryDao _categoryDao;

  CategoryRepository(this._categoryDao);

  /// Executes multiple database operations as a single transaction
  Future<T> transaction<T>(Future<T> Function() action) {
    return _categoryDao.transaction(action);
  }

  /// Gets all categories
  Future<List<HabitCategory>> getAllCategories() async {
    final categoriesData = await _categoryDao.getAllCategories();

    return categoriesData
        .map((data) => HabitCategory.fromJson({
              'id': data.id,
              'name': data.name,
              'iconPath': data.iconPath,
              'colorHex': data.colorHex,
            }))
        .toList();
  }

  /// Gets a category by its ID
  Future<HabitCategory?> getCategory(String id) async {
    final categoryData = await _categoryDao.getCategory(id);

    if (categoryData == null) return null;

    return HabitCategory.fromJson({
      'id': categoryData.id,
      'name': categoryData.name,
      'iconPath': categoryData.iconPath,
      'colorHex': categoryData.colorHex,
    });
  }
}
