import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_category.dart';
import '../../../data/domain/models/habit_series.dart';
import '../repositories/create_habit_repository.dart';
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
final createHabitControllerProvider = Provider((ref) {
  final repository = ref.read(createHabitRepositoryProvider);
  return CreateHabitController(ref, repository);
});

class CreateHabitController {
  final Ref ref;
  final CreateHabitRepository _repo;

  CreateHabitController(this.ref, this._repo);

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

  Future<Habit?> saveHabit() async {
    final name = ref.read(habitNameProvider);
    final category = ref.read(habitCategoryProvider);
    final time = ref.read(habitTimeProvider);
    final date = ref
        .read(habitDateProvider)
        .copyWith(hour: time.hour, minute: time.minute);
    final repeatFrequency = ref.read(habitRepeatFrequencyProvider);
    final trackingType = ref.read(habitTrackingTypeProvider);
    final quantity = ref.read(habitQuantityProvider);
    final unit = ref.read(habitUnitProvider);
    final reminder = ref.read(habitReminderProvider);

    if (name.isEmpty || category == null) return null;

    Habit habitModel = newHabit(
      name: name,
      category: category,
      startDate: date,
      trackingType: trackingType,
      targetValue: trackingType == TrackingType.progress ? quantity : null,
      unit: trackingType == TrackingType.progress ? unit : null,
      reminderEnabled: reminder,
    );

    HabitSeries? habitSeries;
    if (repeatFrequency != null) {
      habitSeries = newHabitSeries(
        habitId: habitModel.id,
        startDate: habitModel.startDate,
        repeatFrequency: repeatFrequency,
      );
      await _repo.saveHabitSeries(habitSeries);

      habitModel =
          habitModel.rebuild((p0) => p0.habitSeriesId = habitSeries!.id);
    }

    await _repo.saveHabit(habitModel);

    if (reminder) {
      await _scheduleRecurringReminders(habitModel, habitSeries);
    }

    // Reset form state after saving
    _resetForm();

    return habitModel;
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

  void _resetForm() {
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
