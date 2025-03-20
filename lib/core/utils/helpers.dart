import 'package:uuid/uuid.dart';

import '../../data/domain/models/habit.dart';
import '../../data/domain/models/habit_category.dart';

Habit newHabit({
  required String name,
  required HabitCategory category,
  DateTime? startDate,
  RepeatFrequency? repeatFrequency,
  bool reminderEnabled = false,
  TrackingType trackingType = TrackingType.complete,
  int? quantity,
  String? unit,
}) {
  return Habit((b) => b
    ..id = 'habit-${Uuid().v4()}'
    ..name = name
    ..category = category.toBuilder()
    ..startDate = startDate?.toUtc() ?? DateTime.now().toUtc()
    ..repeatFrequency = repeatFrequency
    ..reminderEnabled = reminderEnabled
    ..trackingType = trackingType
    ..quantity = quantity
    ..unit = unit
    ..progress = 0
    ..completed = false);
}

HabitCategory? getHabitCategoryById(String id) {
  try {
    return defaultCategories.firstWhere((category) => category.id == id);
  } catch (e) {
    return null;
  }
}

final List<HabitCategory> defaultCategories = [
  HabitCategory((b) => b
    ..id = "health"
    ..label = "Health"
    ..iconPath = "assets/icons/health.png"),
  HabitCategory((b) => b
    ..id = "work"
    ..label = "Work"
    ..iconPath = "assets/icons/work.png"),
  HabitCategory((b) => b
    ..id = "personal_growth"
    ..label = "Personal Growth"
    ..iconPath = "assets/icons/personal_growth.png"),
  HabitCategory((b) => b
    ..id = "hobby"
    ..label = "Hobby"
    ..iconPath = "assets/icons/hobby.png"),
  HabitCategory((b) => b
    ..id = "fitness"
    ..label = "Fitness"
    ..iconPath = "assets/icons/fitness.png"),
  HabitCategory((b) => b
    ..id = "education"
    ..label = "Education"
    ..iconPath = "assets/icons/education.png"),
  HabitCategory((b) => b
    ..id = "finance"
    ..label = "Finance"
    ..iconPath = "assets/icons/finance.png"),
  HabitCategory((b) => b
    ..id = "social"
    ..label = "Social"
    ..iconPath = "assets/icons/social.png"),
  HabitCategory((b) => b
    ..id = "spiritual"
    ..label = "Spiritual"
    ..iconPath = "assets/icons/spiritual.png"),
];
