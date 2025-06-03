import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/services/analytics_service.dart';
import '../../../data/services/user_service.dart';
import '../../settings/controllers/settings_controller.dart';

final obscureTextProvider = StateProvider<bool>((ref) => true);

// Provider containing functions to update data
final loginControllerProvider = Provider((ref) {
  return LoginController(ref);
});

class LoginController {
  LoginController(this.ref);
  final Ref ref;

  // Get analytics service
  AnalyticsService get _analyticsService => ref.read(analyticsServiceProvider);

  void toggleObscureText() {
    final current = ref.read(obscureTextProvider);
    ref.read(obscureTextProvider.notifier).state = !current;

    // Track password visibility toggle
    _analyticsService.trackPasswordVisibilityToggled(!current);
  }

  // Login as guest
  Future<String?> loginAsGuest() async {
    // Track guest login attempt
    _analyticsService.trackLoginAttempt('guest');

    try {
      final userService = ref.read(userServiceProvider);
      final userId = await userService.loginAsGuest();

      // Load user settings
      await ref
          .read(settingsControllerProvider.notifier)
          .loadUserSettings(userId);

      // Set analytics user properties and ID
      _analyticsService.setUserProperty('user_type', 'guest');
      _analyticsService.setUserId(userId);

      // Track successful guest login
      _analyticsService.trackLoginSuccess('guest', userId);

      return userId;
    } catch (e) {
      // Track login error
      _analyticsService.trackLoginError(
        'guest',
        e.runtimeType.toString(),
        e.toString(),
      );

      return null;
    }
  }
}
