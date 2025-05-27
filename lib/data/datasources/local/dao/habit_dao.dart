import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/helpers.dart';
import '../app_database.dart';
import '../tables/habit_categories_table.dart';
import '../tables/habit_exceptions_table.dart';
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

  /// Get all habits
  Future<List<HabitsTableData>> getAllHabits() => select(habitsTable).get();

  /// Get a habit by id
  Future<HabitsTableData?> getHabit(String id) async {
    return (select(habitsTable)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// Insert a new habit
  Future<int> insertHabit(HabitsTableCompanion habit) =>
      into(habitsTable).insert(habit);

  /// Delete habit by id
  Future<int> deleteHabit(String id) =>
      (delete(habitsTable)..where((tbl) => tbl.id.equals(id))).go();

  /// Optional: Update habit (if needed)
  Future<bool> updateHabit(HabitsTableCompanion habit) =>
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
        final date = habit.startDate.toLocal();
        // This is an instance generated from a recurring habit
        final adjustedHabit = habit.copyWith(
            id: 'habit-${Uuid().v4()}',
            startDate: dateLocal
                .copyWith(
                    hour: date.hour, minute: date.minute, second: date.second)
                .toUtc(),
            habitSeriesId: Value(habitSeries.id));

        final exception = exceptionsBySeriesId[habitSeries.id];
        if (exception != null) {
          return (applyExceptionOverride(adjustedHabit, exception), category);
        }
        return (adjustedHabit, category);
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
    final startOfDay = DateTime(dateLocal.year, dateLocal.month, dateLocal.day);
    final endOfDay = startOfDay.add(Duration(days: 1));

    final query = select(habitExceptionsTable)
      ..where((ex) => ex.date.isBetweenValues(startOfDay, endOfDay));

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
      // 1. Non-recurring habits on the selected day
      Expression.and([
        habitsTable.habitSeriesId.isNull(),
        habitsTable.startDate.isBetween(Variable(from), Variable(to)),
      ]),

      // 2. Recurring habits not skipped
      Expression.and([
        habitsTable.habitSeriesId.isNotNull(),
        habitsTable.habitSeriesId.isNotIn(skippedSeriesIds.toList()),
        habitsTable.id.isIn(recurringHabitIds),
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

  Future<(HabitsTableData, HabitCategoriesTableData)?>
      getHabitWithCategoryBySeriesAndDate(
          String seriesId, DateTime dateLocal) async {
    // 1. Get HabitSeries and Habit
    final habitSeries = await (select(habitSeriesTable)
          ..where((tbl) => tbl.id.equals(seriesId)))
        .getSingleOrNull();
    if (habitSeries == null) return null;
    final habit = await getHabit(habitSeries.habitId);
    if (habit == null) return null;

    // 2. Check if there is an Exception
    final exception = await (select(habitExceptionsTable)
          ..where((e) =>
              e.habitSeriesId.equals(seriesId) &
              isSameDateQuery(e.date, dateLocal)))
        .getSingleOrNull();

    // 3. If there is an exception and it is not skipped → convert to Habit
    if (exception != null && !exception.isSkipped) {
      final adjustedHabit = applyExceptionOverride(
        _habitFromSeries(habit, habitSeries, dateLocal),
        exception,
      );
      final category = await _getHabitCategory(habit.categoryId);
      return (adjustedHabit, category);
    }

    // 4. If there is no exception → create Habit from series
    final newHabit = _habitFromSeries(habit, habitSeries, dateLocal);
    final category = await _getHabitCategory(habit.categoryId);
    return (newHabit, category);
  }

  HabitsTableData _habitFromSeries(
      HabitsTableData habit, HabitSeriesTableData series, DateTime dateLocal) {
    final date = habit.startDate.toLocal();
    return habit.copyWith(
        id: generateNewId('habit'),
        startDate: dateLocal
            .copyWith(hour: date.hour, minute: date.minute, second: date.second)
            .toUtc(),
        habitSeriesId: Value(series.id));
  }

  Future<HabitCategoriesTableData> _getHabitCategory(String? categoryId) async {
    if (categoryId == null) {
      return HabitCategoriesTableData.fromJson(defaultCategories[0].toJson());
    }

    final category = await (select(habitCategoriesTable)
          ..where((c) => c.id.equals(categoryId)))
        .getSingleOrNull();

    return category ??
        HabitCategoriesTableData.fromJson(defaultCategories[0].toJson());
  }

  // Base method that both specialized methods will use
  Future<List<(HabitsTableData, HabitCategoriesTableData)>>
      getHabitsWithCategoriesForMonthBase(DateTime month, String? userId,
          {String? categoryId} // Optional category filter
          ) async {
    if (userId == null) return [];

    final from = DateTime(month.year, month.month, 1);
    final to = DateTime(month.year, month.month + 1, 0);

    // 1. Build base conditions for non-recurring habits
    var nonRecurringCondition = habitsTable.habitSeriesId.isNull() &
        habitsTable.userId.equals(userId) &
        habitsTable.startDate.isBetween(Variable(from), Variable(to));

    // Add category filter if provided
    if (categoryId != null) {
      nonRecurringCondition =
          nonRecurringCondition & habitsTable.categoryId.equals(categoryId);
    }

    // Execute query with conditions
    final nonRecurringQuery = select(habitsTable).join([
      leftOuterJoin(
        habitCategoriesTable,
        habitCategoriesTable.id.equalsExp(habitsTable.categoryId),
      ),
    ])
      ..where(nonRecurringCondition);

    final nonRecurringHabits = await nonRecurringQuery.get();

    // 2. Get recurring series with optional category filter
    final seriesQuery = select(habitSeriesTable).join([
      innerJoin(habitsTable, habitsTable.id.equalsExp(habitSeriesTable.habitId))
    ]);

    // Build series condition
    var seriesCondition = habitSeriesTable.userId.equals(userId) &
        habitSeriesTable.startDate.isSmallerThanValue(to) &
        (habitSeriesTable.untilDate.isNull() |
            habitSeriesTable.untilDate.isBiggerThanValue(from));

    // Add category filter if provided
    if (categoryId != null) {
      seriesCondition =
          seriesCondition & habitsTable.categoryId.equals(categoryId);
    }

    // Apply conditions and get series
    seriesQuery.where(seriesCondition);
    final recurringSeries =
        await seriesQuery.map((row) => row.readTable(habitSeriesTable)).get();

    // 3. Get all exceptions in this month (same for both methods)
    final allExceptions = await (select(habitExceptionsTable)
          ..where((ex) => ex.date.isBetween(Variable(from), Variable(to))))
        .get();

    final exceptionsBySeries = <String, List<HabitExceptionsTableData>>{};
    for (final ex in allExceptions) {
      exceptionsBySeries.putIfAbsent(ex.habitSeriesId, () => []).add(ex);
    }

    // 4. Generate virtual instances from recurring series (same for both methods)
    final List<(HabitsTableData, HabitCategoriesTableData)> recurringHabits =
        [];

    for (final series in recurringSeries) {
      final habit = await getHabit(series.habitId);
      if (habit == null) continue;

      final category = await _getHabitCategory(habit.categoryId);

      final repeatDates = getRepeatDatesForMonth(
          series.repeatFrequency, from, to, series.startDate);

      final exceptions = exceptionsBySeries[series.id] ?? [];

      for (final date in repeatDates) {
        final exception =
            exceptions.firstWhereOrNull((e) => isSameDate(e.date, date));

        // Skip if this date is marked as skipped
        if (exception?.isSkipped == true) continue;

        final virtualHabit = habit.copyWith(
          id: 'habit-${Uuid().v4()}',
          startDate: date.toUtc(),
          habitSeriesId: Value(series.id),
        );

        final finalHabit = exception != null
            ? applyExceptionOverride(virtualHabit, exception)
            : virtualHabit;

        recurringHabits.add((finalHabit, category));
      }
    }

    // 5. Combine with non-recurring
    final directHabits = nonRecurringHabits.map((row) {
      final habit = row.readTable(habitsTable);
      final category = row.readTableOrNull(habitCategoriesTable) ??
          HabitCategoriesTableData.fromJson(defaultCategories[0].toJson());
      return (habit, category);
    }).toList();

    return [...directHabits, ...recurringHabits];
  }

  Future<List<(HabitsTableData, HabitCategoriesTableData)>>
      getHabitsWithCategoriesForMonth(DateTime month, String? userId) {
    return getHabitsWithCategoriesForMonthBase(month, userId);
  }

  Future<List<(HabitsTableData, HabitCategoriesTableData)>>
      getHabitsWithCategoriesForMonthAndCategory(
          DateTime month, String categoryId, String? userId) {
    return getHabitsWithCategoriesForMonthBase(month, userId,
        categoryId: categoryId);
  }

  List<DateTime> getRepeatDatesForMonth(
    String? frequency,
    DateTime from,
    DateTime to,
    DateTime seriesStartDate,
  ) {
    final List<DateTime> dates = [];
    DateTime current = seriesStartDate.isAfter(from) ? seriesStartDate : from;

    while (!current.isAfter(to)) {
      switch (frequency) {
        case 'daily':
          dates.add(current);
          current = current.add(const Duration(days: 1));
          break;
        case 'weekly':
          if (current.weekday == seriesStartDate.weekday) {
            dates.add(current);
          }
          current = current.add(const Duration(days: 1));
          break;
        case 'monthly':
          if (current.day == seriesStartDate.day) {
            dates.add(current);
          }
          current = current.add(const Duration(days: 1));
          break;
        // Add more cases if needed
        default:
          current = current.add(const Duration(days: 1));
      }
    }

    return dates;
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
