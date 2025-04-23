import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/domain/models/habit.dart';
import '../../features/habit_detail/presentation/habit_detail_screen.dart';
import '../../features/habit_detail/presentation/habit_view_screen.dart';
import '../../features/login/presentation/login_screen.dart';
import '../../features/main/presentation/main_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/', builder: (context, state) => MainScreen()),
      GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(
        path: '/habit-view',
        builder: (context, state) {
          final habit = state.extra as Habit?;
          if (habit == null) {
            return const Center(child: Text('No habit found'));
          }
          return HabitViewScreen(habit: habit);
        },
      ),
      GoRoute(
        path: '/habit-detail',
        builder: (context, state) {
          final habit = state.extra as Habit?;
          return HabitDetailScreen(habit: habit);
        },
      ),
    ],
  );
});
