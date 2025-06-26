import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dao/category_dao.dart';
import '../database_provider.dart';
import '../../../domain/models/category.dart';

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
  Future<List<Category>> getAllCategories() async {
    final categoriesData = await _categoryDao.getAllCategories();

    return categoriesData
        .map((data) => Category.fromJson({
              'id': data.id,
              'name': data.name,
              'iconPath': data.iconPath,
              'colorHex': data.colorHex,
            }))
        .toList();
  }

  /// Gets a category by its ID
  Future<Category?> getCategory(String id) async {
    final categoryData = await _categoryDao.getCategory(id);

    if (categoryData == null) return null;

    return Category.fromJson({
      'id': categoryData.id,
      'name': categoryData.name,
      'iconPath': categoryData.iconPath,
      'colorHex': categoryData.colorHex,
    });
  }
}
