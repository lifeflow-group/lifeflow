import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/app_settings.dart';
import '../services/settings_service.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final settingsService = ref.watch(settingsServiceProvider);
  return SettingsRepository(settingsService);
});

class SettingsRepository {
  final SettingsService _settingsService;

  SettingsRepository(this._settingsService);

  Future<AppSettings> getUserSettings(String userId) async {
    final settingsJson = await _settingsService.getUserSettings(userId);
    if (settingsJson == null) {
      return AppSettings(); // Uses default values from initializeBuilder
    } else {
      final Map<String, dynamic> settingsMap = jsonDecode(settingsJson);
      return AppSettings.fromJson(settingsMap);
    }
  }

  Future<void> saveUserSettings(String userId, AppSettings settings) async {
    final settingsJson = jsonEncode(settings.toJson());
    await _settingsService.saveUserSettings(userId, settingsJson);
  }
}
