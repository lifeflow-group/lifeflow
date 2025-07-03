import 'package:built_collection/built_collection.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../domain/models/category.dart';
import '../domain/models/habit.dart';
import '../domain/models/habit_analysis.dart';
import '../domain/models/habit_plan.dart';
import '../domain/models/habit_series.dart';
import '../domain/models/personalization_context.dart';
import '../domain/models/suggestion.dart';
import '../domain/models/ai_suggestion_request_input.dart';
import '../datasources/local/app_database.dart';

/// Generates a new unique ID with the specified prefix
String generateNewId(String prefix) => '$prefix-${Uuid().v4()}';

Habit newHabit({
  String? id,
  required String userId,
  required String name,
  required Category category,
  DateTime? date,
  DateTime? startDate,
  DateTime? untilDate,
  RepeatFrequency? repeatFrequency,
  bool reminderEnabled = false,
  TrackingType trackingType = TrackingType.complete,
  int? targetValue,
  String? unit,
}) {
  // Generate habit ID first so it can be used in the series
  final habitId = id ?? generateNewId('habit');

  // Create a new series
  final habitSeries = repeatFrequency != null
      ? newHabitSeries(
          userId: userId,
          habitId: habitId,
          startDate: startDate?.toUtc() ?? DateTime.now().toUtc(),
          untilDate: untilDate?.toUtc(),
          repeatFrequency: repeatFrequency,
        )
      : null;

  return Habit((b) => b
    ..id = habitId
    ..userId = userId
    ..name = name
    ..category = category.toBuilder()
    ..date = date?.toUtc() ?? DateTime.now().toUtc()
    ..series = habitSeries?.toBuilder()
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

/// Creates a new HabitPlan with optional parameters
HabitPlan newHabitPlan({
  String? id,
  required String title,
  required Category category,
  required String description,
  required String imagePath,
  required List<Suggestion> suggestions,
}) {
  return HabitPlan((b) => b
    ..id = id ?? generateNewId('plan')
    ..title = title
    ..category = category.toBuilder()
    ..description = description
    ..imagePath = imagePath
    ..suggestions = ListBuilder<Suggestion>(suggestions));
}

/// Creates a new Suggestion with optional parameters
Suggestion newSuggestion({
  String? id,
  required String title,
  required String description,
  Habit? habit,
}) {
  return Suggestion((b) => b
    ..id = id ?? generateNewId('suggestion')
    ..title = title
    ..description = description
    ..habit = habit?.toBuilder());
}

/// Convert database HabitData to domain Habit model
Habit habitDataToHabit(HabitData habitData, String userId) {
  return Habit((b) => b
    ..id = habitData.id
    ..name = habitData.name
    ..userId = userId
    ..category = habitData.category.toBuilder()
    ..date = habitData.startDate
    ..series = HabitSeries((b) => b
      ..id = generateNewId('series')
      ..userId = userId
      ..habitId = habitData.id
      ..startDate = habitData.startDate.toUtc()
      ..repeatFrequency = habitData.repeatFrequency).toBuilder()
    ..reminderEnabled = habitData.reminderEnabled
    ..trackingType = habitData.trackingType
    ..targetValue = habitData.targetValue
    ..currentValue = 0
    ..unit = habitData.unit
    ..isCompleted = false);
}

/// Convert domain Habit model to HabitData for storage
HabitData habitToHabitData(Habit result) {
  return HabitData((b) => b
    ..id = result.id
    ..name = result.name
    ..category = result.category.toBuilder()
    ..trackingType = result.trackingType
    ..targetValue = result.targetValue
    ..unit = result.unit
    ..reminderEnabled = result.reminderEnabled
    ..repeatFrequency = result.series?.repeatFrequency
    ..startDate = result.date);
}

/// Override habit from exception (if there is an override)
HabitsTableData applyExceptionOverride(
    HabitsTableData habit, HabitExceptionsTableData exception) {
  return habit.copyWith(
    id: exception.id,
    reminderEnabled: exception.reminderEnabled,
    targetValue: Value(exception.targetValue ?? habit.targetValue),
    currentValue: Value(exception.currentValue ?? habit.currentValue),
    isCompleted: Value(exception.isCompleted ?? habit.isCompleted),
  );
}

AISuggestionRequestInput newAISuggestionRequestInput({
  String? id,
  String? userId,
  DateTime? createdAt,
  DataSourceType dataSourceType = DataSourceType.both,
  PersonalizationContext? personalizationContext,
  HabitAnalysis? habitAnalysis,
}) {
  return AISuggestionRequestInput((b) => b
    ..id = id ?? generateNewId('personalization')
    ..userId = userId
    ..createdAt = createdAt ?? DateTime.now().toUtc()
    ..dataSourceType = dataSourceType
    ..personalizationContext = personalizationContext?.toBuilder()
    ..habitAnalysis = habitAnalysis?.toBuilder());
}
