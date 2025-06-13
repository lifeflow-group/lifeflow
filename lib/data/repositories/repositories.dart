import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/local/app_database.dart';
import '../datasources/local/database_provider.dart';
import 'category_repository.dart';
import 'habit_exception_repository.dart';
import 'habit_repository.dart';
import 'habit_series_repository.dart';

final repositoriesProvider = Provider<Repositories>((ref) {
  final database = ref.read(appDatabaseProvider);
  final habitRepo = ref.read(habitRepositoryProvider);
  final habitExceptionRepo = ref.read(habitExceptionRepositoryProvider);
  final habitSeriesRepo = ref.read(habitSeriesRepositoryProvider);
  final categoryRepo = ref.read(categoryRepositoryProvider);

  return Repositories(
    database,
    habitRepo,
    habitExceptionRepo,
    habitSeriesRepo,
    categoryRepo,
  );
});

class Repositories {
  final AppDatabase _database;
  final HabitRepository _habitRepo;
  final HabitExceptionRepository _habitExceptionRepo;
  final HabitSeriesRepository _habitSeriesRepo;
  final CategoryRepository _categoryRepo;

  Repositories(this._database, this._habitRepo, this._habitExceptionRepo,
      this._habitSeriesRepo, this._categoryRepo);

  Future<T> transaction<T>(Future<T> Function() action) {
    return _database.transaction(action);
  }

  HabitRepository get habit => _habitRepo;
  HabitExceptionRepository get habitException => _habitExceptionRepo;
  HabitSeriesRepository get habitSeries => _habitSeriesRepo;
  CategoryRepository get category => _categoryRepo;
}
