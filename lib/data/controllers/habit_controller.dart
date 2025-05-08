import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/helpers.dart';
import '../domain/models/habit.dart';
import '../domain/models/habit_exception.dart';
import '../domain/models/habit_series.dart';
import '../repositories/repositories.dart';
import '../services/notification_service.dart';

final habitControllerProvider = Provider<HabitController>((ref) {
  final repo = ref.read(repositoriesProvider);
  return HabitController(ref, repo, NotificationService());
});

class HabitController {
  final Ref ref;
  final Repositories _repo;
  final NotificationService _notification;

  HabitController(this.ref, this._repo, this._notification);

  Future<HabitSeries?> getHabitSeries(String? habitSeriesId) async {
    if (habitSeriesId == null) return null;
    return await _repo.habitSeries.getHabitSeries(habitSeriesId);
  }

  Future<bool> deleteSingleHabit(String habitId, DateTime date) async {
    final success = await _repo.habit.deleteHabit(habitId);
    if (success) {
      // Also cancel scheduled notifications related to this habit
      await _notification
          .cancelNotification(generateNotificationId(date, habitId: habitId));
    }
    return success;
  }

  Future<bool> handleDeleteOnlyThis(Habit habit, HabitSeries series) async {
    final success = await _repo.transaction(() async {
      // Check if there is already an exception for this date
      final existing = await _repo.habitException.getHabitException(habit.id);

      if (existing != null) {
        // Update the existing exception → mark as skipped
        return _repo.habitException
            .updateHabitException(existing.rebuild((b) => b..isSkipped = true));
      } else {
        // Create a new exception → mark as skipped
        final skipped = HabitException(
          (p0) => p0
            ..id = generateNewId('habit')
            ..habitSeriesId = series.id
            ..date = habit.startDate
            ..reminderEnabled = habit.reminderEnabled
            ..isSkipped = true,
        );
        return _repo.habitException.insertHabitException(skipped);
      }
    });

    if (success) {
      await _notification.cancelNotification(
          generateNotificationId(habit.startDate, seriesId: series.id));
    }

    return success;
  }

  Future<bool> handleDeleteAll(HabitSeries series) async {
    final success = await _repo.transaction(() async {
      final isSeriesDeleted =
          await _repo.habitSeries.deleteHabitSeries(series.id);
      final isHabitDeleted = await _repo.habit.deleteHabit(series.habitId);
      await _repo.habitException.deleteAllExceptionsInSeries(series.id);
      return isSeriesDeleted && isHabitDeleted;
    });

    if (success) {
      await _notification.cancelNotificationsByHabitSeriesId(series.id);
    }
    return success;
  }

  Future<bool> handleDeleteThisAndFollowing(
      Habit habit, HabitSeries series) async {
    final success = await _repo.transaction(() async {
      final startDate = habit.startDate.toLocal();
      final startDateOnly =
          DateTime(startDate.year, startDate.month, startDate.day);
      final untilDate = startDateOnly.subtract(const Duration(days: 1));

      // Delete all exceptions from current date forward
      await _repo.habitException
          .deleteFutureExceptionsInSeries(series.id, startDateOnly);

      // Update the series with the new end date
      return await _repo.habitSeries.updateHabitSeries(
          series.rebuild((b) => b..untilDate = untilDate.toUtc()));
    });

    if (success) {
      await _notification.cancelFutureNotificationsByHabitSeriesId(
          series.id, habit.startDate);
    }
    return success;
  }

  Future<void> recordHabit({
    required Habit habit,
    required DateTime selectedDate,
    required int? currentValue,
    required bool? isCompleted,
  }) async {
    if (habit.habitSeriesId != null) {
      // Habit belongs to a series
      final existingException =
          await _repo.habitException.getHabitException(habit.id);

      if (existingException != null) {
        // Update existing exception
        final updated = existingException.rebuild((b) {
          b
            ..currentValue = currentValue
            ..isCompleted = isCompleted;
        });
        await _repo.habitException.updateHabitException(updated);
      } else {
        // Create a new exception
        final newException = HabitException((b) => b
          ..id = habit.id
          ..habitSeriesId = habit.habitSeriesId
          ..date = selectedDate.toUtc()
          ..isSkipped = false
          ..reminderEnabled = habit.reminderEnabled
          ..currentValue = currentValue
          ..targetValue = habit.targetValue
          ..isCompleted = isCompleted);

        await _repo.habitException.insertHabitException(newException);
      }
    } else {
      // Independent habit → update directly
      final updated = habit.rebuild((p0) => p0
        ..currentValue = currentValue
        ..isCompleted = isCompleted);
      await _repo.habit.updateHabit(updated);
    }

    // Handle notification
    final now = DateTime.now();
    final isToday = selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;
    final completed = isCompleted == true || currentValue == habit.targetValue;

    if (isToday && habit.reminderEnabled && completed) {
      final notificationId = habit.habitSeriesId != null
          ? generateNotificationId(selectedDate, seriesId: habit.habitSeriesId)
          : generateNotificationId(selectedDate, habitId: habit.id);

      await _notification.cancelNotification(notificationId);
    }
  }
}
