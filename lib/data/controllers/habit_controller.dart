import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/helpers.dart';
import '../domain/models/habit.dart';
import '../domain/models/habit_exception.dart';
import '../domain/models/habit_series.dart';
import '../repositories/repositories.dart';

final habitControllerProvider = Provider<HabitController>((ref) {
  final repo = ref.read(repositoriesProvider);
  return HabitController(ref, repo);
});

class HabitController {
  final Ref ref;
  final Repositories _repo;

  HabitController(this.ref, this._repo);

  Future<HabitSeries?> getHabitSeries(String? habitSeriesId) async {
    if (habitSeriesId == null) return null;
    return await _repo.habitSeries.getHabitSeries(habitSeriesId);
  }

  Future<bool> deleteSingleHabit(String id) async {
    return await _repo.habit.deleteHabit(id);

    // TODO: Handle notification after deleting the habit
  }

  Future<bool> handleDeleteOnlyThis(Habit habit, HabitSeries series) async {
    return await _repo.transaction(() async {
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
    // TODO: Handle notification after deleting the habit
  }

  Future<bool> handleDeleteAll(HabitSeries series) async {
    return await _repo.transaction(() async {
      final isSeriesDeleted =
          await _repo.habitSeries.deleteHabitSeries(series.id);
      final isHabitDeleted = await _repo.habit.deleteHabit(series.habitId);
      await _repo.habitException.deleteAllExceptionsInSeries(series.id);
      return isSeriesDeleted && isHabitDeleted;
    });
    // TODO: Handle notification after deleting the habit
  }

  Future<bool> handleDeleteThisAndFollowing(
      Habit habit, HabitSeries series) async {
    return await _repo.transaction(() async {
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
    // TODO: Handle notification after deleting the habit
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

    // TODO: Handle notification
  }
}
