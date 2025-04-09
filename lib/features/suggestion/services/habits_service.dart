import 'package:flutter/material.dart';

import '../../../data/database/app_database.dart';

abstract class HabitsService {
  Future<List<HabitsTableData>> getHabitsDateRange(
      DateTimeRange range, String userId);

  Future<List<HabitSeriesTableData>> getHabitSeriesDateRange(
      DateTimeRange range, String userId);

  Future<List<HabitExceptionsTableData>> getHabitExceptionsDateRange(
      DateTimeRange range, List<String> seriesIds);

  Future<HabitCategoriesTableData?> getCategoryById(String id);
}
