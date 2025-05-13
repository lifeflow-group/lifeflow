import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/controllers/notification_handler.dart';
import '../../../data/services/user_service.dart';

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
    final userService = ref.read(userServiceProvider);
    final userId = await userService.getCurrentUserId();
    final payload = NotificationHandler().consumeInitialPayload();

    // Delay 2s to show splash screen
    Timer(Duration(seconds: 2), () {
      if (userId == null) {
        context.go('/login');
      } else if (payload != null) {
        context.go('/habit-view', extra: {'scheduledNotification': payload});
      } else {
        context.go('/');
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
