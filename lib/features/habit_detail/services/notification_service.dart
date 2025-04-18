import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/database/app_database.dart';
import '../../../data/domain/models/habit_series.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// **Initialize the notification system**
  static Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notificationsPlugin.initialize(settings);
  }

  /// **Request notification permissions**
  static Future<void> requestPermission() async {
    try {
      // Request Android permissions
      final androidImplementation =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? androidGranted =
          await androidImplementation?.requestNotificationsPermission();

      debugPrint('Android notification permission granted: $androidGranted');

      // Request iOS permissions
      final iosImplementation =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();

      final bool? iosGranted = await iosImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

      debugPrint('iOS notification permission granted: $iosGranted');
    } catch (e) {
      debugPrint('Error requesting notification permissions: $e');
    }
  }

  /// **Schedule a notification**
  static Future<void> scheduleNotification(
      int id, String title, String body, DateTime dateTime) async {
    if (dateTime.isBefore(DateTime.now())) {
      debugPrint("⚠️ Error: Cannot schedule notification in the past.");
      return;
    }

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_channel_id',
          'Habit Reminders',
          channelDescription: 'Reminders to complete your habit',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  /// **Cancel a notification by ID**
  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  /// **Cancel all notifications**
  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  static Future<void> scheduleUpcomingNotifications(
      AppDatabase database) async {
    final now = DateTime.now();
    final habits = await database.habitDao.getAllRecurringHabits();

    // Get the list of existing notifications
    final pendingNotifications =
        await _notificationsPlugin.pendingNotificationRequests();
    if (pendingNotifications.length >= 500) {
      debugPrint(
          "⚠️ Maximum notification limit reached (${pendingNotifications.length}/500)");
      return;
    }

    // Use a Set for faster lookup
    final existingNotifications = await getScheduledNotifications();
    final existingDates =
        existingNotifications.map((n) => n.scheduledDate).toSet();

    for (final habit in habits) {
      final series =
          await database.habitSeriesDao.getHabitSeries(habit.habitSeriesId!);
      if (series == null) continue;

      // Find the last scheduled date
      DateTime lastScheduled = existingNotifications
          .where((n) => n.habitId == habit.id)
          .map((n) => n.scheduledDate)
          .fold(now, (prev, date) => date.isAfter(prev) ? date : prev);

      final recurringDates = generateRecurringDates(
          HabitSeries.fromJson(series.toJson()),
          startDate: lastScheduled,
          daysAhead: 7);

      for (final date in recurringDates) {
        // Skip if the notification already exists
        if (existingDates.contains(date)) {
          debugPrint(
              "⏩ Skipping duplicate notification for ${habit.name} at $date");
          continue;
        }

        await scheduleNotification(
          Uuid().v4().hashCode,
          "Habit Reminder: ${habit.name}",
          "Time to complete your habit!",
          date,
        );
      }
    }
  }

  static Future<List<ScheduledNotification>> getScheduledNotifications() async {
    final List<PendingNotificationRequest> pendingNotifications =
        await FlutterLocalNotificationsPlugin().pendingNotificationRequests();

    return pendingNotifications.map((n) {
      return ScheduledNotification(
        id: n.id,
        habitId: extractHabitIdFromPayload(n.payload),
        scheduledDate: DateTime.fromMillisecondsSinceEpoch(n.id),
      );
    }).toList();
  }

  /// Extract habitId from notification payload
  static String extractHabitIdFromPayload(String? payload) {
    if (payload == null) return "";
    try {
      final data = jsonDecode(payload);
      return data['habitId'] ?? "";
    } catch (e) {
      return "";
    }
  }
}

class ScheduledNotification {
  final int id;
  final String habitId;
  final DateTime scheduledDate;

  ScheduledNotification({
    required this.id,
    required this.habitId,
    required this.scheduledDate,
  });

  @override
  String toString() {
    return 'ScheduledNotification(id: $id, habitId: $habitId, scheduledDate: $scheduledDate)';
  }
}
