import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart' show Locale;

import '../serializers.dart';

part 'language.g.dart';

abstract class Language implements Built<Language, LanguageBuilder> {
  /// The language code (ISO 639-1)
  String get languageCode;

  /// The country code (ISO 3166-1)
  String get countryCode;

  /// The name of the language in its native form
  String get languageName;

  /// The locale representing this language
  @memoized
  Locale get locale => Locale(languageCode, countryCode);

  /// The formatted locale code for date formatting (with country)
  @memoized
  String get dateFormatLocale => '${languageCode}_$countryCode';

  Language._();
  factory Language([void Function(LanguageBuilder) updates]) = _$Language;

  factory Language.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(Language.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(Language.serializer, this)
          as Map<String, dynamic>;

  static Serializer<Language> get serializer => _$languageSerializer;
}
