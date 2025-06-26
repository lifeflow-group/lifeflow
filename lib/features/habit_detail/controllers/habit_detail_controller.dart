import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/controllers/habit_controller.dart';
import '../../../data/domain/models/habit_series.dart';
import '../../../data/domain/models/scheduled_notification.dart';
import '../../../data/factories/model_factories.dart';
import '../../../data/services/user_service.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/category.dart';
import '../../../shared/widgets/scope_dialog.dart';
import '../repositories/habit_detail_repository.dart';
import '../../../data/services/notifications/mobile_notification_service.dart';

class HabitFormResult {
  const HabitFormResult({
    required this.newHabit,
    this.newSeries,
    this.oldHabit,
    this.oldSeries,
    this.actionScope,
  });

  final Habit newHabit;
  final HabitSeries? newSeries;
  final Habit? oldHabit;
  final HabitSeries? oldSeries;
  final ActionScope? actionScope;
}

// Provider for managing the habit name.
final habitNameProvider = StateProvider<String>((ref) => '');

// Provider for managing the habit category.
final habitCategoryProvider = StateProvider<Category?>((ref) => null);

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

final habitProvider = StateProvider<Habit?>((ref) => null);

// Provider containing functions to update data
final habitDetailControllerProvider = Provider<HabitDetailController>((ref) {
  final repo = ref.read(habitDetailRepositoryProvider);
  final habitController = ref.read(habitControllerProvider);
  return HabitDetailController(
      ref, repo, MobileNotificationService(), habitController);
});

class HabitDetailController {
  final Ref ref;
  final HabitDetailRepository _repo;
  final MobileNotificationService _notification;
  final HabitController habitController;

  HabitDetailController(
      this.ref, this._repo, this._notification, this.habitController);

  Future<Habit?> loadHabitFromNotification(
      ScheduledNotification? payload) async {
    if (payload == null) return null;

    Habit? habit;
    if (payload.habitId != null) {
      habit = await _repo.habit.getHabitRecord(payload.habitId!);
    } else if (payload.seriesId != null) {
      habit = await _repo.habit
          .getHabitBySeriesAndDate(payload.seriesId!, payload.scheduledDate);
    }
    if (habit == null) return null;

    fromHabit(habit);
    return habit;
  }

  Future<void> fromHabit(Habit habit) async {
    updateHabitProvider(habit);
    updateHabitName(habit.name);
    updateCategory(habit.category);
    updateHabitDate(habit.date.toLocal());
    updateHabitTime(TimeOfDay.fromDateTime(habit.date.toLocal()));
    updateTrackingType(habit.trackingType);
    updateHabitUnit(habit.unit ?? '');
    final habitSeries =
        await _repo.habitSeries.getHabitSeries(habit.series?.id);
    updateHabitRepeatFrequency(
        habitSeries?.repeatFrequency ?? habit.series?.repeatFrequency);

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

  void updateCategory(Category? category) {
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

  void updateHabitProvider(Habit habit) {
    ref.read(habitProvider.notifier).state = habit;
  }

  Future<Habit?> buildHabitFromForm({String? habitId}) async {
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
      date: date.toUtc(),
      trackingType: trackingType,
      targetValue: trackingType == TrackingType.progress ? targetValue : null,
      unit: trackingType == TrackingType.progress ? unit : null,
      reminderEnabled: reminder,
    );

    return habitModel;
  }

  HabitSeries? buildHabitSeries(Habit habitModel, {HabitSeries? oldSeries}) {
    final repeatFrequency = ref.read(habitRepeatFrequencyProvider);
    if (repeatFrequency == null && habitModel.series?.id == null) {
      return null;
    }

    return newHabitSeries(
      id: oldSeries?.repeatFrequency == repeatFrequency
          ? oldSeries?.id ?? habitModel.id
          : null,
      userId: habitModel.userId,
      habitId: habitModel.id,
      startDate: habitModel.date,
      repeatFrequency: repeatFrequency,
    );
  }

  Future<HabitFormResult?> generateHabitFormResult(
      Habit? oldHabit, Future<ActionScope?> Function() pickScope) async {
    Habit? newHabit = await buildHabitFromForm();
    HabitSeries? newSeries;
    HabitSeries? oldSeries;
    ActionScope? actionScope;

    if (newHabit != null) {
      oldSeries = await habitController.getHabitSeries(oldHabit?.series?.id);
      newSeries = buildHabitSeries(newHabit, oldSeries: oldSeries);
      newHabit = newHabit.rebuild((b) => b..series = newSeries?.toBuilder());

      if (oldSeries != null && newHabit != oldHabit) {
        actionScope = await pickScope();
        if (actionScope == null) return null;
      }
    }

    if (newHabit == null) {
      return null;
    } else {
      return HabitFormResult(
          newHabit: newHabit,
          newSeries: newSeries,
          oldHabit: oldHabit,
          oldSeries: oldSeries,
          actionScope: actionScope);
    }
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
