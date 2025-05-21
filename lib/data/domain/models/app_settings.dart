import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constants/app_languages.dart';
import '../serializers.dart';
import 'language.dart';

part 'app_settings.g.dart';

class WeekStartDay extends EnumClass {
  static const WeekStartDay monday = _$monday;
  static const WeekStartDay sunday = _$sunday;

  const WeekStartDay._(super.name);

  static BuiltSet<WeekStartDay> get values => _$weekStartDayValues;
  static WeekStartDay valueOf(String name) => _$weekStartDayValueOf(name);

  // This method is used to get the localized display name of the enum
  String getLocalizedDisplay(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (this) {
      case monday:
        return l10n.mondayLabel;
      case sunday:
        return l10n.sundayLabel;
      default:
        return name;
    }
  }

  // Keeping the original display method for cases where BuildContext is not available
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
    ..language = AppLanguages.defaultLanguage.toBuilder();

  WeekStartDay get weekStartDay;
  Language get language;

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
