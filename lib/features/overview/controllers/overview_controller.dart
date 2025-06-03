import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_category.dart';
import '../../../data/services/analytics_service.dart';
import '../../../data/services/user_service.dart';
import '../../../features/settings/controllers/settings_controller.dart';
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

// CategoryStats class to represent category distribution
class CategoryStats {
  final HabitCategory category;
  final int habitCount;
  final double percentage;

  CategoryStats({
    required this.category,
    required this.habitCount,
    required this.percentage,
  });
}

// OverviewStats to include category distribution
class OverviewStats {
  final int totalHabits;
  final int completedHabits;
  final int completeTypeHabits;
  final int progressTypeHabits;
  final List<CategoryStats> categoryDistribution;

  OverviewStats({
    required this.totalHabits,
    required this.completedHabits,
    required this.completeTypeHabits,
    required this.progressTypeHabits,
    required this.categoryDistribution,
  });
}

final overviewControllerProvider =
    AsyncNotifierProvider.autoDispose<OverviewController, OverviewStats>(
        OverviewController.new);

class OverviewController extends AutoDisposeAsyncNotifier<OverviewStats> {
  OverviewRepository get _repo => ref.watch(overviewRepositoryProvider);
  AnalyticsService get _analyticsService => ref.read(analyticsServiceProvider);

  @override
  Future<OverviewStats> build() async {
    ref.listen<DateTime>(selectedMonthProvider, (previous, next) {
      if (previous != null) {
        final settingsState = ref.read(settingsControllerProvider);
        final fromMonth =
            formatDateWithUserLanguage(settingsState, previous, 'yyyy-MM');
        final toMonth =
            formatDateWithUserLanguage(settingsState, next, 'yyyy-MM');
        final monthsDifference = _calculateMonthDifference(previous, next);

        _analyticsService.trackMonthChanged(
            fromMonth, toMonth, monthsDifference);
      }
      ref.invalidateSelf(); // Re-fetch when selected month changes
    });

    return await fetchMonthlyStats();
  }

  Future<OverviewStats> fetchMonthlyStats() async {
    final selectedMonth = ref.read(selectedMonthProvider);
    final settingsState = ref.read(settingsControllerProvider);
    final userId = await ref.read(userServiceProvider).getCurrentUserId();
    final formattedMonth =
        formatDateWithUserLanguage(settingsState, selectedMonth, 'yyyy-MM');

    if (userId == null) {
      _analyticsService.trackOverviewStatsNoUser(formattedMonth);

      return OverviewStats(
        totalHabits: 0,
        completedHabits: 0,
        completeTypeHabits: 0,
        progressTypeHabits: 0,
        categoryDistribution: [],
      );
    }

    try {
      final monthHabits =
          await _repo.habit.getHabitsForMonth(selectedMonth, userId);

      // Calculate basic stats
      int completedHabits = 0;
      int completeTypeHabits = 0;
      int progressTypeHabits = 0;

      // Count habits by category
      final categoryCountMap = <String, int>{};
      final categoryDetailsMap = <String, HabitCategory>{};

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

        // Count by category
        final categoryId = habit.category.id;
        categoryCountMap[categoryId] = (categoryCountMap[categoryId] ?? 0) + 1;
        categoryDetailsMap[categoryId] = habit.category;
      }

      // Calculate category distribution percentages
      final List<CategoryStats> categoryDistribution = [];

      if (monthHabits.isNotEmpty) {
        // Sort categories by count (descending)
        final sortedCategories = categoryCountMap.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        // Calculate percentages
        for (var entry in sortedCategories) {
          final category = categoryDetailsMap[entry.key]!;
          final percentage = entry.value / monthHabits.length * 100;

          categoryDistribution.add(CategoryStats(
              category: category,
              habitCount: entry.value,
              percentage: percentage));
        }
      }

      final stats = OverviewStats(
        totalHabits: monthHabits.length,
        completedHabits: completedHabits,
        completeTypeHabits: completeTypeHabits,
        progressTypeHabits: progressTypeHabits,
        categoryDistribution: categoryDistribution,
      );

      // Calculate completion rate
      final completionRate = stats.totalHabits != 0
          ? (stats.completedHabits / stats.totalHabits * 100).round()
          : 0;

      // Log stats loaded successfully
      _analyticsService.trackOverviewStatsLoaded(formattedMonth,
          stats.totalHabits, stats.completedHabits, completionRate);

      // Log chart data loaded if there are categories
      if (stats.categoryDistribution.isNotEmpty) {
        _analyticsService.trackChartDataLoaded(formattedMonth,
            stats.categoryDistribution.length, stats.totalHabits);
      } else {
        _analyticsService.trackChartEmptyData(formattedMonth);
      }

      return stats;
    } catch (e) {
      // Log error
      _analyticsService.trackOverviewError(e.toString(), formattedMonth);
      rethrow;
    }
  }

  // Helper method to calculate months between two dates
  int _calculateMonthDifference(DateTime from, DateTime to) {
    return (to.year - from.year) * 12 + to.month - from.month;
  }
}
