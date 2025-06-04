import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/controllers/settings_controller.dart';

final themeModeProvider = Provider<ThemeMode>((ref) {
  final settingsState = ref.watch(settingsControllerProvider);

  // Convert ThemeModeSetting to ThemeMode
  return settingsState.when(
    data: (settings) => settings.themeMode.toThemeMode(),
    loading: () => ThemeMode.light, // Default while loading
    error: (_, __) => ThemeMode.light, // Default on error
  );
});
