import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:lifeflow/data/database/tables/habit_exceptions_table.dart';

import '../../../core/utils/helpers.dart';
import '../app_database.dart';
import '../tables/habit_categories_table.dart';
import '../tables/habit_series_table.dart';
import '../tables/habits_table.dart';

part 'habit_dao.g.dart';

@DriftAccessor(tables: [
  HabitsTable,
  HabitCategoriesTable,
  HabitSeriesTable,
  HabitExceptionsTable
])
class HabitDao extends DatabaseAccessor<AppDatabase> with _$HabitDaoMixin {
  HabitDao(super.db);

  /// Insert a new habit
  Future<int> insertHabit(HabitsTableCompanion habit) =>
      into(habitsTable).insert(habit);

  /// Get all habits
  Future<List<HabitsTableData>> getAllHabits() => select(habitsTable).get();

  /// Delete habit by id
  Future<int> deleteHabit(String id) =>
      (delete(habitsTable)..where((tbl) => tbl.id.equals(id))).go();

  /// Optional: Update habit (if needed)
  Future<bool> updateHabit(HabitsTableData habit) =>
      update(habitsTable).replace(habit);

  Future<List<(HabitsTableData, HabitCategoriesTableData)>>
      getHabitsWithCategoriesByDate(DateTime dateLocal, String? userId) async {
    if (userId == null) return [];

    // 1. Get the list of recurring series for that day
    final recurringSeries =
        await _getRecurringHabitSeriesByDate(dateLocal, userId);

    // 2. Get the list of exceptions (for skip [Step 3] and overrides [Step 5])
    final exceptionsBySeriesId = await _getHabitExceptionsByDate(dateLocal);

    // 3. Filter skipped series
    final skippedSeriesIds = exceptionsBySeriesId.entries
        .where((entry) => entry.value.isSkipped)
        .map((entry) => entry.key)
        .toSet();

    // 4. Retrieves habits for a specific date
    final habitRows = await _getHabitRowsForDate(
        dateLocal, recurringSeries, skippedSeriesIds, userId);

    // 5. Override habit data from exceptions (if any)
    final result = habitRows.map((row) {
      final habit = row.readTable(habitsTable);
      final category = row.readTableOrNull(habitCategoriesTable) ??
          HabitCategoriesTableData.fromJson(defaultCategories[0].toJson());

      final habitSeries = recurringSeries
          .firstWhereOrNull((series) => series.habitId == habit.id);

      if (habitSeries != null) {
        final exception = exceptionsBySeriesId[habitSeries.id];
        if (exception != null) {
          return (
            _applyExceptionOverride(habit, exception),
            category,
          );
        }
      }

      return (habit, category);
    }).toList();

    return result;
  }

  // Get HabitSeries that repeat by day
  Future<List<HabitSeriesTableData>> _getRecurringHabitSeriesByDate(
      DateTime dateLocal, String userId) async {
    // 1. Get all series that can repeat on that day
    final baseSeries = await (select(habitSeriesTable)
          ..where((series) =>
              // Filter by userId
              series.userId.equals(userId) &
              // StartDate must be <= dateLocal
              (series.startDate.isSmallerThanValue(dateLocal) |
                  isSameDateQuery(series.startDate, dateLocal)) &
              // UntilDate must be null or >= dateLocal
              (series.untilDate.isNull() |
                  (series.untilDate.isBiggerThanValue(dateLocal) |
                      isSameDateQuery(series.untilDate, dateLocal)))))
        .get();

    // 2. Filter series based on the repeat frequency rule
    final filteredSeries = baseSeries.where((series) {
      switch (series.repeatFrequency) {
        case 'daily':
          return true;

        case 'weekly':
          return series.startDate.weekday == dateLocal.weekday;

        case 'monthly':
          return series.startDate.day == dateLocal.day;

        default:
          return false;
      }
    }).toList();

    return filteredSeries;
  }

  // Get HabitExceptions for that day
  Future<Map<String, HabitExceptionsTableData>> _getHabitExceptionsByDate(
      DateTime dateLocal) async {
    final query = select(habitExceptionsTable)
      ..where((ex) => ex.date.equals(dateLocal));

    final exceptions = await query.get();

    return {
      for (final ex in exceptions) ex.habitSeriesId: ex,
    };
  }

  // Get habits that satisfy recurring or one-time (excluding skipped)
  Future<List<TypedResult>> _getHabitRowsForDate(
      DateTime dateLocal,
      List<HabitSeriesTableData> recurringSeries,
      Set<String> skippedSeriesIds,
      String userId) async {
    final recurringHabitIds = recurringSeries.map((s) => s.habitId).toList();

    final from = DateTime(dateLocal.year, dateLocal.month, dateLocal.day);
    final to = from
        .add(const Duration(days: 1))
        .subtract(const Duration(milliseconds: 1));
    final combinedCondition = Expression.or([
      Expression.and([
        habitsTable.habitSeriesId.isNull(),
        habitsTable.startDate.isBetween(Variable(from), Variable(to)),
      ]),

      // Habit recurring, present in series and not skipped
      Expression.and([
        habitsTable.id.isIn(recurringHabitIds),
        habitsTable.id.isNotIn(skippedSeriesIds.toList()),
      ]),
    ]);

    final query = select(habitsTable).join([
      leftOuterJoin(
        habitCategoriesTable,
        habitCategoriesTable.id.equalsExp(habitsTable.categoryId),
      ),
    ])
      ..where(combinedCondition & habitsTable.userId.equals(userId));

    return query.get();
  }

  // Override habit from exception (if there is an override)
  HabitsTableData _applyExceptionOverride(
      HabitsTableData habit, HabitExceptionsTableData exception) {
    return habit.copyWith(
      reminderEnabled: exception.reminderEnabled,
      targetValue: exception.targetValue != null
          ? Value(exception.targetValue!)
          : Value(habit.targetValue),
      currentValue: exception.currentValue != null
          ? Value(exception.currentValue!)
          : Value(habit.currentValue),
      isCompleted: exception.isCompleted != null
          ? Value(exception.isCompleted!)
          : Value(habit.isCompleted),
    );
  }

  // Get all habits that have a recurring series
  Future<List<HabitsTableData>> getAllRecurringHabits() {
    return (select(habitsTable)
          ..where((habit) => habit.habitSeriesId.isNotNull()))
        .get();
  }

  Future<List<HabitsTableData>> getHabitsDateRange(
      DateTimeRange range, String userId) async {
    return await (select(habitsTable)
          ..where((habit) =>
              habit.userId.equals(userId) &
              (habit.startDate.isSmallerOrEqualValue(range.end) |
                  isSameDateQuery(habit.startDate, range.end)) &
              (habit.startDate.isBiggerOrEqualValue(range.start) |
                  isSameDateQuery(habit.startDate, range.start))))
        .get();
  }
}
