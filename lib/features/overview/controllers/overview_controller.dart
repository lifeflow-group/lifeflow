import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/domain/models/habit.dart';
import '../../../data/services/user_service.dart';
import '../repositories/overview_repository.dart';

final selectedMonthProvider =
    StateNotifierProvider<SelectedMonthNotifier, DateTime>(
        (ref) => SelectedMonthNotifier());

class SelectedMonthNotifier extends StateNotifier<DateTime> {
  SelectedMonthNotifier([DateTime? initialDate])
      : super(initialDate ?? DateTime.now());

  void updateSelectedMonth(DateTime newDate) {
    // Set to first day of the month for consistency
    state = DateTime(newDate.year, newDate.month, 1);
  }

  void nextMonth() {
    state = DateTime(state.year, state.month + 1, 1);
  }

  void previousMonth() {
    state = DateTime(state.year, state.month - 1, 1);
  }

  String getFormattedMonth() {
    return DateFormat('MMMM yyyy').format(state);
  }
}

// Overview stats data model
class OverviewStats {
  final int totalHabits;
  final int completedHabits;
  final int completeTypeHabits;
  final int progressTypeHabits;

  OverviewStats({
    required this.totalHabits,
    required this.completedHabits,
    required this.completeTypeHabits,
    required this.progressTypeHabits,
  });
}

final overviewControllerProvider =
    AsyncNotifierProvider.autoDispose<OverviewController, OverviewStats>(
        OverviewController.new);

class OverviewController extends AutoDisposeAsyncNotifier<OverviewStats> {
  OverviewRepository get _repo => ref.watch(overviewRepositoryProvider);

  @override
  Future<OverviewStats> build() async {
    ref.listen<DateTime>(selectedMonthProvider, (previous, next) {
      ref.invalidateSelf(); // Re-fetch when selected month changes
    });

    return await fetchMonthlyStats();
  }

  Future<OverviewStats> fetchMonthlyStats() async {
    final selectedMonth = ref.read(selectedMonthProvider);
    final userId = await ref.read(userServiceProvider).getCurrentUserId();

    if (userId == null) {
      return OverviewStats(
          totalHabits: 0,
          completedHabits: 0,
          completeTypeHabits: 0,
          progressTypeHabits: 0);
    }

    final monthHabits =
        await _repo.habit.getHabitsForMonth(selectedMonth, userId);

    // Calculate stats
    int completedHabits = 0;
    int completeTypeHabits = 0;
    int progressTypeHabits = 0;

    for (var habit in monthHabits) {
      // Count by tracking type
      if (habit.trackingType == TrackingType.complete) {
        completeTypeHabits++;
      } else if (habit.trackingType == TrackingType.progress) {
        progressTypeHabits++;
      }

      // Count completed habits
      if (habit.isCompleted ?? false) {
        completedHabits++;
      }
    }

    return OverviewStats(
      totalHabits: monthHabits.length,
      completedHabits: completedHabits,
      completeTypeHabits: completeTypeHabits,
      progressTypeHabits: progressTypeHabits,
    );
  }
}
