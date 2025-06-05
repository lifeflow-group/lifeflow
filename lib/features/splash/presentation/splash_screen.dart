import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/controllers/notification_handler.dart';
import '../../../data/services/analytics/analytics_service.dart';
import '../../../data/services/user_service.dart';
import '../../settings/controllers/settings_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    final analyticsService = ref.read(analyticsServiceProvider);
    final startTime = DateTime.now().millisecondsSinceEpoch;

    // Track app initialization started
    analyticsService.trackAppInitializationStarted();

    final userService = ref.read(userServiceProvider);
    final userId = await userService.getCurrentUserId();
    final payload = NotificationHandler().consumeInitialPayload();

    // Track user authentication state
    analyticsService.trackUserAuthStateChecked(userId != null);

    // Track notification payload check
    analyticsService.trackNotificationPayloadChecked(payload != null);

    // Load user settings after getting userId
    if (userId != null) {
      // Track settings loading start
      analyticsService.trackUserSettingsLoadingStarted(userId);

      await ref
          .read(settingsControllerProvider.notifier)
          .loadUserSettings(userId);

      // Track settings loading complete
      analyticsService.trackUserSettingsLoaded(userId);
    }

    // Calculate initialization time
    final endTime = DateTime.now().millisecondsSinceEpoch;
    final initDuration = endTime - startTime;

    // Track initialization complete
    analyticsService.trackAppInitializationCompleted(initDuration);

    // Delay 2s to show splash screen
    Timer(Duration(seconds: 2), () {
      // Track navigation decision
      final String destination =
          userId == null ? 'login' : (payload != null ? 'habit-view' : 'main');

      analyticsService.trackInitialNavigation(
          destination, userId != null, payload != null);

      if (userId == null) {
        context.goNamed('login');
      } else if (payload != null) {
        context
            .goNamed('habit-view', extra: {'scheduledNotification': payload});
      } else {
        context.goNamed('main');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image.asset('assets/images/logo.png', width: 150),
      ),
    );
  }
}
