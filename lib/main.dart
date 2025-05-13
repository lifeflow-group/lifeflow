import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/controllers/notification_handler.dart';
import 'data/datasources/local/app_database.dart';
import 'data/datasources/local/database_provider.dart';
import 'data/datasources/local/seed/database_seed.dart';
import 'data/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  await seedDatabase(database);

  final notificationHandler = NotificationHandler();
  notificationHandler.handleAppLaunchFromNotification();
  final notificationService = NotificationService();
  await notificationService
      .initialize((payload) => notificationHandler.handlePayload(payload));
  notificationService.scheduleUpcomingNotifications(database);

  runApp(ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(database)],
    child: LifeFlowApp(),
  ));
}
