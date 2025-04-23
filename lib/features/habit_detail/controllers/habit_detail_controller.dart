import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/providers/user_provider.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_category.dart';
import '../../../data/domain/models/habit_exception.dart';
import '../../../data/domain/models/habit_series.dart';
import '../presentation/widgets/edit_scope_dialog.dart';
import '../repositories/habit_detail_repository.dart';
import '../services/notification_service.dart';

// Provider for managing the habit name.
final habitNameProvider = StateProvider<String>((ref) => '');

// Provider for managing the habit category.
final habitCategoryProvider = StateProvider<HabitCategory?>((ref) => null);

// Provider for managing the habit start date.
final habitDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

// Provider for managing the habit start time.
final habitTimeProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());

// Provider for managing the habit repeat frequency.
final habitRepeatFrequencyProvider =
    StateProvider<RepeatFrequency?>((ref) => null);

// Provider for managing the habit tracking type.
final habitTrackingTypeProvider =
    StateProvider<TrackingType>((ref) => TrackingType.complete);

// Providers for progress tracking
final habitQuantityProvider = StateProvider<int>((ref) => 0);

final habitUnitProvider = StateProvider<String>((ref) => '');

// Provider for managing the habit notification.
final habitReminderProvider = StateProvider<bool>((ref) => false);

// Provider containing functions to update data
final habitDetailControllerProvider = Provider<HabitDetailController>((ref) {
  final repo = ref.read(habitDetailRepositoryProvider);
  return HabitDetailController(ref, repo);
});

class HabitDetailController {
  final Ref ref;
  final HabitDetailRepository _repo;

  HabitDetailController(this.ref, this._repo);

  Future<void> fromHabit(Habit habit) async {
    updateHabitName(habit.name);
    updateHabitCategory(habit.category);
    updateHabitDate(habit.startDate.toLocal());
    updateHabitTime(TimeOfDay.fromDateTime(habit.startDate.toLocal()));
    updateTrackingType(habit.trackingType);
    updateHabitQuantity(habit.targetValue ?? 0);
    updateHabitUnit(habit.unit ?? '');
    final habitSeries = await _repo.getHabitSeries(habit.habitSeriesId);
    if (habitSeries != null) {
      updateHabitRepeatFrequency(habitSeries.repeatFrequency);
    }

    if (habit.trackingType == TrackingType.progress) {
      updateHabitQuantity(habit.targetValue ?? 0);
      updateHabitUnit(habit.unit ?? '');
    }

    updateHabitReminder(habit.reminderEnabled);
  }

  void updateHabitName(String name) {
    ref.read(habitNameProvider.notifier).state = name;
  }

  void updateHabitCategory(HabitCategory? category) {
    ref.read(habitCategoryProvider.notifier).state = category;
  }

  void updateHabitDate(DateTime date) {
    ref.read(habitDateProvider.notifier).state = date;
  }

  void updateHabitTime(TimeOfDay time) {
    ref.read(habitTimeProvider.notifier).state = time;
  }

  void updateHabitRepeatFrequency(RepeatFrequency? frequency) {
    ref.read(habitRepeatFrequencyProvider.notifier).state = frequency;
  }

  void updateTrackingType(TrackingType type) {
    ref.read(habitTrackingTypeProvider.notifier).state = type;
  }

  void updateHabitQuantity(int quantity) {
    ref.read(habitQuantityProvider.notifier).state = quantity;
  }

  void updateHabitUnit(String unit) {
    ref.read(habitUnitProvider.notifier).state = unit;
  }

  Future<void> updateHabitReminder(bool reminder) async {
    if (reminder) {
      await NotificationService.requestPermission();
    }
    ref.read(habitReminderProvider.notifier).state = reminder;
  }

  Future<Habit?> createHabit() async {
    return await _repo.transaction(() async {
      // 1. Build habit from form
      Habit? habitModel = await _buildHabitFromForm();
      if (habitModel == null) return null;

      // 2. Build optional series
      final habitSeries = _buildHabitSeries(habitModel);

      if (habitSeries != null) {
        await _repo.createHabitSeries(habitSeries);
        habitModel =
            habitModel.rebuild((b) => b..habitSeriesId = habitSeries.id);
      }

      // 3. Create habit
      await _repo.createHabit(habitModel);
      return habitModel;
    }).then((habitModel) async {
      // 4. Handle reminder if enabled
      // Separate reminder handling from the transaction (as it may involve the OS and cannot be rolled back)
      if (habitModel?.reminderEnabled == true) {
        await _scheduleRecurringReminders(
            habitModel!, _buildHabitSeries(habitModel));
      }

      return habitModel;
    });
  }

