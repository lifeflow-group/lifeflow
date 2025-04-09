import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/habit_analysis_input.dart';
import '../../../data/domain/models/suggestion.dart';
import '../services/server_suggestion_service.dart';
import '../services/suggestion_service.dart';

final suggestionRepositoryProvider = Provider((ref) {
  final suggestionService = ref.read(serverSuggestionServiceProvider);
  return SuggestionRepository(suggestionService);
});

class SuggestionRepository {
  SuggestionRepository(this.suggestionService);

  final SuggestionService suggestionService;

  Future<List<Suggestion>> analyzeHabits(HabitAnalysisInput input) async {
    final jsonData = await suggestionService.generateAISuggestions(input);
    final suggestions =
        jsonData.map((data) => Suggestion.fromJson(data)).toList();

    return suggestions;
  }
}
