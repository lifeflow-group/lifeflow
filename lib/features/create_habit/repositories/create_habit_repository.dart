import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/habit.dart';
import '../services/create_habit_service.dart';

final createHabitRepositoryProvider = Provider<CreateHabitRepository>((ref) {
  final service = ref.read(createHabitServiceProvider);
  return CreateHabitRepository(service);
});

class CreateHabitRepository {
  final CreateHabitService _createHabitService;

  CreateHabitRepository(this._createHabitService);

  Future<Habit?> saveHabit(Habit habit) {
    return _createHabitService.saveHabit(habit);
  }
}
