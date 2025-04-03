import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/helpers.dart';
import '../app_database.dart';
import '../tables/habit_series_table.dart';

part 'habit_series_dao.g.dart';

@DriftAccessor(tables: [HabitSeriesTable])
class HabitSeriesDao extends DatabaseAccessor<AppDatabase>
    with _$HabitSeriesDaoMixin {
  HabitSeriesDao(super.db);

  /// Insert a new habit series
  Future<int> insertHabitSeries(HabitSeriesTableCompanion habitSeries) =>
      into(habitSeriesTable).insert(habitSeries);

  /// Get all habit series
  Future<List<HabitSeriesTableData>> getAllHabitSeries() =>
      select(habitSeriesTable).get();

  /// Get a single habit series by ID
  Future<HabitSeriesTableData?> getHabitSeries(String id) {
    return (select(habitSeriesTable)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// Delete habit series by id
  Future<int> deleteHabitSeries(String id) =>
      (delete(habitSeriesTable)..where((tbl) => tbl.id.equals(id))).go();

  /// Optional: Update habit series (if needed)
  Future<bool> updateHabitSeries(HabitSeriesTableData habitSeries) =>
      update(habitSeriesTable).replace(habitSeries);

  Future<List<HabitSeriesTableData>> getHabitSeriesDateRange(
      DateTimeRange range) async {
    return await (select(habitSeriesTable)
          ..where((series) =>
              (series.startDate.isSmallerOrEqualValue(range.end) |
                  isSameDateQuery(series.startDate, range.end)) &
              (series.untilDate.isNull() |
                  series.untilDate.isBiggerOrEqualValue(range.start) |
                  isSameDateQuery(series.untilDate, range.start))))
        .get();
  }
}
