import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/database/app_database.dart';
import 'data/database/database_provider.dart';
import 'data/database/seed/database_seed.dart';
import 'features/habit_detail/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();
  await seedDatabase(database);
  await NotificationService.init();
  NotificationService.scheduleUpcomingNotifications(database);

  runApp(ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(database)],
    child: LifeFlowApp(),
  ));
}
