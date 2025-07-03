import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'flexible_datetime_serializer.dart';
import 'models/app_settings.dart';
import 'models/habit.dart';
import 'models/habit_analysis.dart';
import 'models/category.dart';
import 'models/habit_exception.dart';
import 'models/habit_plan.dart';
import 'models/habit_series.dart';
import 'models/language.dart';
import 'models/ai_suggestion_request_input.dart';
import 'models/personalization_context.dart';
import 'models/suggestion.dart';

part 'serializers.g.dart';

@SerializersFor([
  Habit,
  Category,
  TrackingType,
  RepeatFrequency,
  Suggestion,
  HabitSeries,
  HabitException,
  HabitAnalysis,
  HabitData,
  WeekStartDay,
  ThemeModeSetting,
  AppSettings,
  Language,
  HabitPlan,
  PersonalityType,
  TimePreference,
  GuidanceLevel,
  DataSourceType,
  PersonalizationContext,
  AISuggestionRequestInput,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(FlexibleDateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
