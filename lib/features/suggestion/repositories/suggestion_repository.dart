import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/performance_metric.dart';
import '../../../data/domain/models/suggestion.dart';
import '../services/suggestion_service.dart';

final suggestionRepositoryProvider = Provider((ref) {
  final suggestionService = ref.read(suggestionServiceProvider);
  return SuggestionRepository(suggestionService);
});

class SuggestionRepository {
  SuggestionRepository(this.suggestionService);

  final SuggestionService suggestionService;

  Future<List<Suggestion>> analyzeHabits(
      List<Habit> habits, List<PerformanceMetric> performanceMetrics) async {
    final suggestions = await suggestionService.generateAISuggestions(
        habits, performanceMetrics);

    return suggestions;
  }
}
