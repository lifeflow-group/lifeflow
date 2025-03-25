import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeflow/data/database/app_database.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_series.dart';
import '../services/create_habit_service.dart';

final createHabitRepositoryProvider = Provider<CreateHabitRepository>((ref) {
  final service = ref.read(createHabitServiceProvider);
  return CreateHabitRepository(service);
});

class CreateHabitRepository {
  final CreateHabitService _createHabitService;

  CreateHabitRepository(this._createHabitService);

  Future<void> saveHabit(Habit habitModel) async {
    // Convert Habit Model => HabitsCompanion
    final companion = HabitsTableData.fromJson({
      ...habitModel.toJson(),
      'categoryId': habitModel.category.id,
    }).toCompanion(false);

    // Call service or repository to save
    await _createHabitService.saveHabit(companion);
  }

  Future<void> saveHabitSeries(HabitSeries habitSeries) async {
    // Convert Model to Companion
    final companion =
        HabitSeriesTableData.fromJson(habitSeries.toJson()).toCompanion(false);

    // Call service or repository to save
    await _createHabitService.saveHabitSeries(companion);
  }
}
