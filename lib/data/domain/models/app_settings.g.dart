// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WeekStartDay _$monday = const WeekStartDay._('monday');
const WeekStartDay _$sunday = const WeekStartDay._('sunday');

WeekStartDay _$weekStartDayValueOf(String name) {
  switch (name) {
    case 'monday':
      return _$monday;
    case 'sunday':
      return _$sunday;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<WeekStartDay> _$weekStartDayValues =
    BuiltSet<WeekStartDay>(const <WeekStartDay>[
  _$monday,
  _$sunday,
]);

const ThemeModeSetting _$light = const ThemeModeSetting._('light');
const ThemeModeSetting _$dark = const ThemeModeSetting._('dark');
const ThemeModeSetting _$system = const ThemeModeSetting._('system');

ThemeModeSetting _$themeModeSettingValueOf(String name) {
  switch (name) {
    case 'light':
      return _$light;
    case 'dark':
      return _$dark;
    case 'system':
      return _$system;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ThemeModeSetting> _$themeModeSettingValues =
    BuiltSet<ThemeModeSetting>(const <ThemeModeSetting>[
  _$light,
  _$dark,
  _$system,
]);

Serializer<WeekStartDay> _$weekStartDaySerializer = _$WeekStartDaySerializer();
Serializer<ThemeModeSetting> _$themeModeSettingSerializer =
    _$ThemeModeSettingSerializer();
Serializer<AppSettings> _$appSettingsSerializer = _$AppSettingsSerializer();

class _$WeekStartDaySerializer implements PrimitiveSerializer<WeekStartDay> {
  @override
  final Iterable<Type> types = const <Type>[WeekStartDay];
  @override
  final String wireName = 'WeekStartDay';

  @override
  Object serialize(Serializers serializers, WeekStartDay object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  WeekStartDay deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WeekStartDay.valueOf(serialized as String);
}

class _$ThemeModeSettingSerializer
    implements PrimitiveSerializer<ThemeModeSetting> {
  @override
  final Iterable<Type> types = const <Type>[ThemeModeSetting];
  @override
  final String wireName = 'ThemeModeSetting';

  @override
  Object serialize(Serializers serializers, ThemeModeSetting object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ThemeModeSetting deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ThemeModeSetting.valueOf(serialized as String);
}

class _$AppSettingsSerializer implements StructuredSerializer<AppSettings> {
  @override
  final Iterable<Type> types = const [AppSettings, _$AppSettings];
  @override
  final String wireName = 'AppSettings';

  @override
  Iterable<Object?> serialize(Serializers serializers, AppSettings object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'weekStartDay',
      serializers.serialize(object.weekStartDay,
          specifiedType: const FullType(WeekStartDay)),
      'language',
      serializers.serialize(object.language,
          specifiedType: const FullType(Language)),
      'themeMode',
      serializers.serialize(object.themeMode,
          specifiedType: const FullType(ThemeModeSetting)),
    ];

    return result;
  }

  @override
  AppSettings deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = AppSettingsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'weekStartDay':
          result.weekStartDay = serializers.deserialize(value,
              specifiedType: const FullType(WeekStartDay))! as WeekStartDay;
          break;
        case 'language':
          result.language.replace(serializers.deserialize(value,
              specifiedType: const FullType(Language))! as Language);
          break;
        case 'themeMode':
          result.themeMode = serializers.deserialize(value,
                  specifiedType: const FullType(ThemeModeSetting))!
              as ThemeModeSetting;
          break;
      }
    }

    return result.build();
  }
}

class _$AppSettings extends AppSettings {
  @override
  final WeekStartDay weekStartDay;
  @override
  final Language language;
  @override
  final ThemeModeSetting themeMode;

  factory _$AppSettings([void Function(AppSettingsBuilder)? updates]) =>
      (AppSettingsBuilder()..update(updates))._build();

  _$AppSettings._(
      {required this.weekStartDay,
      required this.language,
      required this.themeMode})
      : super._();
  @override
  AppSettings rebuild(void Function(AppSettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppSettingsBuilder toBuilder() => AppSettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppSettings &&
        weekStartDay == other.weekStartDay &&
        language == other.language &&
        themeMode == other.themeMode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, weekStartDay.hashCode);
    _$hash = $jc(_$hash, language.hashCode);
    _$hash = $jc(_$hash, themeMode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppSettings')
          ..add('weekStartDay', weekStartDay)
          ..add('language', language)
          ..add('themeMode', themeMode))
        .toString();
  }
}

class AppSettingsBuilder implements Builder<AppSettings, AppSettingsBuilder> {
  _$AppSettings? _$v;

  WeekStartDay? _weekStartDay;
  WeekStartDay? get weekStartDay => _$this._weekStartDay;
  set weekStartDay(WeekStartDay? weekStartDay) =>
      _$this._weekStartDay = weekStartDay;

  LanguageBuilder? _language;
  LanguageBuilder get language => _$this._language ??= LanguageBuilder();
  set language(LanguageBuilder? language) => _$this._language = language;

  ThemeModeSetting? _themeMode;
  ThemeModeSetting? get themeMode => _$this._themeMode;
  set themeMode(ThemeModeSetting? themeMode) => _$this._themeMode = themeMode;

  AppSettingsBuilder() {
    AppSettings._setDefaults(this);
  }

  AppSettingsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _weekStartDay = $v.weekStartDay;
      _language = $v.language.toBuilder();
      _themeMode = $v.themeMode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppSettings other) {
    _$v = other as _$AppSettings;
  }

  @override
  void update(void Function(AppSettingsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppSettings build() => _build();

  _$AppSettings _build() {
    _$AppSettings _$result;
    try {
      _$result = _$v ??
          _$AppSettings._(
            weekStartDay: BuiltValueNullFieldError.checkNotNull(
                weekStartDay, r'AppSettings', 'weekStartDay'),
            language: language.build(),
            themeMode: BuiltValueNullFieldError.checkNotNull(
                themeMode, r'AppSettings', 'themeMode'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'language';
        language.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AppSettings', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
