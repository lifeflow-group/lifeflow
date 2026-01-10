import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart' show BuildContext, ThemeMode;

import '../../../core/constants/app_languages.dart';
import '../../../src/generated/l10n/app_localizations.dart';
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

class ThemeModeSetting extends EnumClass {
  static const ThemeModeSetting light = _$light;
  static const ThemeModeSetting dark = _$dark;
  static const ThemeModeSetting system = _$system;

  const ThemeModeSetting._(super.name);

  static BuiltSet<ThemeModeSetting> get values => _$themeModeSettingValues;
  static ThemeModeSetting valueOf(String name) =>
      _$themeModeSettingValueOf(name);

  ThemeMode toThemeMode() {
    switch (this) {
      case light:
        return ThemeMode.light;
      case dark:
        return ThemeMode.dark;
      case system:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  String getLocalizedDisplay(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case light:
        return l10n.themeModeLight;
      case dark:
        return l10n.themeModeDark;
      case system:
        return l10n.themeModeSystem;
      default:
        return name;
    }
  }

  // Keeping the original display method for cases where BuildContext is not available
  String get display {
    switch (this) {
      case light:
        return 'Light';
      case dark:
        return 'Dark';
      case system:
        return 'System';
      default:
        return name;
    }
  }

  String serialize() {
    return serializers.serializeWith(ThemeModeSetting.serializer, this)
        as String;
  }

  static ThemeModeSetting deserialize(String string) {
    return serializers.deserializeWith(ThemeModeSetting.serializer, string)
        as ThemeModeSetting;
  }

  static Serializer<ThemeModeSetting> get serializer =>
      _$themeModeSettingSerializer;
}

abstract class AppSettings implements Built<AppSettings, AppSettingsBuilder> {
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(AppSettingsBuilder b) => b
    ..weekStartDay = WeekStartDay.monday
    ..language = AppLanguages.defaultLanguage.toBuilder()
    ..themeMode = ThemeModeSetting.system;

  WeekStartDay get weekStartDay;
  Language get language;
  ThemeModeSetting get themeMode;

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
