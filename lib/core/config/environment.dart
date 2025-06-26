class Environment {
  /// Base URL for API endpoints
  static String get apiBaseUrl => String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://lfl-backend.onrender.com',
        // defaultValue: 'http://192.168.1.10:8000',
      );

  /// Checks if current environment is development
  static bool get isDevelopment => const bool.fromEnvironment(
        'DEVELOPMENT',
        defaultValue: false,
      );

  /// Checks if current environment is production
  static bool get isProduction => const bool.fromEnvironment(
        'PRODUCTION',
        defaultValue: false,
      );

  /// Checks if debugging should be enabled
  static bool get debugMode => const bool.fromEnvironment(
        'DEBUG_MODE',
        defaultValue: true,
      );

  /// Alias for debugMode (for backward compatibility)
  static bool get isDebug => debugMode;
}
