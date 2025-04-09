import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserService {
  static const _userIdKey = 'user_id';

  // Returns the current userId if previously logged in
  Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<String> loginAsGuest() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = "user_${const Uuid().v4()}";
    await prefs.setString(_userIdKey, userId);
    debugPrint("New Guest User ID created: $userId");
    return userId;
  }

  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
  }
}
