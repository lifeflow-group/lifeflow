// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Language> _$languageSerializer = _$LanguageSerializer();

class _$LanguageSerializer implements StructuredSerializer<Language> {
  @override
  final Iterable<Type> types = const [Language, _$Language];
  @override
  final String wireName = 'Language';

  @override
  Iterable<Object?> serialize(Serializers serializers, Language object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'languageCode',
      serializers.serialize(object.languageCode,
          specifiedType: const FullType(String)),
      'countryCode',
      serializers.serialize(object.countryCode,
          specifiedType: const FullType(String)),
      'languageName',
      serializers.serialize(object.languageName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Language deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = LanguageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'languageCode':
          result.languageCode = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'countryCode':
          result.countryCode = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'languageName':
          result.languageName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Language extends Language {
  @override
  final String languageCode;
  @override
  final String countryCode;
  @override
  final String languageName;
  Locale? __locale;
  String? __dateFormatLocale;

  factory _$Language([void Function(LanguageBuilder)? updates]) =>
      (LanguageBuilder()..update(updates))._build();

  _$Language._(
      {required this.languageCode,
      required this.countryCode,
      required this.languageName})
      : super._();
  @override
  Locale get locale => __locale ??= super.locale;

  @override
  String get dateFormatLocale => __dateFormatLocale ??= super.dateFormatLocale;

  @override
  Language rebuild(void Function(LanguageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguageBuilder toBuilder() => LanguageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Language &&
        languageCode == other.languageCode &&
        countryCode == other.countryCode &&
        languageName == other.languageName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, languageCode.hashCode);
    _$hash = $jc(_$hash, countryCode.hashCode);
    _$hash = $jc(_$hash, languageName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Language')
          ..add('languageCode', languageCode)
          ..add('countryCode', countryCode)
          ..add('languageName', languageName))
        .toString();
  }
}

class LanguageBuilder implements Builder<Language, LanguageBuilder> {
  _$Language? _$v;

  String? _languageCode;
  String? get languageCode => _$this._languageCode;
  set languageCode(String? languageCode) => _$this._languageCode = languageCode;

  String? _countryCode;
  String? get countryCode => _$this._countryCode;
  set countryCode(String? countryCode) => _$this._countryCode = countryCode;

  String? _languageName;
  String? get languageName => _$this._languageName;
  set languageName(String? languageName) => _$this._languageName = languageName;

  LanguageBuilder();

  LanguageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _languageCode = $v.languageCode;
      _countryCode = $v.countryCode;
      _languageName = $v.languageName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Language other) {
    _$v = other as _$Language;
  }

  @override
  void update(void Function(LanguageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Language build() => _build();

  _$Language _build() {
    final _$result = _$v ??
        _$Language._(
          languageCode: BuiltValueNullFieldError.checkNotNull(
              languageCode, r'Language', 'languageCode'),
          countryCode: BuiltValueNullFieldError.checkNotNull(
              countryCode, r'Language', 'countryCode'),
          languageName: BuiltValueNullFieldError.checkNotNull(
              languageName, r'Language', 'languageName'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
