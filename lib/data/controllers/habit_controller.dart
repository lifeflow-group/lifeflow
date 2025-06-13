import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/helpers.dart';
import '../../features/habit_detail/controllers/habit_detail_controller.dart';
import '../../shared/widgets/scope_dialog.dart';
import '../domain/models/habit.dart';
import '../domain/models/habit_exception.dart';
import '../domain/models/habit_series.dart';
import '../repositories/repositories.dart';
import '../services/notifications/mobile_notification_service.dart';

final habitControllerProvider = Provider<HabitController>((ref) {
  final repo = ref.read(repositoriesProvider);
  return HabitController(ref, repo, MobileNotificationService());
});

class HabitController {
  final Ref ref;
  final Repositories _repo;
  final MobileNotificationService _notification;

  HabitController(this.ref, this._repo, this._notification);

  Future<Habit?> createHabit(HabitFormResult result) async {
    final newHabit = result.newHabit;
    final newSeries = result.newSeries;

    return await _repo.transaction(() async {
      // 1. Create habit series
      if (newSeries != null) {
        await _repo.habitSeries.createHabitSeries(newSeries);
      }
      // 2. Create habit
      await _repo.habit.createHabit(newHabit);
      return newHabit;
    }).then((newHabit) async {
      // 3. Handle reminder if enabled
      if (newHabit.reminderEnabled == true) {
        await _notification.scheduleRecurringReminders(newHabit, newSeries,
            excludedDatesUtc: await getExcludedDatesForSeries(newSeries?.id));
      }

      return newHabit;
    });
  }

  Future<Habit?> updateHabit(HabitFormResult result) async {
    final oldHabit = result.oldHabit;
    if (oldHabit == null) return null;
    Habit? newHabit = result.newHabit;
    final newSeries = result.newSeries;
    final oldSeries = result.oldSeries;
    final actionScope = result.actionScope;

    // I. If there is no old series → create a new series and update the habit
    if (oldSeries == null) {
      return await _repo.transaction(() async {
        // 1. Create habit series
        if (newSeries != null) {
          await _repo.habitSeries.createHabitSeries(newSeries);
        }
        // 2. Create habit
        await _repo.habit.updateHabit(newHabit!);

        return newHabit;
      }).then((newHabit) async {
        // 3. If the update was successful, handle notifications
        await _notification.cancelNotification(
            generateNotificationId(oldHabit.startDate, habitId: oldHabit.id));
        final needReschedule = newHabit.reminderEnabled == true &&
            (newHabit != oldHabit || newSeries != null);
        if (needReschedule) {
          await _notification.scheduleRecurringReminders(newHabit, newSeries,
              excludedDatesUtc: await getExcludedDatesForSeries(newSeries?.id));
        }

        return newHabit;
      });
    }

    // II. If oldSeries != null and there are changes → handle them based on the action scope
    if (newHabit != oldHabit && actionScope != null) {
      switch (actionScope) {
        case ActionScope.onlyThis:
          newHabit = await _handleOnlyThis(oldHabit, newHabit, newSeries);
          break;
        case ActionScope.all:
          newHabit = await _handleAll(oldSeries, newHabit, newSeries);
          break;
        case ActionScope.thisAndFollowing:
          newHabit = await handleThisAndFollowing(
              oldSeries, newHabit, newSeries, ref.read(habitDateProvider));
          break;
      }
    }

    return newHabit;
  }

  Future<Habit?> _handleOnlyThis(
    Habit oldHabit,
    Habit newHabit,
    HabitSeries? newSeries,
  ) async {
    Habit? originalHabit;
    final habitDate = ref.read(habitDateProvider).toLocal();
    HabitException? exception =
        await _repo.habitException.getHabitException(oldHabit.id);
    HabitSeries? newSeriesWithId;

    final success = await _repo.transaction(() async {
      // Skip the habit for today
      if (exception == null) {
        exception = HabitException((b) => b
          ..id = oldHabit.id
          ..habitSeriesId = oldHabit.habitSeriesId
          ..reminderEnabled = oldHabit.reminderEnabled
          ..date = habitDate.toUtc()
          ..isSkipped = true);

        await _repo.habitException.insertHabitException(exception!);
      } else {
        exception = exception!.rebuild((b) => b
          ..date = habitDate.toUtc()
          ..isSkipped = true);
        await _repo.habitException.updateHabitException(exception!);
      }

      originalHabit = newHabit.rebuild((p0) => p0.id = generateNewId('habit'));

      if (newSeries != null) {
        final newSeriesId = generateNewId('series');
        newSeriesWithId = newSeries.rebuild((p0) => p0
          ..id = newSeriesId
          ..habitId = originalHabit!.id);
        await _repo.habitSeries.createHabitSeries(newSeriesWithId!);
        originalHabit =
            originalHabit!.rebuild((p0) => p0.habitSeriesId = newSeriesId);
      }

      await _repo.habit.createHabit(originalHabit!);
      // Return the new habit with the new series

      return true;
    });

    if (success) {
      await _notification.cancelNotification(generateNotificationId(
          oldHabit.startDate,
          seriesId: oldHabit.habitSeriesId));

      if (originalHabit!.reminderEnabled) {
        await _notification.scheduleRecurringReminders(
            originalHabit!, newSeriesWithId,
            excludedDatesUtc:
                await getExcludedDatesForSeries(newSeriesWithId?.id));
      }

      return originalHabit;
    }

    return null;
  }

