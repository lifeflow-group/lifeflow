import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesService>((ref) {
  return SharedPreferencesService();
});

class SharedPreferencesService {
  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async =>
      _prefs ??= await SharedPreferences.getInstance();

  Future<String?> getString(String key) async {
    final prefsInstance = await prefs;
    return prefsInstance.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    final prefsInstance = await prefs;
    return prefsInstance.setString(key, value);
  }
}
