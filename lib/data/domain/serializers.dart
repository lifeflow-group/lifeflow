import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'flexible_datetime_serializer.dart';
import 'models/habit.dart';
import 'models/habit_analysis_input.dart';
import 'models/habit_category.dart';
import 'models/habit_exception.dart';
import 'models/habit_series.dart';
import 'models/suggestion.dart';

part 'serializers.g.dart';

@SerializersFor([
  Habit,
  HabitCategory,
  TrackingType,
  RepeatFrequency,
  Suggestion,
  HabitSeries,
  HabitException,
  HabitAnalysisInput,
  HabitData,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(FlexibleDateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
