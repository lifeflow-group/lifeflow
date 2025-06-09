import 'package:flutter/material.dart' show DateTimeRange;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/local/app_database.dart';
import '../datasources/local/dao/habit_series_dao.dart';
import '../datasources/local/database_provider.dart';
import '../domain/models/habit_series.dart';

final habitSeriesRepositoryProvider = Provider<HabitSeriesRepository>((ref) {
  final dao = ref.read(appDatabaseProvider).habitSeriesDao;
  return HabitSeriesRepository(dao);
});

class HabitSeriesRepository {
  final HabitSeriesDao _dao;

  HabitSeriesRepository(this._dao);

  Future<T> transaction<T>(Future<T> Function() action) {
    return _dao.transaction(action);
  }

  Future<void> createHabitSeries(HabitSeries habitSeries) async {
    // Convert Model to Companion
    final companion =
        HabitSeriesTableData.fromJson(habitSeries.toJson()).toCompanion(false);

    // Call service or repository to save
    await _dao.insertHabitSeries(companion);
  }

  Future<bool> updateHabitSeries(HabitSeries habitSeries) async {
    // Convert Model to Companion
    final companion =
        HabitSeriesTableData.fromJson(habitSeries.toJson()).toCompanion(false);

    // Call service or repository to update
    return await _dao.updateHabitSeries(companion);
  }

  Future<HabitSeries?> getHabitSeries(String? id) async {
    if (id == null) return null;
    // Fetch HabitSeries by ID from the service
    final habitSeriesData = await _dao.getHabitSeries(id);

    // Convert Companion to Model
    if (habitSeriesData != null) {
      return HabitSeries.fromJson(habitSeriesData.toJson());
    }
    return null;
  }

  Future<bool> deleteHabitSeries(String id) async {
    // Call service or repository to delete the HabitSeries by ID
    final count = await _dao.deleteHabitSeries(id);
    if (count == 0) return false;
    return true;
  }

  /// Get habit series within a date range
  Future<List<HabitSeries>> getHabitSeriesDateRange(
      DateTimeRange range, String userId) async {
    // Get data from DAO
    final seriesData = await _dao.getHabitSeriesDateRange(range, userId);

    // Convert DAO data to domain models
    return seriesData
        .map((data) => HabitSeries.fromJson(data.toJson()))
        .toList();
  }
}
