import 'package:flutter/material.dart' show DateTimeRange;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/habit_record.dart';
import '../app_database.dart';
import '../dao/habit_dao.dart';
import '../database_provider.dart';
import '../../../domain/models/habit.dart';

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  final daos = ref.read(appDatabaseProvider);
  return HabitRepository(daos.habitDao);
});

class HabitRepository {
  final HabitDao _dao;

  HabitRepository(this._dao);

  Future<T> transaction<T>(Future<T> Function() action) {
    return _dao.transaction(action);
  }

  /// Helper method to convert Habit model to HabitsCompanion
  HabitsTableCompanion _habitToCompanion(Habit habitModel) {
    return HabitsTableData.fromJson({
      ...habitModel.toJson(),
      'habitSeriesId': habitModel.series?.id,
      'categoryId': habitModel.category.id,
    }).toCompanion(false);
  }

  Future<void> createHabit(Habit habitModel) async {
    // Use the helper method to convert
    final companion = _habitToCompanion(habitModel);

    // Call service or repository to save
    await _dao.insertHabit(companion);
  }

  Future<void> updateHabit(Habit habitModel) async {
    // Use the helper method to convert
    final companion = _habitToCompanion(habitModel);

    // Call service or repository to update
    await _dao.updateHabit(companion);
  }

  Future<bool> deleteHabit(String id) async {
    // Call service or repository to delete the Habit by ID
    final deletedCount = await _dao.deleteHabit(id);
    if (deletedCount == 0) return false;
    return true;
  }

  Habit? _recordToHabit(HabitRecord? record) {
    if (record == null) return null;

    return Habit.fromJson({
      ...record.habit.toJson(),
      'category': record.category.toJson(),
      'series': record.series?.toJson(),
    });
  }

  Future<Habit?> getHabitRecord(String id) async {
    // Fetch Habit by ID from the service
    final record = await _dao.getHabitRecord(id);

    return _recordToHabit(record);
  }

  Future<List<Habit>> getHabitsByDate(DateTime date, String userId) async {
    // Fetch the list of habits and categories
    final records = await _dao.getHabitRecordsByDate(date, userId);

    // Map each (habit, category) => HabitModel
    return records
        .map((record) => _recordToHabit(record))
        .whereType<Habit>()
        .toList();
  }

  Future<List<Habit>> getHabitsForMonth(DateTime date, String userId) async {
    final records = await _dao.getHabitRecordsForMonth(date, userId);
    return records
        .map((record) => _recordToHabit(record))
        .whereType<Habit>()
        .toList();
  }

  Future<List<Habit>> getHabitsForMonthAndCategory(
      DateTime date, String categoryId, String userId) async {
    final records =
        await _dao.getHabitRecordsForMonthAndCategory(date, categoryId, userId);
    return records
        .map((record) => _recordToHabit(record))
        .whereType<Habit>()
        .toList();
  }

  Future<Habit?> getHabitBySeriesAndDate(
      String seriesId, DateTime dateLocal) async {
    // Fetch the list of habits and categories
    final record = await _dao.getHabitRecordsBySeriesAndDate(
        seriesId, dateLocal.toLocal());

    return _recordToHabit(record);
  }

  /// Get habits within a date range
  Future<List<Habit>> getHabitsDateRange(
      DateTimeRange range, String userId) async {
    final records = await _dao.getHabitRecordsDateRange(range, userId);

    return records
        .map((record) => _recordToHabit(record))
        .whereType<Habit>()
        .toList();
  }
}
