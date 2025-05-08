import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/helpers.dart';
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

  /// Get a habit exception by series ID and date
  Future<HabitExceptionsTableData?> getHabitExceptionByIdAndDate(
      String seriesId, DateTime date) {
    final utcDate = date.toUtc();
    return (select(habitExceptionsTable)
          ..where((tbl) =>
              tbl.habitSeriesId.equals(seriesId) &
              isSameDateQuery(tbl.date, utcDate)))
        .getSingleOrNull();
  }

  /// Delete habit exception by ID
  Future<int> deleteHabitException(String id) =>
      (delete(habitExceptionsTable)..where((tbl) => tbl.id.equals(id))).go();

  /// Delete all habit exceptions in a specific series
  Future<int> deleteAllExceptionsInSeries(String seriesId) =>
      (delete(habitExceptionsTable)
            ..where((tbl) => tbl.habitSeriesId.equals(seriesId)))
          .go();

  /// Delete all future habit exceptions in a specific series
  Future<int> deleteFutureExceptionsInSeries(String seriesId, DateTime date) {
    final utcDate = date.toUtc();
    return (delete(habitExceptionsTable)
          ..where((tbl) =>
              tbl.habitSeriesId.equals(seriesId) &
              (tbl.date.isBiggerThanValue(utcDate) |
                  isSameDateQuery(tbl.date, utcDate))))
        .go();
  }

  /// Optional: Update habit exception (if needed)
  Future<bool> updateHabitException(HabitExceptionsTableCompanion exception) =>
      update(habitExceptionsTable).replace(exception);

  /// Get all habit exceptions for a specific series
  Future<List<HabitExceptionsTableData>> getHabitExceptionsForSeries(
      String seriesId) {
    return (select(habitExceptionsTable)
          ..where((tbl) => tbl.habitSeriesId.equals(seriesId)))
        .get();
  }

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

  Future<List<HabitExceptionsTableData>> getExceptionsAfterDate(
      String seriesId, DateTime date) async {
    return await (select(habitExceptionsTable)
          ..where((ex) =>
              ex.habitSeriesId.equals(seriesId) &
              (ex.date.isBiggerOrEqualValue(date) |
                  isSameDateQuery(ex.date, date))))
        .get();
  }
}
