import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeflow/data/database/app_database.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_exception.dart';
import '../../../data/domain/models/habit_series.dart';
import '../services/habit_detail_service.dart';

final habitDetailRepositoryProvider = Provider<HabitDetailRepository>((ref) {
  final service = ref.read(habitDetailServiceProvider);
  return HabitDetailRepository(service);
});

class HabitDetailRepository {
  final HabitDetailService _service;

  HabitDetailRepository(this._service);

  Future<T> transaction<T>(Future<T> Function() action) {
    return _service.transaction(action);
  }

  Future<Habit?> getHabit(String id) async {
    // Fetch Habit by ID from the service
    final habitData = await _service.getHabit(id);

    // Convert Companion to Model
    if (habitData != null) {
      final categoryData = await _service.getCategory(id);

      return Habit.fromJson({
        ...habitData.toJson(),
        'category': categoryData?.toJson() ?? defaultCategories.first.toJson(),
      });
    }
    return null;
  }

  Future<void> createHabit(Habit habitModel) async {
    // Convert Habit Model => HabitsCompanion
    final companion = HabitsTableData.fromJson({
      ...habitModel.toJson(),
      'categoryId': habitModel.category.id,
    }).toCompanion(false);

    // Call service or repository to save
    await _service.insertHabit(companion);
  }

  Future<void> updateHabit(Habit habitModel) async {
    // Convert Habit Model => HabitsCompanion
    final companion = HabitsTableData.fromJson({
      ...habitModel.toJson(),
      'categoryId': habitModel.category.id,
    }).toCompanion(false);

    // Call service or repository to update
    await _service.updateHabit(companion);
  }

  Future<bool> deleteHabit(String id) async {
    // Call service or repository to delete the Habit by ID
    final deletedCount = await _service.deleteHabit(id);
    if (deletedCount == 0) return false;
    return true;
  }

  Future<void> createHabitSeries(HabitSeries habitSeries) async {
    // Convert Model to Companion
    final companion =
        HabitSeriesTableData.fromJson(habitSeries.toJson()).toCompanion(false);

    // Call service or repository to save
    await _service.insertHabitSeries(companion);
  }

  Future<bool> updateHabitSeries(HabitSeries habitSeries) async {
    // Convert Model to Companion
    final companion =
        HabitSeriesTableData.fromJson(habitSeries.toJson()).toCompanion(false);

    // Call service or repository to update
    return await _service.updateHabitSeries(companion);
  }

  Future<HabitSeries?> getHabitSeries(String? id) async {
    if (id == null) return null;
    // Fetch HabitSeries by ID from the service
    final habitSeriesData = await _service.getHabitSeries(id);

    // Convert Companion to Model
    if (habitSeriesData != null) {
      return HabitSeries.fromJson(habitSeriesData.toJson());
    }
    return null;
  }

  Future<bool> insertHabitException(HabitException exception) async {
    // Convert Model to Companion
    final companion = HabitExceptionsTableData.fromJson(exception.toJson())
        .toCompanion(false);
    // Call service or repository to insert the exception
    final count = await _service.insertHabitException(companion);
    if (count == 0) return false;
    return true;
  }

  Future<bool> updateHabitException(HabitException exception) async {
    // Convert Model to Companion
    final companion = HabitExceptionsTableData.fromJson(exception.toJson())
        .toCompanion(false);

    // Call service or repository to update the exception
    return await _service.updateHabitException(companion);
  }

  Future<bool> deleteHabitSeries(String id) async {
    // Call service or repository to delete the HabitSeries by ID
    final count = await _service.deleteHabitSeries(id);
    if (count == 0) return false;
    return true;
  }

  Future<HabitException?> getHabitException(String id) async {
    // Fetch HabitException by ID from the service
    final exceptionData = await _service.getHabitException(id);

    // Convert Companion to Model
    if (exceptionData != null) {
      return HabitException.fromJson(exceptionData.toJson());
    }
    return null;
  }

  Future<List<HabitException>> getExceptionsAfterDate(
      String seriesId, DateTime habitDate) async {
    // Fetch exceptions after the given date for the specified series
    final exceptionsData =
        await _service.getExceptionsAfterDate(seriesId, habitDate);

    // Convert Companion list to Model list
    return exceptionsData
        .map((exception) => HabitException.fromJson(exception.toJson()))
        .toList();
  }

  Future<void> deleteHabitException(String id) async {
    // Call service or repository to delete the HabitException by ID
    await _service.deleteHabitException(id);
  }

  Future<int> deleteAllExceptionsInSeries(String seriesId) async {
    // Call service or repository to delete all exceptions in the specified series
    return await _service.deleteAllExceptionsInSeries(seriesId);
  }

  Future<int> deleteFutureExceptionsInSeries(
      String seriesId, DateTime startDate) async {
    // Call service or repository to delete exceptions in the series after the given date
    return await _service.deleteFutureExceptionsInSeries(seriesId, startDate);
  }
}
