import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/domain/models/habit.dart';
import '../../data/domain/models/scheduled_notification.dart';
import '../../features/habit_detail/presentation/habit_detail_screen.dart';
import '../../features/habit_detail/presentation/habit_view_screen.dart';
import '../../features/login/presentation/login_screen.dart';
import '../../features/main/presentation/main_screen.dart';
import '../../features/settings/presentation/terms_of_use_screen.dart';
import '../../features/settings/presentation/widgets/language_selection_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../constants/app_constants.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/', builder: (context, state) => MainScreen()),
      GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(
        path: '/habit-view',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;

          final habit = extra?['habit'] as Habit?;
          final scheduledNotification =
              extra?['scheduledNotification'] as ScheduledNotification?;

          if (habit == null && scheduledNotification == null) {
            return const Center(child: Text('No habit found'));
          }

          return HabitViewScreen(
              habit: habit, scheduledNotification: scheduledNotification);
        },
      ),
      GoRoute(
        path: '/habit-detail',
        builder: (context, state) {
          final habit = state.extra as Habit?;
          return HabitDetailScreen(habit: habit);
        },
      ),
      GoRoute(
        path: '/terms-of-use',
        builder: (context, state) => const TermsOfUseScreen(),
      ),
      GoRoute(
        path: '/language-selection',
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
    ],
  );
});
