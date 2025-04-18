import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/database/database_provider.dart';

final habitDetailServiceProvider = Provider<HabitDetailService>((ref) {
  final repo = ref.read(appDatabaseProvider);
  return HabitDetailService(repo);
});

class HabitDetailService {
  final AppDatabase _database;
  HabitDetailService(this._database);

  Future<HabitsTableData?> getHabit(String id) async {
    return await _database.habitDao.getHabit(id);
  }

  Future<HabitCategoriesTableData?> getCategory(String id) async {
    return await _database.categoryDao.getCategoryById(id);
  }

  Future<void> insertHabit(HabitsTableCompanion habit) async {
    if (habit.name.value.isEmpty) {
      throw Exception("Habit name is required");
    }
    await _database.habitDao.insertHabit(habit);
  }

  Future<void> updateHabit(HabitsTableCompanion habit) async {
    if (habit.name.value.isEmpty) {
      throw Exception("Habit name is required");
    }
    await _database.habitDao.updateHabit(habit);
  }

  Future<void> insertHabitSeries(HabitSeriesTableCompanion habitSeries) async {
    await _database.habitSeriesDao.insertHabitSeries(habitSeries);
  }

  Future<void> updateHabitSeries(HabitSeriesTableCompanion habitSeries) async {
    await _database.habitSeriesDao.updateHabitSeries(habitSeries);
  }

  Future<HabitSeriesTableData?> getHabitSeries(String id) async {
    return await _database.habitSeriesDao.getHabitSeries(id);
  }

  Future<void> insertHabitException(
      HabitExceptionsTableCompanion habitException) async {
    await _database.habitExceptionDao.insertHabitException(habitException);
  }

  Future<void> updateHabitException(
      HabitExceptionsTableCompanion habitException) async {
    await _database.habitExceptionDao.updateHabitException(habitException);
  }

  Future<void> deleteHabitSeries(String id) async {
    await _database.habitSeriesDao.deleteHabitSeries(id);
  }

  Future<HabitExceptionsTableData?> getHabitException(String id) async {
    return await _database.habitExceptionDao.getHabitException(id);
  }

  Future<void> deleteHabitException(String id) async {
    await _database.habitExceptionDao.deleteHabitException(id);
  }

  Future<List<HabitExceptionsTableData>> getExceptionsAfterDate(
      String seriesId, DateTime habitDate) async {
    return await _database.habitExceptionDao
        .getExceptionsAfterDate(seriesId, habitDate);
  }
}
