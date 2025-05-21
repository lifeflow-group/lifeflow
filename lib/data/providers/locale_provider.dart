import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_languages.dart';
import '../../features/settings/controllers/settings_controller.dart';

final localeProvider = StateProvider<Locale>((ref) {
  final settingsState = ref.watch(settingsControllerProvider);
  final language = settingsState.whenOrNull(
        data: (data) => data.language,
      ) ??
      AppLanguages.defaultLanguage;

  return Locale(language.languageCode, language.countryCode);
});
