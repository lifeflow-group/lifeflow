import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/suggestion.dart';
import '../repositories/habits_repository.dart';
import '../repositories/suggestion_repository.dart';

final suggestionControllerProvider =
    AsyncNotifierProvider<SuggestionController, List<Suggestion>>(() {
  return SuggestionController();
});

class SuggestionController extends AsyncNotifier<List<Suggestion>> {
  HabitsRepository get habitsRepository => ref.read(habitsRepositoryProvider);
  SuggestionRepository get suggestionRepository =>
      ref.read(suggestionRepositoryProvider);

  @override
  FutureOr<List<Suggestion>> build() {
    return loadSuggestions();
  }

  Future<List<Suggestion>> loadSuggestions() async {
    state = const AsyncLoading();

    // Get habit analysis input
    final time = DateTime.now();
    final input = await habitsRepository.getHabitAnalysisInput('hoan',
        DateTimeRange(start: time.subtract(Duration(days: 30)), end: time));
    debugPrint('Input: ${input.habits.length} habits');

    // Send data for analysis and generate suggestions
    final suggestions = await suggestionRepository.analyzeHabits(input);

    return suggestions;
  }

  void refresh() => ref.invalidateSelf();
}
