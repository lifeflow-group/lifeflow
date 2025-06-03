import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_category.dart';
import '../../../data/services/analytics_service.dart';
import '../../../data/services/user_service.dart';
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
  AnalyticsService get _analyticsService => ref.read(analyticsServiceProvider);

  @override
  Future<List<Habit>> build() async {
    ref.listen<DateTime>(selectedDateProvider, (previous, next) {
      if (previous != null && previous != next) {
        _analyticsService.trackHomeDateChanged(
            previous, next, next.difference(previous).inDays);
      }
      ref.invalidateSelf(); // Re-fetch when selected date changes
    });

    ref.listen<HabitCategory?>(selectedCategoryProvider, (previous, next) {
      if (previous != next) {
        _analyticsService.trackHomeCategoryChanged(previous?.name, next?.name);
      }
      ref.invalidateSelf(); // Re-fetch when selected category changes
    });

    return await fetchHabits();
  }

  Future<List<Habit>> fetchHabits() async {
    final selectedDate = ref.read(selectedDateProvider);
    final selectedCategory = ref.read(selectedCategoryProvider);
    final userId = await ref.read(userServiceProvider).getCurrentUserId();

    if (userId == null) {
      _analyticsService.trackHomeNoUserLoggedIn(selectedDate);
      return [];
    }

    try {
      _analyticsService.trackHomeHabitsFetching(
          selectedDate, selectedCategory?.name);

      final habits = await _repo.habit.getHabitsByDate(selectedDate, userId);

      // Filter by category if selected
      final filteredHabits = (selectedCategory != null)
          ? habits
              .where((habit) => habit.category.id == selectedCategory.id)
              .toList()
          : habits;

      _analyticsService.trackHomeHabitsFetched(
          selectedDate,
          selectedCategory?.name,
          filteredHabits.length,
          habits.length,
          filteredHabits.where((habit) => habit.isCompleted ?? false).length);

      return filteredHabits;
    } catch (e) {
      _analyticsService.trackHomeHabitsFetchError(selectedDate,
          selectedCategory?.name, e.runtimeType.toString(), e.toString());

      rethrow;
    }
  }

  void filterByCategory(HabitCategory category) {
    _analyticsService.trackHomeCategoryFilterApplied(category.name);

    ref
        .read(selectedCategoryProvider.notifier)
        .updateSelectedCategory(category);
  }

  void clearCategoryFilter() {
    final currentCategory = ref.read(selectedCategoryProvider);

    _analyticsService.trackHomeCategoryFilterCleared(currentCategory?.name);

    ref.read(selectedCategoryProvider.notifier).clearCategory();
  }
}
