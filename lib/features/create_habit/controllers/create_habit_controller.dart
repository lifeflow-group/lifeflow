import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/models/habit.dart';
import '../../../data/models/habit_category.dart';
import '../repositories/create_habit_repository.dart';

// State to store the name of the habit
final habitNameProvider = StateProvider<String>((ref) => '');

// State to store the category of the habit
final habitCategoryProvider = StateProvider<HabitCategory?>((ref) => null);

// Provider containing functions to update data
final createHabitControllerProvider = Provider((ref) {
  final repository = ref.read(createHabitRepositoryProvider);
  return CreateHabitController(ref, repository);
});

class CreateHabitController {
  final Ref ref;
  final CreateHabitRepository _repo;

  CreateHabitController(this.ref, this._repo);

  // Update habit name
  void updateHabitName(String name) {
    ref.read(habitNameProvider.notifier).state = name;
  }

  // Update habit category
  void updateHabitCategory(HabitCategory? category) {
    ref.read(habitCategoryProvider.notifier).state = category;
  }

  Future<Habit?> saveHabit() async {
    final name = ref.read(habitNameProvider);
    final category = ref.read(habitCategoryProvider);

    if (name.isEmpty || category == null) return null;

    final habit =
        await _repo.saveHabit(newHabit(name: name, category: category));

    ref.read(habitNameProvider.notifier).state = '';
    ref.read(habitCategoryProvider.notifier).state = null;
    return habit;
  }
}
