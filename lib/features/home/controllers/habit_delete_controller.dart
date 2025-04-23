import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_exception.dart';
import '../../../data/domain/models/habit_series.dart';
import '../../habit_detail/repositories/habit_detail_repository.dart';

final habitDeleteControllerProvider = Provider<HabitDeleteController>((ref) {
  final repo = ref.read(habitDetailRepositoryProvider);
  return HabitDeleteController(ref, repo);
});

class HabitDeleteController {
  final Ref ref;
  final HabitDetailRepository _repo;

  HabitDeleteController(this.ref, this._repo);

  Future<HabitSeries?> getHabitSeries(String? habitSeriesId) async {
    if (habitSeriesId == null) return null;
    return await _repo.getHabitSeries(habitSeriesId);
  }

  Future<bool> deleteSingleHabit(String id) async {
    return await _repo.deleteHabit(id);

    // TODO: Handle notification after deleting the habit
  }

  Future<bool> handleDeleteOnlyThis(Habit habit, HabitSeries series) async {
    return await _repo.transaction(() async {
      // Check if there is already an exception for this date
      final existing = await _repo.getHabitException(habit.id);

      if (existing != null) {
        // Update the existing exception → mark as skipped
        return _repo
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
        return _repo.insertHabitException(skipped);
      }
    });
    // TODO: Handle notification after deleting the habit
  }

  Future<bool> handleDeleteAll(HabitSeries series) async {
    return await _repo.transaction(() async {
      final isSeriesDeleted = await _repo.deleteHabitSeries(series.id);
      final isHabitDeleted = await _repo.deleteHabit(series.habitId);
      await _repo.deleteAllExceptionsInSeries(series.id);
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
      await _repo.deleteFutureExceptionsInSeries(series.id, startDateOnly);

      // Update the series with the new end date
      return await _repo.updateHabitSeries(
          series.rebuild((b) => b..untilDate = untilDate.toUtc()));
    });
    // TODO: Handle notification after deleting the habit
  }
}
