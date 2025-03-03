import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/models/habit.dart';
import '../../../data/models/habit_category.dart';
import '../repositories/create_habit_repository.dart';

// Provider for managing the habit name.
final habitNameProvider = StateProvider<String>((ref) => '');

// Provider for managing the habit category.
final habitCategoryProvider = StateProvider<HabitCategory?>((ref) => null);

// Provider for managing the habit start date.
final habitDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

// Provider containing functions to update data
final createHabitControllerProvider = Provider((ref) {
  final repository = ref.read(createHabitRepositoryProvider);
  return CreateHabitController(ref, repository);
});

class CreateHabitController {
  final Ref ref;
  final CreateHabitRepository _repo;

  CreateHabitController(this.ref, this._repo);

  void updateHabitName(String name) {
    ref.read(habitNameProvider.notifier).state = name;
  }

  void updateHabitCategory(HabitCategory? category) {
    ref.read(habitCategoryProvider.notifier).state = category;
  }

  void updateHabitDate(DateTime date) {
    ref.read(habitDateProvider.notifier).state = date;
  }

  Future<Habit?> saveHabit() async {
    final name = ref.read(habitNameProvider);
    final category = ref.read(habitCategoryProvider);
    final date = ref.read(habitDateProvider);

    if (name.isEmpty || category == null) return null;

    final habit = await _repo
        .saveHabit(newHabit(name: name, category: category, startDate: date));

    // Reset form state after saving
    ref.read(habitNameProvider.notifier).state = '';
    ref.read(habitCategoryProvider.notifier).state = null;
    ref.read(habitDateProvider.notifier).state = DateTime.now();

    return habit;
  }
}
