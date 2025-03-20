import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/habit_categories.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [HabitCategoryTable])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  final AppDatabase db;

  CategoryDao(this.db) : super(db);

  /// Inserts a new category into the database.
  /// If the id already exists, it will be replaced.
  Future<int> insertCategory(HabitCategoryTableCompanion category) {
    return into(habitCategoryTable)
        .insert(category, mode: InsertMode.insertOrReplace);
  }

  /// Retrieves all categories from the database.
  Future<List<HabitCategoryTableData>> getAllCategories() {
    return select(habitCategoryTable).get();
  }

  /// Deletes a category by its ID.
  Future<int> deleteCategory(String id) {
    return (delete(habitCategoryTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Updates an existing category.
  Future<bool> updateCategory(HabitCategoryTableData category) {
    return update(habitCategoryTable).replace(category);
  }

  /// Retrieves a single category by its ID.
  Future<HabitCategoryTableData?> getCategoryById(String id) {
    return (select(habitCategoryTable)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }
}
