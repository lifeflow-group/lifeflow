import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/controllers/notification_handler.dart';
import 'data/datasources/local/app_database.dart';
import 'data/datasources/local/database_provider.dart';
import 'data/datasources/local/seed/database_seed.dart';
import 'data/services/notifications/mobile_notification_service.dart';
import 'data/services/notifications/web_notification_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  await seedDatabase(database);

  final notificationService =
      kIsWeb ? WebNotificationService() : MobileNotificationService();
  final notificationHandler = NotificationHandler();
  notificationHandler.handleAppLaunchFromNotification();
  await notificationService
      .initialize((payload) => notificationHandler.handlePayload(payload));
  notificationService.scheduleUpcomingNotifications(database);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  runApp(ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(database)],
    child: LifeFlowApp(),
  ));
}
