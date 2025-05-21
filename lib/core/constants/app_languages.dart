import 'package:flutter/material.dart';

import '../../data/domain/models/language.dart';

/// Class containing all supported languages in the app
class AppLanguages {
  /// List of all supported languages
  static final List<Language> supportedLanguages = [
    Language((b) => b
      ..languageCode = 'en'
      ..countryCode = 'US'
      ..languageName = 'English'),
    Language((b) => b
      ..languageCode = 'vi'
      ..countryCode = 'VN'
      ..languageName = 'Tiếng Việt'),
    Language((b) => b
      ..languageCode = 'es'
      ..countryCode = 'ES'
      ..languageName = 'Español'),
    Language((b) => b
      ..languageCode = 'fr'
      ..countryCode = 'FR'
      ..languageName = 'Français'),
    Language((b) => b
      ..languageCode = 'zh'
      ..countryCode = 'CN'
      ..languageName = '中文'),
    Language((b) => b
      ..languageCode = 'de'
      ..countryCode = 'DE'
      ..languageName = 'Deutsch'),
    Language((b) => b
      ..languageCode = 'ja'
      ..countryCode = 'JP'
      ..languageName = '日本語'),
    Language((b) => b
      ..languageCode = 'ru'
      ..countryCode = 'RU'
      ..languageName = 'Русский'),
    Language((b) => b
      ..languageCode = 'hi'
      ..countryCode = 'IN'
      ..languageName = 'हिन्दी'),
    Language((b) => b
      ..languageCode = 'ko'
      ..countryCode = 'KR'
      ..languageName = '한국어'),
  ];

  /// Default language used for initial app setup
  static Language get defaultLanguage => supportedLanguages.first;

  /// List of all supported locales
  static List<Locale> get supportedLocales =>
      supportedLanguages.map((lang) => lang.locale).toList();

  /// Find a language by its code with optional country and script codes
  static Language? findLanguageByCode(String code, {String? countryCode}) {
    try {
      if (countryCode != null) {
        // Search with exact country and script code match
        return supportedLanguages.firstWhere(
          (lang) =>
              lang.languageCode == code && (lang.countryCode == countryCode),
        );
      }
      // Search by language code only (returns first match)
      return supportedLanguages.firstWhere((lang) => lang.languageCode == code);
    } catch (e) {
      return null;
    }
  }

  /// Find a language by its name
  static Language? findLanguageByName(String name) {
    try {
      return supportedLanguages.firstWhere(
          (lang) => lang.languageName.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  /// Find a language's native name by its code
  static String? findNameByCode(String code) {
    final language = findLanguageByCode(code);
    return language?.languageName;
  }
}
