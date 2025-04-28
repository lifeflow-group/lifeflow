import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/habit_categories_table.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [HabitCategoriesTable])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  final AppDatabase db;

  CategoryDao(this.db) : super(db);

  /// Inserts a new category into the database.
  /// If the id already exists, it will be replaced.
  Future<int> insertCategory(HabitCategoriesTableCompanion category) {
    return into(habitCategoriesTable)
        .insert(category, mode: InsertMode.insertOrReplace);
  }

  /// Retrieves all categories from the database.
  Future<List<HabitCategoriesTableData>> getAllCategories() {
    return select(habitCategoriesTable).get();
  }

  /// Deletes a category by its ID.
  Future<int> deleteCategory(String id) {
    return (delete(habitCategoriesTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  /// Updates an existing category.
  Future<bool> updateCategory(HabitCategoriesTableData category) {
    return update(habitCategoriesTable).replace(category);
  }

  /// Retrieves a single category by its ID.
  Future<HabitCategoriesTableData?> getCategory(String id) {
    return (select(habitCategoriesTable)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }
}
