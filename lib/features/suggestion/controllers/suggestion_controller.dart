import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/services/analytics/analytics_service.dart';
import '../../../data/services/user_service.dart';
import '../../../data/domain/models/suggestion.dart';
import '../repositories/habits_repository.dart';
import '../repositories/suggestion_repository.dart';

final suggestionControllerProvider =
    AsyncNotifierProvider<SuggestionController, List<Suggestion>>(() {
  return SuggestionController();
});

class SuggestionController extends AsyncNotifier<List<Suggestion>> {
  HabitsRepository get habitsRepository => ref.watch(habitsRepositoryProvider);
  SuggestionRepository get suggestionRepository =>
      ref.read(suggestionRepositoryProvider);
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

      final input = await habitsRepository.getHabitAnalysisInput(
          DateTimeRange(start: time.subtract(Duration(days: 30)), end: time),
          userId);

      if (input == null) {
        _analytics.trackSuggestionDataLoadEmptyInput();
        return [];
      }

      _analytics.trackSuggestionAnalysisInputLoaded(input.habits.length, 30);

      // Send data for analysis and generate suggestions
      final suggestions = await suggestionRepository.analyzeHabits(input);

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

  Future<void> refresh() async {
    _analytics.trackSuggestionControllerRefreshCalled();
    ref.invalidateSelf();
  }
}
