import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit_analysis_input.dart';
import '../../../data/domain/models/habit_exception.dart';
import '../services/drift_habits_service.dart';
import '../services/habits_service.dart';

final habitsRepositoryProvider = Provider((ref) {
  final habitsService = ref.read(driftHabitsServiceProvider);
  return HabitsRepository(habitsService);
});

class HabitsRepository {
  HabitsRepository(this._service);
  final HabitsService _service;

  Future<HabitAnalysisInput?> getHabitAnalysisInput(
      DateTimeRange range, String userId) async {
    // Fetch data from HabitsService
    final habits = await _service.getHabitsDateRange(range, userId);
    final habitSeries = await _service.getHabitSeriesDateRange(range, userId);
    final seriesIds = habitSeries.map((s) => s.id).toList();
    final habitExceptions =
        await _service.getHabitExceptionsDateRange(range, seriesIds);

    // Convert data into HabitData
    final habitDataList = await Future.wait(habits.map((habit) async {
      final series = habitSeries.firstWhereOrNull((s) => s.habitId == habit.id);
      final exceptions = habitExceptions
          .where((ex) => ex.habitSeriesId == habit.habitSeriesId)
          .map((ex) => HabitException.fromJson(ex.toJson()))
          .toBuiltList();

      final category = await _service.getCategoryById(habit.categoryId);

      return HabitData.fromJson({
        ...habit.toJson(),
        'category': category?.toJson() ?? defaultCategories[0].toJson(),
        'repeatFrequency': series?.repeatFrequency,
        'untilDate': series?.untilDate,
        'exceptions': exceptions.map((e) => e.toJson()).toList(),
      });
    }).toList());

    return HabitAnalysisInput((b) => b
      ..userId = userId
      ..startDate = range.start
      ..endDate = range.end
      ..habits.replace(habitDataList));
  }
}
