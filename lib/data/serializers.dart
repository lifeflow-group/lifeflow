import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'models/habit.dart';
import 'models/habit_category.dart';

part 'serializers.g.dart';

@SerializersFor([
  Habit,
  HabitCategory,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
