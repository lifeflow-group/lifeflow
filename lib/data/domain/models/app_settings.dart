import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

import '../serializers.dart';

part 'app_settings.g.dart';

class WeekStartDay extends EnumClass {
  static const WeekStartDay monday = _$monday;
  static const WeekStartDay sunday = _$sunday;

  const WeekStartDay._(super.name);

  static BuiltSet<WeekStartDay> get values => _$weekStartDayValues;
  static WeekStartDay valueOf(String name) => _$weekStartDayValueOf(name);

  String get display {
    switch (this) {
      case monday:
        return 'Monday';
      case sunday:
        return 'Sunday';
      default:
        return name;
    }
  }

  String serialize() {
    return serializers.serializeWith(WeekStartDay.serializer, this) as String;
  }

  static WeekStartDay deserialize(String string) {
    return serializers.deserializeWith(WeekStartDay.serializer, string)
        as WeekStartDay;
  }

  static Serializer<WeekStartDay> get serializer => _$weekStartDaySerializer;
}

abstract class AppSettings implements Built<AppSettings, AppSettingsBuilder> {
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(AppSettingsBuilder b) => b
    ..weekStartDay = WeekStartDay.monday
    ..language = 'English';

  WeekStartDay get weekStartDay;
  String get language;

  // Add more settings as needed

  AppSettings._();
  factory AppSettings([void Function(AppSettingsBuilder) updates]) =
      _$AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(AppSettings.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(AppSettings.serializer, this)
          as Map<String, dynamic>;

  static Serializer<AppSettings> get serializer => _$appSettingsSerializer;
}
