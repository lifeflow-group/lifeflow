import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/helpers.dart';
import '../datasources/local/app_database.dart';
import '../datasources/local/dao/category_dao.dart';
import '../datasources/local/dao/habit_dao.dart';
import '../datasources/local/database_provider.dart';
import '../domain/models/habit.dart';

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  final dao = ref.read(appDatabaseProvider).habitDao;
  final categoryDao = ref.read(appDatabaseProvider).categoryDao;
  return HabitRepository(dao, categoryDao);
});

class HabitRepository {
  final HabitDao _dao;
  final CategoryDao _categoryDao;

  HabitRepository(this._dao, this._categoryDao);

  Future<T> transaction<T>(Future<T> Function() action) {
    return _dao.transaction(action);
  }

  Future<void> createHabit(Habit habitModel) async {
    // Convert Habit Model => HabitsCompanion
    final companion = HabitsTableData.fromJson({
      ...habitModel.toJson(),
      'categoryId': habitModel.category.id,
    }).toCompanion(false);

    // Call service or repository to save
    await _dao.insertHabit(companion);
  }

  Future<void> updateHabit(Habit habitModel) async {
    // Convert Habit Model => HabitsCompanion
    final companion = HabitsTableData.fromJson({
      ...habitModel.toJson(),
      'categoryId': habitModel.category.id,
    }).toCompanion(false);

    // Call service or repository to update
    await _dao.updateHabit(companion);
  }

  Future<bool> deleteHabit(String id) async {
    // Call service or repository to delete the Habit by ID
    final deletedCount = await _dao.deleteHabit(id);
    if (deletedCount == 0) return false;
    return true;
  }

  Future<List<Habit>> getHabitsByDate(DateTime date, String userId) async {
    // Fetch the list of habits and categories
    final records = await _dao.getHabitsWithCategoriesByDate(date, userId);

    // Map each (habit, category) => HabitModel
    return records.map((record) => _recordToHabit(record)).toList();
  }

  Future<List<Habit>> getHabitsForMonth(DateTime date, String userId) async {
    final records = await _dao.getHabitsWithCategoriesForMonth(date, userId);
    return records.map((record) => _recordToHabit(record)).toList();
  }

  Future<Habit?> getHabitWithCategoryBySeriesAndDate(
      String seriesId, DateTime dateLocal) async {
    // Fetch the list of habits and categories
    final record = await _dao.getHabitWithCategoryBySeriesAndDate(
        seriesId, dateLocal.toLocal());
    if (record == null) return null;

    return _recordToHabit(record);
  }

  Habit _recordToHabit((HabitsTableData, HabitCategoriesTableData) record) {
    final habitDb = record.$1; // Habit (Drift)
    final categoryDb = record.$2; // HabitCategory (Drift)

    return Habit.fromJson({
      ...habitDb.toJson(),
      'category': categoryDb.toJson(),
    });
  }

  Future<Habit?> getHabit(String id) async {
    // Fetch Habit by ID from the service
    final habitData = await _dao.getHabit(id);

    // Convert Companion to Model
    if (habitData != null) {
      final categoryData = await _categoryDao.getCategory(id);

      return Habit.fromJson({
        ...habitData.toJson(),
        'category': categoryData?.toJson() ?? defaultCategories.first.toJson(),
      });
    }
    return null;
  }
}
