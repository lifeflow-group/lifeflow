abstract class AnalyticsServiceBackend {
  Future<void> logEvent(String name, Map<String, Object>? parameters);
  Future<void> logScreenView(String screenName);
  Future<void> setUserId(String? userId);
  Future<void> setUserProperty(String name, String? value);
}