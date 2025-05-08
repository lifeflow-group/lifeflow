import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/services/user_service.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_category.dart';
import '../../../data/domain/models/habit_exception.dart';
import '../../../data/domain/models/habit_series.dart';
import '../../../shared/widgets/scope_dialog.dart';
import '../repositories/habit_detail_repository.dart';
import '../../../data/services/notification_service.dart';

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

// Provider for managing the habit completion status.
final habitIsCompletedProvider = StateProvider<bool>((ref) => false);

// Providers for progress tracking
final habitCurrentValueProvider = StateProvider<int>((ref) => 0);

// Provider for managing the habit target value.
final habitTargetValueProvider = StateProvider<int>((ref) => 0);

// Provider for managing the habit unit.
final habitUnitProvider = StateProvider<String>((ref) => '');

// Provider for managing the habit notification.
final habitReminderProvider = StateProvider<bool>((ref) => false);

// Provider containing functions to update data
final habitDetailControllerProvider = Provider<HabitDetailController>((ref) {
  final repo = ref.read(habitDetailRepositoryProvider);
  return HabitDetailController(ref, repo, NotificationService());
});

class HabitDetailController {
  final Ref ref;
  final HabitDetailRepository _repo;
  final NotificationService _notification;

  HabitDetailController(this.ref, this._repo, this._notification);

  Future<void> fromHabit(Habit habit) async {
    updateHabitName(habit.name);
    updateHabitCategory(habit.category);
    updateHabitDate(habit.startDate.toLocal());
    updateHabitTime(TimeOfDay.fromDateTime(habit.startDate.toLocal()));
    updateTrackingType(habit.trackingType);
    updateHabitUnit(habit.unit ?? '');
    final habitSeries =
        await _repo.habitSeries.getHabitSeries(habit.habitSeriesId);
    if (habitSeries != null) {
      updateHabitRepeatFrequency(habitSeries.repeatFrequency);
    }

    if (habit.trackingType == TrackingType.progress) {
      updateHabitCurrentValue(habit.currentValue ?? 0);
      updateHabitTargetValue(habit.targetValue ?? 0);
      updateHabitUnit(habit.unit ?? '');
    } else {
      updateHabitIsCompleted(habit.isCompleted ?? false);
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

  void updateHabitIsCompleted(bool value) {
    ref.read(habitIsCompletedProvider.notifier).state = value;
  }

  void updateHabitCurrentValue(int value) {
    ref.read(habitCurrentValueProvider.notifier).state = value;
  }

  void updateHabitTargetValue(int value) {
    ref.read(habitTargetValueProvider.notifier).state = value;
  }

  void updateHabitUnit(String unit) {
    ref.read(habitUnitProvider.notifier).state = unit;
  }

  Future<void> updateHabitReminder(bool reminder) async {
    if (reminder) {
      await _notification.requestPermission();
    }
    ref.read(habitReminderProvider.notifier).state = reminder;
  }

  Future<Habit?> createHabit() async {
    HabitSeries? habitSeries;
    return await _repo.transaction(() async {
      // 1. Build habit from form
      Habit? habitModel = await _buildHabitFromForm();
      if (habitModel == null) return null;

      // 2. Build optional series
      habitSeries = _buildHabitSeries(habitModel);

      if (habitSeries != null) {
        await _repo.habitSeries.createHabitSeries(habitSeries!);
        habitModel =
            habitModel.rebuild((b) => b..habitSeriesId = habitSeries!.id);
      }

      // 3. Create habit
      await _repo.habit.createHabit(habitModel);
      return habitModel;
    }).then((habitModel) async {
      // 4. Handle reminder if enabled
      // Separate reminder handling from the transaction (as it may involve the OS and cannot be rolled back)
      if (habitModel?.reminderEnabled == true) {
        await _notification.scheduleRecurringReminders(habitModel!, habitSeries,
            excludedDatesUtc: await getExcludedDatesForSeries(habitSeries?.id));
      }

      return habitModel;
    });
  }

  Future<Habit?> updateHabit(
      Habit oldHabit, Future<ActionScope?> Function() pickScope) async {
    final oldSeries =
        await _repo.habitSeries.getHabitSeries(oldHabit.habitSeriesId);
    Habit? newHabit = await _buildHabitFromForm(habitId: oldHabit.id);
    if (newHabit == null) return null;

    final newSeries = _buildHabitSeries(newHabit, oldSeries: oldSeries);
    newHabit = newHabit.rebuild((b) => b..habitSeriesId = newSeries?.id);

    // If there is no old series → simply update or create a new series
    if (oldSeries == null) {
      final success = await _repo.transaction(() async {
        if (newSeries != null) {
          await _repo.habitSeries.createHabitSeries(newSeries);
        }
        await _repo.habit.updateHabit(newHabit!);
        return true;
      });

      if (success) {
        await _notification.cancelNotification(
            generateNotificationId(oldHabit.startDate, habitId: oldHabit.id));

        final needReschedule = newHabit.reminderEnabled == true &&
            (newHabit != oldHabit || newSeries != null);

        if (needReschedule) {
          await _notification.scheduleRecurringReminders(newHabit, newSeries,
              excludedDatesUtc: await getExcludedDatesForSeries(newSeries?.id));
        }
      }

      return newHabit;
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

  Future<Habit?> _handleThisAndFollowing(
    HabitSeries oldSeries,
    Habit newHabit,
    HabitSeries? newSeries,
  ) async {
    final habitDate = ref.read(habitDateProvider);
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

  Future<Habit?> _buildHabitFromForm({String? habitId}) async {
    final name = ref.read(habitNameProvider);
    final category = ref.read(habitCategoryProvider);
    final time = ref.read(habitTimeProvider);
    final date = ref
        .read(habitDateProvider)
        .toLocal()
        .copyWith(hour: time.hour, minute: time.minute);
    final trackingType = ref.read(habitTrackingTypeProvider);
    final targetValue = ref.read(habitTargetValueProvider);
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
      targetValue: trackingType == TrackingType.progress ? targetValue : null,
      unit: trackingType == TrackingType.progress ? unit : null,
      reminderEnabled: reminder,
    );

    return habitModel;
  }

  HabitSeries? _buildHabitSeries(Habit habitModel, {HabitSeries? oldSeries}) {
    final repeatFrequency = ref.read(habitRepeatFrequencyProvider);
    if (repeatFrequency == null) return null;

    return newHabitSeries(
      id: oldSeries?.repeatFrequency == repeatFrequency
          ? oldSeries?.id ?? habitModel.id
          : null,
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
    ref.read(habitTargetValueProvider.notifier).state = 0;
    ref.read(habitUnitProvider.notifier).state = '';
    ref.read(habitReminderProvider.notifier).state = false;
  }
}
