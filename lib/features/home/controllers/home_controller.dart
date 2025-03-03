import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/models/habit.dart';
import '../repositories/home_repository.dart';
import '../services/home_service.dart';
import '../services/home_service.fake.dart';

final homeServiceProvider = Provider<HomeService>((ref) => FakeHomeService());

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final homeService = ref.watch(homeServiceProvider);
  return HomeRepository(homeService);
});

final habitsProvider = FutureProvider<List<Habit>>((ref) async {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return homeRepository.getHabits();
});

final selectedDateProvider =
    StateNotifierProvider<SelectedDateNotifier, DateTime>(
        (ref) => SelectedDateNotifier());

class SelectedDateNotifier extends StateNotifier<DateTime> {
  SelectedDateNotifier() : super(DateTime.now());

  void updateSelectedDate(DateTime newDate) {
    state = newDate;
  }
}

class FilteredHabitsNotifier extends StateNotifier<List<Habit>> {
  final Ref ref;

  FilteredHabitsNotifier(this.ref) : super([]) {
    fetchHabits();
  }

  Future<void> fetchHabits() async {
    try {
      // Get habits directly from the repository
      final homeRepository = ref.read(homeRepositoryProvider);
      final habits = await homeRepository.getHabits();

      final selectedDate = ref.read(selectedDateProvider);

      // Filter habits
      final filtered = habits.where((habit) {
        if (habit.repeatFrequency == RepeatFrequency.daily) {
          return true;
        }
        return DateFormat('yyyy-MM-dd').format(habit.startDate) ==
            DateFormat('yyyy-MM-dd').format(selectedDate);
      }).toList();

      // Update state
      state = filtered;
    } catch (e) {
      state = [];
    }
  }

  Future<void> addHabit(Habit habit) async {
    state.add(habit);
  }
}

final filteredHabitsProvider =
    StateNotifierProvider<FilteredHabitsNotifier, List<Habit>>((ref) {
  return FilteredHabitsNotifier(ref);
});