  Future<Habit?> updateHabit(
      Habit oldHabit, Future<ActionScope?> Function() pickScope) async {
    final oldSeries = await _repo.getHabitSeries(oldHabit.habitSeriesId);
    Habit? newHabit = await _buildHabitFromForm(habitId: oldHabit.id);
    if (newHabit == null) return null;

    final newSeries = _buildHabitSeries(newHabit, oldSeries: oldSeries);
    newHabit = newHabit.rebuild((b) => b..habitSeriesId = newSeries?.id);

    // If there is no old series → simply update or create a new series
    if (oldSeries == null) {
      return await _repo.transaction(() async {
        if (newSeries != null) await _repo.createHabitSeries(newSeries);
        await _repo.updateHabit(newHabit!);
        return newHabit;
      });
    }

    // If there are changes → ask the user for the edit scope
    if (newHabit != oldHabit) {
      final actionScope = await pickScope();
      if (actionScope == null) return null;

      switch (actionScope) {
        case ActionScope.onlyThis:
          newHabit = await _handleOnlyThis(oldHabit, newHabit, newSeries);
          break;
        case ActionScope.all:
          newHabit = await _handleAll(oldSeries, newHabit, newSeries);
          break;
        case ActionScope.thisAndFollowing:
          newHabit =
              await _handleThisAndFollowing(oldSeries, newHabit, newSeries);
          break;
      }
    }

    /// TODO: Re-schedule habit reminders if time, frequency, or reminderEnabled has changed.

    return newHabit;
  }

  Future<Habit> _handleOnlyThis(
    Habit oldHabit,
    Habit newHabit,
    HabitSeries? newSeries,
  ) async {
    return await _repo.transaction(() async {
      final habitDate = ref.read(habitDateProvider).toLocal();
      HabitException? exception = await _repo.getHabitException(oldHabit.id);

      // Skip the habit for today
      if (exception == null) {
        exception = HabitException((b) => b
          ..id = oldHabit.id
          ..habitSeriesId = oldHabit.habitSeriesId
          ..reminderEnabled = oldHabit.reminderEnabled
          ..date = habitDate.toUtc()
          ..isSkipped = true);

        await _repo.insertHabitException(exception);
      } else {
        exception = exception.rebuild((b) => b
          ..date = habitDate.toUtc()
          ..isSkipped = true);
        await _repo.updateHabitException(exception);
      }

      Habit originalHabit =
          newHabit.rebuild((p0) => p0.id = generateNewId('habit'));

      if (newSeries != null) {
        final newSeriesId = generateNewId('series');
        await _repo.createHabitSeries(newSeries.rebuild((p0) => p0
          ..id = newSeriesId
          ..habitId = originalHabit.id));
        originalHabit =
            originalHabit.rebuild((p0) => p0.habitSeriesId = newSeriesId);
      }

      await _repo.createHabit(originalHabit);
      // Return the new habit with the new series
      return originalHabit;
    });
  }

  Future<Habit> _handleAll(
    HabitSeries oldSeries,
    Habit newHabit,
    HabitSeries? newSeries,
  ) async {
    return await _repo.transaction(() async {
      final newTime = newHabit.startDate.toLocal();
      final startDate = oldSeries.startDate
          .toLocal()
          .copyWith(hour: newTime.hour, minute: newTime.minute);

      String? habitSeriesId = newSeries?.id;
      if (newSeries == null) {
        await _repo.deleteHabitSeries(oldSeries.id);
      } else {
        habitSeriesId = oldSeries.id;
        final updateSeries = newSeries.rebuild((b) => b
          ..id = habitSeriesId
          ..habitId = oldSeries.habitId
          ..startDate = startDate.toUtc());
        await _repo.updateHabitSeries(updateSeries);
      }

      final updatedOriginalHabit = newHabit.rebuild((b) => b
        ..id = oldSeries.habitId
        ..habitSeriesId = habitSeriesId
        ..startDate = startDate.toUtc());
      await _repo.updateHabit(updatedOriginalHabit);

      // Return the updated original habit
      return updatedOriginalHabit;
    });
  }

