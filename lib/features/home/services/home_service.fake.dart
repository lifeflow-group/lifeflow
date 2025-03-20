import 'package:lifeflow/data/database/app_database.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import 'home_service.dart';

class FakeHomeService implements HomeService {
  final List<Habit> _habits = [
    Habit((b) => b
      ..id = 'habit0'
      ..name = 'Morning Run'
      ..category = defaultCategories[0].toBuilder()
      ..startDate = DateTime.now().toUtc()
      ..repeatFrequency = RepeatFrequency.daily
      ..reminderEnabled = true
      ..trackingType = TrackingType.complete),
    Habit((b) => b
      ..id = 'habit1'
      ..name = 'Read a Book'
      ..category = defaultCategories[2].toBuilder()
      ..startDate = DateTime.now().toUtc()
      ..repeatFrequency = RepeatFrequency.daily
      ..reminderEnabled = true
      ..progress = 2
      ..quantity = 10
      ..unit = 'pages'
      ..trackingType = TrackingType.progress),
    Habit((b) => b
      ..id = 'habit2'
      ..name = 'Meditation'
      ..category = defaultCategories[2].toBuilder()
      ..startDate = DateTime.now().toUtc()
      ..repeatFrequency = RepeatFrequency.daily
      ..reminderEnabled = true
      ..trackingType = TrackingType.complete),
    Habit((b) => b
      ..id = 'habit3'
      ..name = 'Drink Water'
      ..category = defaultCategories[0].toBuilder()
      ..startDate = DateTime.now().toUtc()
      ..repeatFrequency = RepeatFrequency.daily
      ..reminderEnabled = true
      ..progress = 5
      ..quantity = 10
      ..unit = 'glasses'
      ..trackingType = TrackingType.progress),
    Habit((b) => b
      ..id = 'habit4'
      ..name = 'Practice Coding'
      ..category = defaultCategories[1].toBuilder()
      ..startDate = DateTime.now().toUtc()
      ..repeatFrequency = RepeatFrequency.daily
      ..reminderEnabled = true
      ..trackingType = TrackingType.complete),
  ];

  @override
  Future<List<(HabitTableData, HabitCategoryTableData)>>
      getHabitsWithCategoriesByDate(DateTime date) {
    throw UnimplementedError();
  }

  @override
  Future<List<Habit>> getHabits() async {
    // Simulate delay to mimic network/database latency
    await Future.delayed(const Duration(milliseconds: 100));

    return _habits;
  }
}