  Future<Habit?> _handleAll(
    HabitSeries oldSeries,
    Habit newHabit,
    HabitSeries? newSeries,
  ) async {
    late final Habit updatedOriginalHabit;
    HabitSeries? updateSeries;
    final success = await _repo.transaction(() async {
      final newTime = newHabit.startDate.toLocal();
      final startDate = oldSeries.startDate
          .toLocal()
          .copyWith(hour: newTime.hour, minute: newTime.minute);

      String? habitSeriesId = newSeries?.id;
      if (newSeries == null) {
        await _repo.habitSeries.deleteHabitSeries(oldSeries.id);
      } else {
        habitSeriesId = oldSeries.id;
        updateSeries = newSeries.rebuild((b) => b
          ..id = habitSeriesId
          ..habitId = oldSeries.habitId
          ..startDate = startDate.toUtc());
        await _repo.habitSeries.updateHabitSeries(updateSeries!);
      }

      updatedOriginalHabit = newHabit.rebuild((b) => b
        ..id = oldSeries.habitId
        ..habitSeriesId = habitSeriesId
        ..startDate = startDate.toUtc());
      await _repo.habit.updateHabit(updatedOriginalHabit);

      // Return the updated original habit
      return true;
    });

    if (success) {
      await _notification.cancelNotificationsByHabitSeriesId(oldSeries.id);

      if (updatedOriginalHabit.reminderEnabled) {
        await _notification.scheduleRecurringReminders(
            updatedOriginalHabit, updateSeries,
            excludedDatesUtc:
                await getExcludedDatesForSeries(updateSeries?.id));
      }

      return updatedOriginalHabit;
    }

    return null;
  }

  Future<Habit?> handleThisAndFollowing(
    HabitSeries oldSeries,
    Habit newHabit,
    HabitSeries? newSeries,
    DateTime habitDate,
  ) async {
    late Habit newHabitWithId;
    HabitSeries? createdNewSeries;

    final success = await _repo.transaction(() async {
      // 1. Trim the old series before the current date
      final updatedOldSeries = oldSeries.rebuild(
        (b) => b..untilDate = habitDate.subtract(const Duration(days: 1)),
      );
      await _repo.habitSeries.updateHabitSeries(updatedOldSeries);

      // 2. Create a new habit
      newHabitWithId = newHabit.rebuild((b) => b.id = generateNewId('habit'));

      // 3. If it still repeats → create a new series

      if (newSeries != null) {
        createdNewSeries = newSeries.rebuild((b) => b
          ..id = generateNewId('series')
          ..habitId = newHabitWithId.id);
        await _repo.habitSeries.createHabitSeries(createdNewSeries!);
        newHabitWithId = newHabitWithId.rebuild(
          (b) => b.habitSeriesId = createdNewSeries?.id,
        );
      }

      await _repo.habit.createHabit(newHabitWithId);

      // 4. Handle exceptions after trimming
      final exceptions = await _repo.habitException
          .getExceptionsAfterDate(oldSeries.id, habitDate);

      for (final exception in exceptions) {
        if (exception.isSkipped) {
          // If it's a skip → keep it, but update it to the new series (if any)
          if (createdNewSeries != null) {
            final updatedException = exception.rebuild(
              (p0) => p0.habitSeriesId = createdNewSeries?.id,
            );
            await _repo.habitException.updateHabitException(updatedException);
          }
        } else {
          // If it's an override:
          if (createdNewSeries != null) {
            // Assign it to the new series
            final updatedException = exception.rebuild(
              (p0) => p0.habitSeriesId = createdNewSeries?.id,
            );
            await _repo.habitException.updateHabitException(updatedException);
          } else {
            // If there is no new series → create a habit from the exception
            final habitFromException =
                _buildHabitFromException(newHabitWithId, exception);
            await _repo.habit.createHabit(habitFromException);
            await _repo.habitException.deleteHabitException(exception.id);
          }
        }
      }

      return true;
    });

    if (success) {
      await _notification.cancelFutureNotificationsByHabitSeriesId(
          oldSeries.id, habitDate);

      if (newHabitWithId.reminderEnabled) {
        await _notification.scheduleRecurringReminders(
            newHabitWithId, createdNewSeries,
            excludedDatesUtc:
                await getExcludedDatesForSeries(createdNewSeries?.id));
      }

      return newHabitWithId;
    }

    return null;
  }

  Habit _buildHabitFromException(Habit baseHabit, HabitException exception) {
    return baseHabit.rebuild((b) => b
          ..id = exception.id
          ..startDate = exception.date
          ..reminderEnabled = exception.reminderEnabled
          ..currentValue = exception.currentValue
          ..isCompleted = exception.isCompleted
          ..habitSeriesId = null // detach from the series
        );
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
          ..date = habit.startDate.toUtc()
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
    final startDate = habit.startDate.toLocal();
    final isToday = startDate.year == now.year &&
        startDate.month == now.month &&
        startDate.day == now.day;
    final completed = isCompleted == true || currentValue == habit.targetValue;

    if (isToday && habit.reminderEnabled && completed) {
      final notificationId = habit.habitSeriesId != null
          ? generateNotificationId(startDate, seriesId: habit.habitSeriesId)
          : generateNotificationId(startDate, habitId: habit.id);

      await _notification.cancelNotification(notificationId);
    }
  }

  Future<Set<DateTime>> getExcludedDatesForSeries(String? habitSeriesId) async {
    if (habitSeriesId == null) return <DateTime>{};

    final habitExceptions =
        await _repo.habitException.getHabitExceptionsForSeries(habitSeriesId);

    // Convert to Set<DateTime> UTC in yyyy-MM-dd format
    final excludedDatesUtc = habitExceptions
        .where((e) => e.isSkipped)
        .map((e) => DateTime.utc(e.date.year, e.date.month, e.date.day))
        .toSet();

    return excludedDatesUtc;
  }
}