  Future<Habit> _handleThisAndFollowing(
    HabitSeries oldSeries,
    Habit newHabit,
    HabitSeries? newSeries,
  ) async {
    return await _repo.transaction(() async {
      final habitDate = ref.read(habitDateProvider);

      // 1. Trim the old series before the current date
      final updatedOldSeries = oldSeries.rebuild(
        (b) => b..untilDate = habitDate.subtract(const Duration(days: 1)),
      );
      await _repo.updateHabitSeries(updatedOldSeries);

      // 2. Create a new habit
      Habit newHabitWithId =
          newHabit.rebuild((b) => b.id = generateNewId('habit'));

      // 3. If it still repeats → create a new series
      HabitSeries? createdNewSeries;
      if (newSeries != null) {
        createdNewSeries = newSeries.rebuild((b) => b
          ..id = generateNewId('series')
          ..habitId = newHabitWithId.id);
        await _repo.createHabitSeries(createdNewSeries);
        newHabitWithId = newHabitWithId.rebuild(
          (b) => b.habitSeriesId = createdNewSeries?.id,
        );
      }

      await _repo.createHabit(newHabitWithId);

      // 4. Handle exceptions after trimming
      final exceptions =
          await _repo.getExceptionsAfterDate(oldSeries.id, habitDate);

      for (final exception in exceptions) {
        if (exception.isSkipped) {
          // If it's a skip → keep it, but update it to the new series (if any)
          if (createdNewSeries != null) {
            final updatedException = exception.rebuild(
              (p0) => p0.habitSeriesId = createdNewSeries?.id,
            );
            await _repo.updateHabitException(updatedException);
          }
        } else {
          // If it's an override:
          if (createdNewSeries != null) {
            // Assign it to the new series
            final updatedException = exception.rebuild(
              (p0) => p0.habitSeriesId = createdNewSeries?.id,
            );
            await _repo.updateHabitException(updatedException);
          } else {
            // If there is no new series → create a habit from the exception
            final habitFromException = _buildHabitFromException(
              newHabitWithId,
              exception,
            );
            await _repo.createHabit(habitFromException);
            await _repo.deleteHabitException(exception.id);
          }
        }
      }

      // Return the new habit with the new series
      return newHabitWithId;
    });
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

  // Schedules reminders for recurring habits
  Future<void> _scheduleRecurringReminders(
      Habit habit, HabitSeries? habitSeries) async {
    if (habitSeries == null) {
      // One-time habit
      await NotificationService.scheduleNotification(
        Uuid().v4().hashCode,
        "Habit: ${habit.name}",
        "Time to complete your habit!",
        habit.startDate,
      );
      return;
    }

    // Get recurring dates for next 30 days
    final recurringDates = generateRecurringDates(habitSeries, daysAhead: 30);

    for (final date in recurringDates) {
      await NotificationService.scheduleNotification(
        Uuid().v4().hashCode,
        "Habit: ${habit.name}",
        "Time to complete your habit!",
        date,
      );
    }

    debugPrint('Scheduled reminders for ${recurringDates.length} instances');
  }

  Future<Habit?> _buildHabitFromForm({String? habitId}) async {
    final name = ref.read(habitNameProvider);
    final category = ref.read(habitCategoryProvider);
    final time = ref.read(habitTimeProvider);
    final date = ref
        .read(habitDateProvider)
        .toLocal()
        .copyWith(hour: time.hour, minute: time.minute);
    final trackingType = ref.read(habitTrackingTypeProvider);
    final quantity = ref.read(habitQuantityProvider);
    final unit = ref.read(habitUnitProvider);
    final reminder = ref.read(habitReminderProvider);
    // Read userServiceProvider to get userId
    final userId = await ref.read(userServiceProvider).getCurrentUserId();

    if (name.isEmpty || category == null || userId == null) return null;

    Habit habitModel = newHabit(
      id: habitId,
      userId: userId,
      name: name,
      category: category,
      startDate: date.toUtc(),
      trackingType: trackingType,
      targetValue: trackingType == TrackingType.progress ? quantity : null,
      unit: trackingType == TrackingType.progress ? unit : null,
      reminderEnabled: reminder,
    );

    return habitModel;
  }

  HabitSeries? _buildHabitSeries(Habit habitModel, {HabitSeries? oldSeries}) {
    final repeatFrequency = ref.read(habitRepeatFrequencyProvider);
    if (repeatFrequency == null) return null;

    return newHabitSeries(
      id: oldSeries?.repeatFrequency == repeatFrequency ? oldSeries?.id : null,
      userId: habitModel.userId,
      habitId: habitModel.id,
      startDate: habitModel.startDate,
      repeatFrequency: repeatFrequency,
    );
  }

  void resetForm() {
    ref.read(habitNameProvider.notifier).state = '';
    ref.read(habitCategoryProvider.notifier).state = null;
    ref.read(habitDateProvider.notifier).state = DateTime.now();
    ref.read(habitTimeProvider.notifier).state = TimeOfDay.now();
    ref.read(habitRepeatFrequencyProvider.notifier).state = null;
    ref.read(habitTrackingTypeProvider.notifier).state = TrackingType.complete;
    ref.read(habitQuantityProvider.notifier).state = 0;
    ref.read(habitUnitProvider.notifier).state = '';
    ref.read(habitReminderProvider.notifier).state = false;
  }
}
