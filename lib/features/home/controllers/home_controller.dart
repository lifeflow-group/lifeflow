import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/habit_category.dart';
import '../../../data/services/user_service.dart';
import '../../../data/domain/models/habit.dart';
import '../repositories/home_repository.dart';

final selectedDateProvider =
    StateNotifierProvider<SelectedDateNotifier, DateTime>(
        (ref) => SelectedDateNotifier());

class SelectedDateNotifier extends StateNotifier<DateTime> {
  SelectedDateNotifier([DateTime? initialDate])
      : super(initialDate ?? DateTime.now());

  void updateSelectedDate(DateTime newDate) {
    state = newDate;
  }
}

final selectedCategoryProvider =
    StateNotifierProvider<SelectedCategoryNotifier, HabitCategory?>(
        (ref) => SelectedCategoryNotifier());

class SelectedCategoryNotifier extends StateNotifier<HabitCategory?> {
  SelectedCategoryNotifier() : super(null);

  void updateSelectedCategory(HabitCategory? category) {
    state = category;
  }

  void clearCategory() {
    state = null;
  }
}

final homeControllerProvider =
    AsyncNotifierProvider.autoDispose<HomeController, List<Habit>>(
        HomeController.new);

class HomeController extends AutoDisposeAsyncNotifier<List<Habit>> {
  HomeRepository get _repo => ref.watch(homeRepositoryProvider);

  @override
  Future<List<Habit>> build() async {
    ref.listen<DateTime>(selectedDateProvider, (previous, next) {
      ref.invalidateSelf(); // Re-fetch when selected date changes
    });

    ref.listen<HabitCategory?>(selectedCategoryProvider, (previous, next) {
      ref.invalidateSelf(); // Re-fetch when selected category changes
    });

    return await fetchHabits();
  }

  Future<List<Habit>> fetchHabits() async {
    final selectedDate = ref.read(selectedDateProvider);
    final selectedCategory = ref.read(selectedCategoryProvider);
    final userId = await ref.read(userServiceProvider).getCurrentUserId();
    if (userId == null) return [];

    final habits = await _repo.habit.getHabitsByDate(selectedDate, userId);

    // Filter by category if selected
    if (selectedCategory != null) {
      return habits
          .where((habit) => habit.category.id == selectedCategory.id)
          .toList();
    }

    return habits;
  }

  void filterByCategory(HabitCategory? category) {
    ref
        .read(selectedCategoryProvider.notifier)
        .updateSelectedCategory(category);
  }

  void clearCategoryFilter() {
    ref.read(selectedCategoryProvider.notifier).clearCategory();
  }
}
