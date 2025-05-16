import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/services/shared_preferences_service.dart';

final settingsServiceProvider = Provider<SettingsService>((ref) {
  final prefsService = ref.watch(sharedPreferencesServiceProvider);
  return SettingsService(prefsService);
});

class SettingsService {
  static const String _settingsKeyPrefix = 'app_settings_';
  final SharedPreferencesService _prefsService;

  SettingsService(this._prefsService);

  Future<String?> getUserSettings(String userId) async {
    final key = _settingsKeyPrefix + userId;
    final settingsJson = await _prefsService.getString(key);
    return settingsJson;
  }

  Future<void> saveUserSettings(String userId, String settingsJson) async {
    final key = _settingsKeyPrefix + userId;
    await _prefsService.setString(key, settingsJson);
  }
}
