import 'package:drift/drift.dart';

import '../../../core/utils/helpers.dart';
import '../app_database.dart';
import '../tables/habit_categories.dart';
import '../tables/habits.dart';

part 'habit_dao.g.dart';

@DriftAccessor(tables: [HabitTable, HabitCategoryTable])
class HabitDao extends DatabaseAccessor<AppDatabase> with _$HabitDaoMixin {
  HabitDao(super.db);

  /// Insert a new habit
  Future<int> insertHabit(HabitTableCompanion habit) =>
      into(habitTable).insert(habit);

  /// Get all habits
  Future<List<HabitTableData>> getAllHabits() => select(habitTable).get();

  /// Delete habit by id
  Future<int> deleteHabit(String id) =>
      (delete(habitTable)..where((tbl) => tbl.id.equals(id))).go();

  /// Optional: Update habit (if needed)
  Future<bool> updateHabit(HabitTableData habit) =>
      update(habitTable).replace(habit);

  Future<List<(HabitTableData, HabitCategoryTableData)>>
      getHabitsWithCategoriesByDate(
    DateTime selectedDate,
  ) {
    final date = selectedDate.toLocal();

    final from = DateTime(date.year, date.month, date.day);
    final to = from
        .add(const Duration(days: 1))
        .subtract(const Duration(milliseconds: 1));

    final habit = alias(habitTable, 'habit');
    final category = alias(habitCategoryTable, 'category');

    final query = select(habit).join([
      leftOuterJoin(
        category,
        category.id.equalsExp(habit.categoryId),
      ),
    ])
      ..where(
        (habit.repeatFrequency.equals('daily')) |
            (habit.startDate.isBetween(
              Variable(from.toUtc()),
              Variable(to.toUtc()),
            )),
      );

    return query.map((row) {
      final habitData = row.readTable(habit);
      final categoryData = row.readTableOrNull(category) ??
          HabitCategoryTableData.fromJson(defaultCategories[0].toJson());
      return (habitData, categoryData);
    }).get();
  }
}
