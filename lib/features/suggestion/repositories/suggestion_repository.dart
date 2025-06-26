import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasources/remote/repositories/remote_suggestion_repository.dart';
import '../../../data/datasources/local/repositories/habit_exception_repository.dart';
import '../../../data/datasources/local/repositories/habit_repository.dart';
import '../../../data/datasources/local/repositories/habit_series_repository.dart';
import '../../../data/datasources/local/repositories/repositories.dart';

final suggestionRepositoryProvider = Provider((ref) {
  final remoteSuggestion = ref.read(remoteSuggestionRepositoryProvider);
  final repositories = ref.read(repositoriesProvider);
  return SuggestionRepository(
      remoteSuggestion: remoteSuggestion, repositories: repositories);
});

class SuggestionRepository {
  SuggestionRepository(
      {required this.remoteSuggestion, required this.repositories});

  final RemoteSuggestionRepository remoteSuggestion;
  final Repositories repositories;

  Future<T> transaction<T>(Future<T> Function() action) {
    return repositories.transaction(action);
  }

  HabitRepository get habit => repositories.habit;
  HabitExceptionRepository get habitException => repositories.habitException;
  HabitSeriesRepository get habitSeries => repositories.habitSeries;
}
