import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/suggestion.dart';
import '../repositories/habits_repository.dart';
import '../repositories/suggestion_repository.dart';

final suggestionControllerProvider =
    AsyncNotifierProvider<SuggestionController, List<Suggestion>>(() {
  return SuggestionController();
});

class SuggestionController extends AsyncNotifier<List<Suggestion>> {
  late final HabitsRepository habitsRepository;
  late final SuggestionRepository suggestionRepository;

  @override
  FutureOr<List<Suggestion>> build() {
    habitsRepository = ref.read(habitsRepositoryProvider);
    suggestionRepository = ref.read(suggestionRepositoryProvider);
    return loadSuggestions(DateTime.now());
  }

  Future<List<Suggestion>> loadSuggestions(DateTime time) async {
    state = const AsyncLoading();
    try {
      // Get the list of Habits
      final habits = await habitsRepository.getHabitsForCurrentMonth(time);

      // Get the list of PerformanceMetrics
      final performanceMetrics =
          await habitsRepository.getPerformanceMetrics(habits);

      // Send data for analysis and generate suggestions
      final suggestions =
          await suggestionRepository.analyzeHabits(habits, performanceMetrics);

      return suggestions;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return [];
    }
  }
}
