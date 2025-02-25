import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/models/habit.dart';

final habitsProvider = StateProvider<List<Habit>>((ref) => [
      Habit((b) => b
        ..id = 'habit0'
        ..name = 'Morning Run'
        ..category = 'Fitness'
        ..startDate = DateTime.now()
        ..repeatFrequency = RepeatFrequency.daily
        ..reminderEnabled = true
        ..trackingType = TrackingType.complete),
      Habit((b) => b
        ..id = 'habit1'
        ..name = 'Read Book'
        ..category = 'Education'
        ..startDate = DateTime.now().subtract(Duration(days: 1))
        ..repeatFrequency = RepeatFrequency.daily
        ..reminderEnabled = false
        ..trackingType = TrackingType.progress
        ..quantity = 10
        ..unit = 'pages'),
      Habit((b) => b
        ..id = 'habit2'
        ..name = 'Drink Water'
        ..category = 'Health'
        ..startDate = DateTime.now()
        ..repeatFrequency = RepeatFrequency.daily
        ..reminderEnabled = true
        ..trackingType = TrackingType.progress
        ..quantity = 8
        ..unit = 'cups'),
      Habit((b) => b
        ..id = 'habit3'
        ..name = 'Meditate'
        ..category = 'Mindfulness'
        ..startDate = DateTime.now().add(Duration(days: 2))
        ..repeatFrequency = RepeatFrequency.daily
        ..reminderEnabled = true
        ..trackingType = TrackingType.complete),
      Habit((b) => b
        ..id = 'habit4'
        ..name = 'Stretching'
        ..category = 'Fitness'
        ..startDate = DateTime.now().add(Duration(days: 3))
        ..repeatFrequency = RepeatFrequency.daily
        ..reminderEnabled = false
        ..trackingType = TrackingType.complete),
    ]);

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final filteredHabitsProvider = Provider<List<Habit>>((ref) {
  final selectedDate = ref.watch(selectedDateProvider);
  final habits = ref.watch(habitsProvider);

  return habits.where((habit) {
    if (habit.repeatFrequency == RepeatFrequency.daily) {
      return true;
    }
    return DateFormat('yyyy-MM-dd').format(habit.startDate) ==
        DateFormat('yyyy-MM-dd').format(selectedDate);
  }).toList();
});
