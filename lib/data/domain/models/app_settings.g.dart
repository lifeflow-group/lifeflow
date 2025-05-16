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
      throw new ArgumentError(name);
  }
}

final BuiltSet<WeekStartDay> _$weekStartDayValues =
    new BuiltSet<WeekStartDay>(const <WeekStartDay>[
  _$monday,
  _$sunday,
]);

Serializer<WeekStartDay> _$weekStartDaySerializer =
    new _$WeekStartDaySerializer();
Serializer<AppSettings> _$appSettingsSerializer = new _$AppSettingsSerializer();

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
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  AppSettings deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppSettingsBuilder();

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
          result.language = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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
  final String language;

  factory _$AppSettings([void Function(AppSettingsBuilder)? updates]) =>
      (new AppSettingsBuilder()..update(updates))._build();

  _$AppSettings._({required this.weekStartDay, required this.language})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        weekStartDay, r'AppSettings', 'weekStartDay');
    BuiltValueNullFieldError.checkNotNull(language, r'AppSettings', 'language');
  }

  @override
  AppSettings rebuild(void Function(AppSettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppSettingsBuilder toBuilder() => new AppSettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppSettings &&
        weekStartDay == other.weekStartDay &&
        language == other.language;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, weekStartDay.hashCode);
    _$hash = $jc(_$hash, language.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppSettings')
          ..add('weekStartDay', weekStartDay)
          ..add('language', language))
        .toString();
  }
}

class AppSettingsBuilder implements Builder<AppSettings, AppSettingsBuilder> {
  _$AppSettings? _$v;

  WeekStartDay? _weekStartDay;
  WeekStartDay? get weekStartDay => _$this._weekStartDay;
  set weekStartDay(WeekStartDay? weekStartDay) =>
      _$this._weekStartDay = weekStartDay;

  String? _language;
  String? get language => _$this._language;
  set language(String? language) => _$this._language = language;

  AppSettingsBuilder() {
    AppSettings._setDefaults(this);
  }

  AppSettingsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _weekStartDay = $v.weekStartDay;
      _language = $v.language;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppSettings other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppSettings;
  }

  @override
  void update(void Function(AppSettingsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppSettings build() => _build();

  _$AppSettings _build() {
    final _$result = _$v ??
        new _$AppSettings._(
          weekStartDay: BuiltValueNullFieldError.checkNotNull(
              weekStartDay, r'AppSettings', 'weekStartDay'),
          language: BuiltValueNullFieldError.checkNotNull(
              language, r'AppSettings', 'language'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
