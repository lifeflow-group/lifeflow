import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasources/local/repositories/habit_exception_repository.dart';
import '../../../data/datasources/local/repositories/habit_repository.dart';

final overviewRepositoryProvider = Provider<OverviewRepository>((ref) {
  final habitRepo = ref.watch(habitRepositoryProvider);
  final exceptionRepo = ref.watch(habitExceptionRepositoryProvider);
  return OverviewRepository(habitRepo, exceptionRepo);
});

class OverviewRepository {
  final HabitRepository _habitRepo;
  final HabitExceptionRepository _exceptionRepo;

  OverviewRepository(this._habitRepo, this._exceptionRepo);

  HabitExceptionRepository get habitException => _exceptionRepo;
  HabitRepository get habit => _habitRepo;
}
