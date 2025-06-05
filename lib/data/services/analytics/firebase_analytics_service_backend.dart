import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'analytics_service_backend.dart';

final analyticsServiceBackendProvider =
    Provider<AnalyticsServiceBackend>((ref) {
  return FirebaseAnalyticsServiceBackend();
});

class FirebaseAnalyticsServiceBackend implements AnalyticsServiceBackend {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> logEvent(String name, Map<String, dynamic>? parameters) async {
    try {
      final sanitizedParams = _sanitizeParams(parameters);
      await _analytics.logEvent(name: name, parameters: sanitizedParams);
    } catch (e) {
      debugPrint('Analytics error (logEvent) for event "$name": $e');
    }
  }

  @override
  Future<void> logScreenView(String screenName) async {
    try {
      await _analytics.logScreenView(screenName: screenName);
    } catch (e) {
      debugPrint(
          'Analytics error (logScreenView) for screen "$screenName": $e');
    }
  }

  @override
  Future<void> setUserId(String? userId) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (e) {
      debugPrint('Analytics error (setUserId) for user "$userId": $e');
    }
  }

  @override
  Future<void> setUserProperty(String name, String? value) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (e) {
      debugPrint(
          'Analytics error (setUserProperty) for property "$name" with value "$value": $e');
    }
  }

  Map<String, Object> _sanitizeParams(Map<String, dynamic>? parameters) {
    if (parameters == null) return {};

    final result = <String, Object>{};

    parameters.forEach((key, value) {
      if (value == null) {
        result[key] = 'null';
      } else if (value is String || value is num) {
        result[key] = value;
      } else if (value is bool) {
        result[key] = value ? 'true' : 'false';
      } else {
        result[key] = value.toString();
      }
    });

    return result;
  }
}
