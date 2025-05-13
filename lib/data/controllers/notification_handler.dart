import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/helpers.dart';
import '../domain/models/scheduled_notification.dart';

class NotificationHandler {
  static final NotificationHandler _instance = NotificationHandler._internal();

  factory NotificationHandler() => _instance;

  NotificationHandler._internal();

  ScheduledNotification? initialPayload;

  void setInitialPayload(ScheduledNotification payload) {
    initialPayload = payload;
  }

  ScheduledNotification? consumeInitialPayload() {
    final payload = initialPayload;
    initialPayload = null;
    return payload;
  }

  Future<void> handleAppLaunchFromNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    final payload = notificationAppLaunchDetails?.notificationResponse?.payload;

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      if (payload != null) {
        final data = jsonDecode(payload);
        final scheduledNotification = ScheduledNotification(
          id: generateNotificationId(
            DateTime.parse(data['scheduledDate']),
            habitId: data['habitId'],
            seriesId: data['seriesId'],
          ),
          habitId: data['habitId'],
          seriesId: data['seriesId'],
          scheduledDate: DateTime.parse(data['scheduledDate']),
        );
        // Set the initial payload to be consumed later
        setInitialPayload(scheduledNotification);
      }
    }
  }

  Future<void> handlePayload(String? payload) async {
    if (payload != null) {
      final data = jsonDecode(payload);
      final scheduledNotification = ScheduledNotification(
        id: generateNotificationId(
          DateTime.parse(data['scheduledDate']),
          habitId: data['habitId'],
          seriesId: data['seriesId'],
        ),
        habitId: data['habitId'],
        seriesId: data['seriesId'],
        scheduledDate: DateTime.parse(data['scheduledDate']),
      );

      if (navigatorKey.currentContext != null) {
        final router = GoRouter.of(navigatorKey.currentContext!);
        router.push('/habit-view',
            extra: {'scheduledNotification': scheduledNotification});
      }
    }
  }
}
