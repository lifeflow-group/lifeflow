import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/habit_analysis_input.dart';
import '../../../data/domain/models/habit_exception.dart';
import '../../../data/services/analytics/analytics_service.dart';
import '../../../data/services/user_service.dart';
import '../../../data/domain/models/suggestion.dart';
import '../repositories/suggestion_repository.dart';

final suggestionControllerProvider =
    AsyncNotifierProvider<SuggestionController, List<Suggestion>>(() {
  return SuggestionController();
});

class SuggestionController extends AsyncNotifier<List<Suggestion>> {
  SuggestionRepository get _repo => ref.read(suggestionRepositoryProvider);
  AnalyticsService get _analytics => ref.read(analyticsServiceProvider);

  @override
  FutureOr<List<Suggestion>> build() {
    return loadSuggestions();
  }

  Future<List<Suggestion>> loadSuggestions() async {
    state = const AsyncLoading();
    _analytics.trackSuggestionDataLoadingStarted();

    try {
      // Get habit analysis input
      final time = DateTime.now();
      final userId = await ref.read(userServiceProvider).getCurrentUserId();
      if (userId == null) {
        _analytics.trackSuggestionDataLoadNoUser();
        return [];
      }

      final input = await _getHabitAnalysisInput(
          DateTimeRange(start: time.subtract(Duration(days: 30)), end: time),
          userId);

      if (input == null) {
        _analytics.trackSuggestionDataLoadEmptyInput();
        return [];
      }

      _analytics.trackSuggestionAnalysisInputLoaded(input.habits.length, 30);

      // Send data for analysis and generate suggestions
      final suggestions = await _repo.analyzeHabits(input);

      // Log result in controller (business-focused data)
      _analytics.trackSuggestionDataLoaded(
          suggestions.length, suggestions.isNotEmpty, true);

      return suggestions;
    } catch (e) {
      // Log errors in controller
      _analytics.trackSuggestionDataLoadError(
          e.toString(), e.runtimeType.toString());

      rethrow;
    }
  }

  Future<HabitAnalysisInput?> _getHabitAnalysisInput(
      DateTimeRange range, String userId) async {
    // Fetch data from HabitsService
    final habits = await _repo.habit.getHabitsDateRange(range, userId);
    final habitSeries =
        await _repo.habitSeries.getHabitSeriesDateRange(range, userId);
    final seriesIds = habitSeries.map((s) => s.id).toList();
    final habitExceptions = await _repo.habitException
        .getHabitExceptionsDateRange(range, seriesIds);

    // Convert data into HabitData
    final habitDataList = await Future.wait(habits.map((habit) async {
      final series = habitSeries.firstWhereOrNull((s) => s.habitId == habit.id);
      final exceptions = habitExceptions
          .where((ex) => ex.habitSeriesId == habit.habitSeriesId)
          .toList();

      return HabitData((p0) => p0
        ..id = habit.id
        ..name = habit.name
        ..category = habit.category.toBuilder()
        ..trackingType = habit.trackingType
        ..reminderEnabled = habit.reminderEnabled
        ..targetValue = habit.targetValue
        ..unit = habit.unit
        ..repeatFrequency = series?.repeatFrequency
        ..startDate = habit.startDate.toUtc()
        ..untilDate = series?.untilDate?.toUtc()
        ..exceptions = ListBuilder<HabitException>(exceptions));
    }).toList());

    return HabitAnalysisInput((b) => b
      ..userId = userId
      ..startDate = range.start
      ..endDate = range.end
      ..habits.replace(habitDataList));
  }

  Future<void> refresh() async {
    _analytics.trackSuggestionControllerRefreshCalled();
    ref.invalidateSelf();
  }
}
