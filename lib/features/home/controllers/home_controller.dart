import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/habit.dart';
import '../repositories/home_repository.dart';

final selectedDateProvider =
    StateNotifierProvider<SelectedDateNotifier, DateTime>(
        (ref) => SelectedDateNotifier());

class SelectedDateNotifier extends StateNotifier<DateTime> {
  SelectedDateNotifier() : super(DateTime.now());

  void updateSelectedDate(DateTime newDate) {
    state = newDate;
  }
}

final homeControllerProvider =
    AsyncNotifierProvider.autoDispose<HomeController, List<Habit>>(
        HomeController.new);

class HomeController extends AutoDisposeAsyncNotifier<List<Habit>> {
  HomeRepository get _repo => ref.read(homeRepositoryProvider);

  @override
  Future<List<Habit>> build() async {
    ref.listen<DateTime>(selectedDateProvider, (previous, next) {
      ref.invalidateSelf(); // Re-fetch when selected date changes
    });

    return await _fetchHabits();
  }

  Future<List<Habit>> _fetchHabits() async {
    final selectedDate = ref.read(selectedDateProvider);
    final habits = await _repo.getHabitsByDate(selectedDate);

    return habits;
  }
}
