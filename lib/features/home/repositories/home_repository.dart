import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/habit_exception_repository.dart';
import '../../../data/repositories/habit_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final habitRepo = ref.watch(habitRepositoryProvider);
  final exceptionRepo = ref.watch(habitExceptionRepositoryProvider);
  return HomeRepository(habitRepo, exceptionRepo);
});

class HomeRepository {
  final HabitRepository _habitRepo;
  final HabitExceptionRepository _exceptionRepo;

  HomeRepository(this._habitRepo, this._exceptionRepo);

  HabitExceptionRepository get habitException => _exceptionRepo;
  HabitRepository get habit => _habitRepo;
}
