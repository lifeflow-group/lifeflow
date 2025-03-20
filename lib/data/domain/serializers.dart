import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'datetime_milliseconds_serializer.dart';
import 'models/habit.dart';
import 'models/habit_category.dart';
import 'models/performance_metric.dart';
import 'models/suggestion.dart';

part 'serializers.g.dart';

@SerializersFor([
  Habit,
  HabitCategory,
  TrackingType,
  RepeatFrequency,
  Suggestion,
  PerformanceMetric,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(MillisecondsSinceEpochDateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
