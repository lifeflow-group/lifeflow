import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasources/remote/api_service.dart';
import '../../../data/domain/models/habit_analysis_input.dart';
import '../../../data/domain/models/suggestion.dart';
import '../../../data/repositories/habit_exception_repository.dart';
import '../../../data/repositories/habit_repository.dart';
import '../../../data/repositories/habit_series_repository.dart';
import '../../../data/repositories/repositories.dart';

final suggestionRepositoryProvider = Provider((ref) {
  final apiService = ref.read(apiServiceProvider);
  final repositories = ref.read(repositoriesProvider);
  return SuggestionRepository(
      apiService: apiService, repositories: repositories);
});

class SuggestionRepository {
  SuggestionRepository({required this.apiService, required this.repositories});

  final ApiService apiService;
  final Repositories repositories;

  Future<List<Suggestion>> analyzeHabits(HabitAnalysisInput input) async {
    final jsonData = await apiService.generateAISuggestions(input);
    final suggestions =
        jsonData.map((data) => Suggestion.fromJson(data)).toList();

    return suggestions;
  }

  HabitRepository get habit => repositories.habit;
  HabitExceptionRepository get habitException => repositories.habitException;
  HabitSeriesRepository get habitSeries => repositories.habitSeries;
}
