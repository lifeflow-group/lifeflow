import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/helpers.dart';
import '../app_database.dart';
import '../tables/habit_exceptions_table.dart';

part 'habit_exception_dao.g.dart';

@DriftAccessor(tables: [HabitExceptionsTable])
class HabitExceptionDao extends DatabaseAccessor<AppDatabase>
    with _$HabitExceptionDaoMixin {
  HabitExceptionDao(super.db);

  /// Insert a new habit exception
  Future<int> insertHabitException(HabitExceptionsTableCompanion exception) =>
      into(habitExceptionsTable).insert(exception);

  /// Get all habit exceptions
  Future<List<HabitExceptionsTableData>> getAllHabitExceptions() =>
      select(habitExceptionsTable).get();

  /// Get a single habit exception by ID
  Future<HabitExceptionsTableData?> getHabitException(String id) {
    return (select(habitExceptionsTable)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// Delete habit exception by ID
  Future<int> deleteHabitException(String id) =>
      (delete(habitExceptionsTable)..where((tbl) => tbl.id.equals(id))).go();

  /// Optional: Update habit exception (if needed)
  Future<bool> updateHabitException(HabitExceptionsTableData exception) =>
      update(habitExceptionsTable).replace(exception);

  Future<List<HabitExceptionsTableData>> getHabitExceptionsDateRange(
      DateTimeRange range, List<String> seriesIds) async {
    if (seriesIds.isEmpty) return [];
    return await (select(habitExceptionsTable)
          ..where((ex) =>
              ex.habitSeriesId.isIn(seriesIds) &
              (ex.date.isSmallerOrEqualValue(range.end) |
                  isSameDateQuery(ex.date, range.end)) &
              (ex.date.isBiggerOrEqualValue(range.start) |
                  isSameDateQuery(ex.date, range.start))))
        .get();
  }
}
