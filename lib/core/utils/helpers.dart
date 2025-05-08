import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/domain/models/habit.dart';
import '../../data/domain/models/habit_category.dart';
import '../../data/domain/models/habit_series.dart';

String generateNewId(String prefix) => '$prefix-${Uuid().v4()}';

Habit newHabit({
  String? id,
  required String userId,
  required String name,
  required HabitCategory category,
  DateTime? startDate,
  String? habitSeriesId,
  bool reminderEnabled = false,
  TrackingType trackingType = TrackingType.complete,
  int? targetValue,
  String? unit,
}) {
  return Habit((b) => b
    ..id = id ?? generateNewId('habit')
    ..userId = userId
    ..name = name
    ..category = category.toBuilder()
    ..startDate = startDate?.toUtc() ?? DateTime.now().toUtc()
    ..habitSeriesId = habitSeriesId
    ..reminderEnabled = reminderEnabled
    ..trackingType = trackingType
    ..targetValue = targetValue
    ..unit = unit
    ..currentValue = 0
    ..isCompleted = false);
}

HabitSeries newHabitSeries({
  String? id,
  required String userId,
  required String habitId,
  DateTime? startDate,
  DateTime? untilDate,
  RepeatFrequency? repeatFrequency,
}) {
  return HabitSeries((b) => b
    ..id = id ?? generateNewId('series')
    ..userId = userId
    ..habitId = habitId
    ..startDate = startDate?.toUtc() ?? DateTime.now().toUtc()
    ..untilDate = untilDate?.toUtc()
    ..repeatFrequency = repeatFrequency);
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

// Generates recurring UTC dates for a habit
List<DateTime> generateRecurringDates(
  HabitSeries series, {
  DateTime? startDate,
  int daysAhead = 30,
  Set<DateTime>? excludedDatesUtc,
}) {
  final now = DateTime.now().toUtc();
  final untilDate = series.untilDate ?? now.add(Duration(days: daysAhead));
  List<DateTime> dates = [];

  DateTime current = startDate?.toUtc() ?? series.startDate;
  while (current.isBefore(untilDate)) {
    final normalized = DateTime.utc(current.year, current.month, current.day);
    final isSkipped = excludedDatesUtc?.contains(normalized) ?? false;

    if (!isSkipped) {
      dates.add(current);
    }

    switch (series.repeatFrequency) {
      case RepeatFrequency.daily:
        current = current.add(Duration(days: 1));
        break;
      case RepeatFrequency.weekly:
        current = current.add(Duration(days: 7));
        break;
      case RepeatFrequency.monthly:
        current = DateTime(current.year, current.month + 1, current.day);
        break;
      default:
        break;
    }
  }

  return dates.where((date) => date.isAfter(now)).toList();
}

Expression<bool> isSameDateQuery(
    GeneratedColumn<DateTime> date1, DateTime date2) {
  return date1.year.equals(date2.year) &
      date1.month.equals(date2.month) &
      date1.day.equals(date2.day);
}

String getRepeatFrequencyLabel(RepeatFrequency? frequency) {
  if (frequency == null) {
    return "No Repeat";
  }
  final label = frequency.toString().split('.').last;
  return label[0].toUpperCase() + label.substring(1);
}

// dt is utc
DateTime normalizeToUtcMinute(DateTime dt) =>
    DateTime.utc(dt.year, dt.month, dt.day, dt.hour, dt.minute);

int generateNotificationId(DateTime dateTime,
    {String? habitId, String? seriesId}) {
  final cleanDigits =
      (seriesId ?? habitId)?.replaceAll(RegExp(r'\D'), '') ?? '';
  final habitPart = int.tryParse(cleanDigits.substring(0, 6)) ?? 999999;
  final timePart =
      normalizeToUtcMinute(dateTime.toUtc()).millisecondsSinceEpoch % 1000000;

  final rawId = habitPart * 1000000 + timePart;
  return rawId % 2147483647; // Ensure 32-bit signed int
}
