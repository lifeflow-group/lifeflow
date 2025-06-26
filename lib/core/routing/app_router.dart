import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/domain/models/habit.dart';
import '../../data/domain/models/category.dart';
import '../../data/domain/models/habit_plan.dart';
import '../../data/domain/models/scheduled_notification.dart';
import '../../data/services/analytics/analytics_service.dart';
import '../../features/habit_detail/presentation/habit_detail_screen.dart';
import '../../features/habit_detail/presentation/habit_view_screen.dart';
import '../../features/login/presentation/login_screen.dart';
import '../../features/main/presentation/main_screen.dart';
import '../../features/overview/presentation/screens/category_habit_analytics_screen.dart';
import '../../features/settings/presentation/terms_of_use_screen.dart';
import '../../features/settings/presentation/language_selection_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/suggestion/presentation/screens/applied_habits_summary_screen.dart';
import '../../features/suggestion/presentation/screens/habit_plan_detail_screen.dart';
import '../constants/app_constants.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        name: 'main',
        path: '/',
        builder: (context, state) => MainScreen(),
      ),
      GoRoute(
        name: 'splash',
        path: '/splash',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: 'habit-view',
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
        name: 'habit-detail',
        path: '/habit-detail',
        builder: (context, state) {
          if (state.extra is! Habit) return HabitDetailScreen();

          final habit = state.extra as Habit?;
          return HabitDetailScreen(habit: habit);
        },
      ),
      GoRoute(
        name: 'terms-of-use',
        path: '/terms-of-use',
        builder: (context, state) => const TermsOfUseScreen(),
      ),
      GoRoute(
        name: 'language-selection',
        path: '/language-selection',
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        name: 'category-habit-analytics',
        path: '/category-habit-analytics',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;

          final category = extra?['category'] as Category?;
          final month = extra?['month'] as DateTime?;

          if (category == null || month == null) {
            return const Center(child: Text('No category found'));
          }

          return CategoryHabitAnalyticsScreen(category: category, month: month);
        },
      ),
      GoRoute(
        name: 'applied-habits-summary',
        path: '/applied-habits-summary',
        builder: (context, state) {
          final habits =
              (state.extra as Map<String, dynamic>)['habits'] as List<Habit>;
          return AppliedHabitsSummaryScreen(appliedHabits: habits);
        },
      ),
      GoRoute(
        path: '/habit-plan-details',
        name: 'habit-plan-details',
        builder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final HabitPlan plan = extra['plan'] as HabitPlan;
          return HabitPlanDetailScreen(plan: plan);
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      // Optional: Handle redirects if needed
      return null;
    },
    onException: (BuildContext context, GoRouterState state, GoRouter router) {
      // Handle invalid routes
    },
    observers: [
      // Optional: Use a NavigatorObserver for additional tracking
      AnalyticsNavigatorObserver(ref),
    ],
    // Track route changes
    routerNeglect: false,
    debugLogDiagnostics: true,
  );
});

class AnalyticsNavigatorObserver extends NavigatorObserver {
  final Ref ref;
  Route<dynamic>? _previousRoute;

  AnalyticsNavigatorObserver(this.ref);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _previousRoute = previousRoute;
    _logScreenView(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      _previousRoute = route;
      _logScreenView(previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _previousRoute = oldRoute;
      _logScreenView(newRoute);
    }
  }

  void _logScreenView(Route<dynamic> route) {
    final screenName = route.settings.name;
    final routeName = _getRouteName(route);
    final analyticsService = ref.read(analyticsServiceProvider);

    if (screenName != null) {
      // Base event parameters - cast to Map<String, Object>
      Map<String, Object> eventParams = {};

      // Add extra context based on the route
      final Map<String, dynamic>? extraData =
          route.settings.arguments is Map<String, dynamic>
              ? route.settings.arguments as Map<String, dynamic>
              : null;

      // Add route-specific context
      if (routeName == 'habit-view') {
        _addHabitViewContext(route.settings.arguments, extraData, eventParams);
      } else if (routeName == 'habit-detail') {
        _addHabitDetailContext(
            route.settings.arguments, extraData, eventParams);
      } else if (routeName == 'category-habit-analytics') {
        _addCategoryAnalyticsContext(
            route.settings.arguments, extraData, eventParams);
      }

      // Log standard screen view
      analyticsService.logScreenView(screenName);

      // Log enhanced event with additional context
      analyticsService.trackScreenViewed(
          screenName,
          routeName,
          _previousRoute != null ? _getRouteName(_previousRoute!) : 'none',
          eventParams);

      // For specific screens, log custom events
      if (routeName == 'habit-view') {
        analyticsService.trackHabitViewScreenOpened(
            eventParams['habit_id']?.toString() ?? 'unknown',
            eventParams['source']?.toString() ?? 'unknown');
      }
    }
  }

  void _addHabitViewContext(dynamic arguments, Map<String, dynamic>? extraData,
      Map<String, Object> eventParams) {
    // Extract habit and notification info
    final Map<String, dynamic>? extra = extraData;
    final habit = extra?['habit'];
    final scheduledNotification = extra?['scheduledNotification'];

    // Determine source
    String source = 'unknown';
    String habitId = 'unknown';

    if (habit != null) {
      source = 'direct_habit';
      habitId = habit.id;
    } else if (scheduledNotification != null) {
      source = 'notification';
      habitId = scheduledNotification.habitId ?? 'unknown';
    }

    // Add to params
    eventParams['source'] = source;
    eventParams['habit_id'] = habitId;
  }

  void _addHabitDetailContext(dynamic arguments,
      Map<String, dynamic>? extraData, Map<String, Object> eventParams) {
    // Check if arguments is a Habit before casting
    if (arguments is Habit) {
      // If it's a Habit, process it normally
      eventParams['habit_id'] = arguments.id;
      eventParams['is_editing'] = true;
    } else {
      // If it's not a Habit, set default values
      eventParams['habit_id'] = 'new';
      eventParams['is_editing'] = false;
    }
  }

  void _addCategoryAnalyticsContext(dynamic arguments,
      Map<String, dynamic>? extraData, Map<String, Object> eventParams) {
    final Map<String, dynamic>? extra = extraData;
    final category = extra?['category'] as Category?;
    final month = extra?['month'] as DateTime?;

    if (category != null) {
      eventParams['category_id'] = category.id;
      eventParams['category_name'] = category.name;
    }

    if (month != null) {
      eventParams['month'] = '${month.year}-${month.month}';
    }
  }

  // Helper method to extract a more readable route name
  String _getRouteName(Route<dynamic> route) {
    // Extract name from route
    if (route.settings.name != null) {
      return route.settings.name!;
    }

    // Try to get a meaningful name from the route settings
    final routeSettings = route.settings;
    final name = routeSettings.name;
    if (name != null) return name;

    // Fall back to route type
    return route.runtimeType.toString();
  }
}
