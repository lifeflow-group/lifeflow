import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/performance_metric.dart';
import '../services/habits_service.dart';

final habitsRepositoryProvider = Provider((ref) {
  final habitsService = ref.read(habitsServiceProvider);
  return HabitsRepository(habitsService);
});

class HabitsRepository {
  HabitsRepository(this.habitsService);

  final HabitsService habitsService;

  Future<List<Habit>> getHabitsForCurrentMonth(DateTime time) async {
    return await habitsService.fetchHabitsForCurrentMonth(time: time);
  }

  Future<List<PerformanceMetric>> getPerformanceMetrics(
      List<Habit> habits) async {
    return habits.map((habit) {
      double score = 0;
      double? completionRate;
      double? averageProgress;
      double? totalProgress;

      if (habit.trackingType == TrackingType.complete) {
        completionRate = (habit.isCompleted == true) ? 100.0 : 0.0;
        score = completionRate; // Score based on completion rate
      } else if (habit.trackingType == TrackingType.progress) {
        totalProgress = habit.currentValue?.toDouble() ?? 0.0;
        averageProgress = (habit.targetValue != null && habit.targetValue! > 0)
            ? (totalProgress / habit.targetValue!) * 100
            : totalProgress;

        score = averageProgress; // Score based on average progress
      }

      return newPerformanceMetric(
        habitId: habit.id,
        score: score,
        completionRate: completionRate,
        averageProgress: averageProgress,
        totalProgress: totalProgress,
        startDate: DateTime.now().toUtc(),
        endDate: DateTime.now().subtract(Duration(days: 30)).toUtc(),
      );
    }).toList();
  }
}
