import '../../../core/utils/helpers.dart';
import '../app_database.dart';

Future<void> seedDatabase(AppDatabase db) async {
  await seedDefaultCategories(db);
}

Future<void> seedDefaultCategories(AppDatabase db) async {
  final existing = await db.categoryDao.getAllCategories();
  if (existing.isEmpty) {
    for (final category in defaultCategories) {
      await db.categoryDao.insertCategory(
        HabitCategoryTableCompanion.insert(
          id: category.id,
          label: category.label,
          iconPath: category.iconPath,
        ),
      );
    }
  }
}
