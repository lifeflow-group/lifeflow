import 'package:flutter/material.dart';

import '../../../data/database/app_database.dart';

abstract class HabitsService {
  Future<List<HabitsTableData>> getHabitsDateRange(DateTimeRange range);

  Future<List<HabitSeriesTableData>> getHabitSeriesDateRange(
      DateTimeRange range);

  Future<List<HabitExceptionsTableData>> getHabitExceptionsDateRange(
      DateTimeRange range);

  Future<HabitCategoriesTableData?> getCategoryById(String id);
}
