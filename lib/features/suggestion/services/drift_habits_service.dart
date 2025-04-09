import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/database/database_provider.dart';
import 'habits_service.dart';

final driftHabitsServiceProvider = Provider((ref) {
  final database = ref.read(appDatabaseProvider);
  return DriftHabitsService(database);
});

class DriftHabitsService implements HabitsService {
  final AppDatabase _database;

  DriftHabitsService(this._database);

  @override
  Future<List<HabitSeriesTableData>> getHabitSeriesDateRange(
      DateTimeRange range, String userId) async {
    return await _database.habitSeriesDao
        .getHabitSeriesDateRange(range, userId);
  }

  @override
  Future<List<HabitsTableData>> getHabitsDateRange(
      DateTimeRange range, String userId) async {
    return await _database.habitDao.getHabitsDateRange(range, userId);
  }

  @override
  Future<List<HabitExceptionsTableData>> getHabitExceptionsDateRange(
      DateTimeRange range, List<String> seriesIds) async {
    return await _database.habitExceptionDao
        .getHabitExceptionsDateRange(range, seriesIds);
  }

  @override
  Future<HabitCategoriesTableData?> getCategoryById(String id) async {
    return await _database.categoryDao.getCategoryById(id);
  }
}
