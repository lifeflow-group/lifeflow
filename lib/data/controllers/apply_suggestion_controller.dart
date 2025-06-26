import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/helpers.dart';
import '../domain/models/habit.dart';
import '../domain/models/suggestion.dart';
import '../datasources/local/repositories/repositories.dart';
import '../services/analytics/analytics_service.dart';
import '../services/notifications/mobile_notification_service.dart';
import '../services/user_service.dart';
import './habit_controller.dart';

// Provider for the habit management controller
final applySuggestionControllerProvider = Provider((ref) {
  final repos = ref.read(repositoriesProvider);
  final analyticsService = ref.read(analyticsServiceProvider);
  final notificationService = MobileNotificationService();
  final habitController = ref.read(habitControllerProvider);
  final userService = ref.read(userServiceProvider);

  return ApplySuggestionController(
    repos: repos,
    analytics: analyticsService,
    notification: notificationService,
    habitController: habitController,
    userService: userService,
  );
});

class ApplySuggestionController {
  final Repositories repos;
  final AnalyticsService analytics;
  final MobileNotificationService notification;
  final HabitController habitController;
  final UserService userService;

  ApplySuggestionController({
    required this.repos,
    required this.analytics,
    required this.notification,
    required this.habitController,
    required this.userService,
  });

  Future<List<Habit>> applySuggestions(List<Suggestion> suggestions) async {
    if (suggestions.isEmpty) return [];

    // Get current user ID
    final userId = await userService.getCurrentUserId();
    if (userId == null) return [];

    final appliedHabits = <Habit>[];
    for (final suggestion in suggestions) {
      final habit = suggestion.habit;
      if (habit == null) continue;

      // Check if a similar habit already exists
      final existingHabit = await repos.habit.getHabitRecord(habit.id);

      if (existingHabit != null) {
        // Update existing habit with suggestion data
        final updatedHabit =
            await updateExistingHabit(existingHabit, habit, userId);
        if (updatedHabit != null) {
          appliedHabits.add(habit);
        }
      } else {
        // Create new habit from suggestion
        final newHabit = await createHabit(habit, userId);
        if (newHabit != null) {
          appliedHabits.add(habit);
        }
      }
    }

    // Log final results
    analytics.trackApplySuggestionsCompleted(
        suggestions.length, appliedHabits.length);

    return appliedHabits;
  }

  Future<Habit?> createHabit(Habit habit, String userId) async {
    return await repos.transaction(() async {
      final newHabit = habit.rebuild((b) => b
        ..userId = userId
        ..series = habit.series?.rebuild((s) => s.userId = userId).toBuilder());

      // 1. Create habit series if it exists
      if (newHabit.series != null) {
        await repos.habitSeries.createHabitSeries(newHabit.series!);
      }

      // 2. Create habit
      await repos.habit.createHabit(newHabit);
      return newHabit;
    }).then((newHabit) async {
      // 3. Handle reminder if enabled
      if (newHabit.reminderEnabled == true) {
        await notification.scheduleRecurringReminders(newHabit);
      }

      return newHabit;
    });
  }

  /// Updates an existing habit with data from a suggestion
  Future<Habit?> updateExistingHabit(
      Habit existingHabit, Habit habit, String userId) async {
    final oldSeries =
        await repos.habitSeries.getHabitSeries(existingHabit.series?.id);

    Habit? newHabit = habit.rebuild((b) => b
      ..userId = userId
      ..series = habit.series?.rebuild((s) => s.userId = userId).toBuilder());
    final newSeries = newHabit.series;

    // If there is no old series → simply update or create a new series
    if (oldSeries == null) {
      return await repos.transaction(() async {
        if (newSeries != null) {
          await repos.habitSeries.createHabitSeries(newSeries);
        }
        await repos.habit.updateHabit(newHabit!);
        return true;
      }).then((success) async {
        if (success) {
          await notification.cancelNotification(generateNotificationId(
              existingHabit.date,
              habitId: existingHabit.id));

          final needReschedule = newHabit!.reminderEnabled == true &&
              (newHabit != existingHabit || newSeries != null);
          if (needReschedule) {
            await notification.scheduleRecurringReminders(newHabit,
                excludedDatesUtc: await habitController
                    .getExcludedDatesForSeries(newSeries?.id));
          }
        }
        return newHabit;
      });
    }

    // If there are changes → ask the user for the edit scope
    if (newHabit != existingHabit) {
      // ActionScope.thisAndFollowing
      newHabit = await habitController.handleThisAndFollowing(
          oldSeries, newHabit, newSeries, DateTime.now());
    }

    return newHabit;
  }
}
