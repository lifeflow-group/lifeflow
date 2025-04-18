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

  Future<void> createHabitSeries(HabitSeries habitSeries) async {
    // Convert Model to Companion
    final companion =
        HabitSeriesTableData.fromJson(habitSeries.toJson()).toCompanion(false);

    // Call service or repository to save
    await _service.insertHabitSeries(companion);
  }

  Future<void> updateHabitSeries(HabitSeries habitSeries) async {
    // Convert Model to Companion
    final companion =
        HabitSeriesTableData.fromJson(habitSeries.toJson()).toCompanion(false);

    // Call service or repository to update
    await _service.updateHabitSeries(companion);
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

  Future<void> insertHabitException(HabitException exception) async {
    // Convert Model to Companion
    final companion = HabitExceptionsTableData.fromJson(exception.toJson())
        .toCompanion(false);
    // Call service or repository to insert the exception
    await _service.insertHabitException(companion);
  }

  Future<void> updateHabitException(HabitException exception) async {
    // Convert Model to Companion
    final companion = HabitExceptionsTableData.fromJson(exception.toJson())
        .toCompanion(false);

    // Call service or repository to update the exception
    await _service.updateHabitException(companion);
  }

  Future<void> deleteHabitSeries(String id) async {
    // Call service or repository to delete the HabitSeries by ID
    await _service.deleteHabitSeries(id);
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

  Future<void> deleteHabitException(String id) async {
    // Call service or repository to delete the HabitException by ID
    await _service.deleteHabitException(id);
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
}
