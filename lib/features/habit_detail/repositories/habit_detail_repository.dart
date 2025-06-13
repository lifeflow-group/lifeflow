import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/habit_exception_repository.dart';
import '../../../data/repositories/habit_repository.dart';
import '../../../data/repositories/habit_series_repository.dart';
import '../../../data/repositories/repositories.dart';

final habitDetailRepositoryProvider = Provider<HabitDetailRepository>((ref) {
  final repos = ref.read(repositoriesProvider);
  return HabitDetailRepository(repos);
});

class HabitDetailRepository {
  final Repositories _repos;

  HabitDetailRepository(this._repos);

  Future<T> transaction<T>(Future<T> Function() action) {
    return _repos.transaction(action);
  }

  Repositories get repos => _repos;
  HabitRepository get habit => _repos.habit;
  HabitExceptionRepository get habitException => _repos.habitException;
  HabitSeriesRepository get habitSeries => _repos.habitSeries;
}
