import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'shared_preferences_service.dart';

// This provider is used to access the UserService instance throughout the app.
final userServiceProvider = Provider((ref) {
  final prefsService = ref.watch(sharedPreferencesServiceProvider);
  return UserService(prefsService);
});

class UserService {
  static const _userIdKey = 'user_id';
  final SharedPreferencesService _prefsService;

  UserService(this._prefsService);

  // Returns the current userId if previously logged in
  Future<String?> getCurrentUserId() async {
    return await _prefsService.getString(_userIdKey);
  }

  Future<String> loginAsGuest() async {
    final userId = "user_${const Uuid().v4()}";
    await _prefsService.setString(_userIdKey, userId);
    debugPrint("New Guest User ID created: $userId");
    return userId;
  }

  Future<void> clearUserId() async {
    final prefs = await _prefsService.prefs;
    await prefs.remove(_userIdKey);
  }
}
