import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'models/habit.dart';

part 'serializers.g.dart';

@SerializersFor([
  Habit,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
