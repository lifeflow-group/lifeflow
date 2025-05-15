import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_category.dart';
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

// CategoryStats class to represent category distribution
class CategoryStats {
  final String categoryId;
  final String categoryName;
  final String iconPath;
  final Color color;
  final int habitCount;
  final double percentage;

  CategoryStats({
    required this.categoryId,
    required this.categoryName,
    required this.iconPath,
    required this.color,
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
        progressTypeHabits: 0,
        categoryDistribution: [],
      );
    }

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

        // Find matching default category for styling information
        final defaultCategory = defaultCategories.firstWhere(
          (c) => c.id == category.id,
          orElse: () => defaultCategories[0], // Use first category as fallback
        );

        // Convert hex color string to Color
        final colorHex = defaultCategory.colorHex;
        final color = Color(
          int.parse(colorHex.substring(1), radix: 16) | 0xFF000000,
        );

        // Use the icon path from the category
        final iconPath = defaultCategory.iconPath;

        categoryDistribution.add(
          CategoryStats(
            categoryId: category.id,
            categoryName: category.name,
            iconPath: iconPath,
            color: color,
            habitCount: entry.value,
            percentage: percentage,
          ),
        );
      }
    }

    return OverviewStats(
      totalHabits: monthHabits.length,
      completedHabits: completedHabits,
      completeTypeHabits: completeTypeHabits,
      progressTypeHabits: progressTypeHabits,
      categoryDistribution: categoryDistribution,
    );
  }
}
