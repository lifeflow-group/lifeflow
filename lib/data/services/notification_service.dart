import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../core/utils/helpers.dart';
import '../datasources/local/app_database.dart';
import '../domain/models/habit.dart';
import '../domain/models/habit_series.dart';
import '../domain/models/scheduled_notification.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  NotificationService({FlutterLocalNotificationsPlugin? plugin})
      : _notificationsPlugin = plugin ?? FlutterLocalNotificationsPlugin();

  /// **Initialize the notification system**
  Future<void> initialize(
      Function(String? payload) onNotificationSelected) async {
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

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        onNotificationSelected(response.payload);
      },
    );
  }

  /// **Request notification permissions**
  Future<void> requestPermission() async {
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
  Future<void> scheduleNotification(
      int id, String title, String body, DateTime dateTime,
      {String? payload}) async {
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
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  // Schedules reminders for recurring habits
  Future<void> scheduleRecurringReminders(Habit habit, HabitSeries? habitSeries,
      {Set<DateTime>? excludedDatesUtc}) async {
    if (habitSeries == null) {
      // One-time habit
      await scheduleNotification(
        generateNotificationId(habit.startDate, habitId: habit.id),
        "Habit: ${habit.name}",
        "Time to complete your habit!",
        habit.startDate.toLocal(),
        payload: jsonEncode({
          'habitId': habit.id,
          'scheduledDate': habit.startDate.toUtc().toIso8601String()
        }),
      );
      return;
    }

    // Get recurring dates for next 30 days
    final recurringDates = generateRecurringDates(habitSeries,
        daysAhead: 30, excludedDatesUtc: excludedDatesUtc);

    for (final date in recurringDates) {
      final notificationId =
          generateNotificationId(date, seriesId: habitSeries.id);

      await scheduleNotification(
        notificationId,
        "Habit: ${habit.name}",
        "Time to complete your habit!",
        date.toLocal(),
        payload: jsonEncode({
          'seriesId': habitSeries.id,
          'scheduledDate': date.toUtc().toIso8601String()
        }),
      );
    }

    debugPrint(
        '✅ Scheduled ${recurringDates.length} recurring reminders for "${habit.name}", seriesId: ${habitSeries.id}.');
  }

  /// **Cancel a notification by ID**
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
    debugPrint('Cancelled notification $id');
  }

  /// **Cancel all notifications**
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  /// Cancel all notifications linked to a specific habitSeriesId
  Future<void> cancelNotificationsByHabitSeriesId(String seriesId) async {
    final scheduledNotifications = await getScheduledNotifications();

    for (final notification in scheduledNotifications) {
      if (notification.seriesId == seriesId) {
        await cancelNotification(notification.id);
        debugPrint(
            'Cancelled notification ${notification.id} for habitSeries $seriesId');
      }
    }
  }

  Future<void> cancelFutureNotificationsByHabitSeriesId(
      String seriesId, DateTime startDate) async {
    // Retrieve all scheduled notifications
    final scheduledNotifications = await getScheduledNotifications();
    final dateLocal = startDate.toLocal();

    // Filter notifications based on seriesId and compare dates
    for (final notification in scheduledNotifications) {
      // Check if the notification belongs to the habitSeries and has a time after startDate
      final notificationDate = notification.scheduledDate.toLocal();
      if (notification.seriesId == seriesId &&
          (notificationDate.isAfter(dateLocal) ||
              (notificationDate.year == dateLocal.year &&
                  notificationDate.month == dateLocal.month &&
                  notificationDate.day == dateLocal.day))) {
        // Cancel the notification if it meets the conditions
        await cancelNotification(notification.id);
        debugPrint(
            'Cancelled notification ${notification.id} for habitSeries $seriesId');
      }
    }
  }

  Future<void> scheduleUpcomingNotifications(AppDatabase database) async {
    final now = DateTime.now();
    final habits = await database.habitDao.getAllRecurringHabits();

    // Use a Set for faster lookup
    final existingNotifications = await getScheduledNotifications();
    final existingDates =
        existingNotifications.map((n) => n.scheduledDate).toSet();
    int existingLength = existingNotifications.length;

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
          startDate: lastScheduled);

      for (final date in recurringDates) {
        // Skip if the notification already exists
        if (existingDates.contains(date)) continue;

        if (existingLength > 500) {
          debugPrint(
              "⚠️ Maximum notification limit reached ($existingLength/500)");
          return;
        } else {
          existingLength++;
        }

        debugPrint("Scheduling notification for habit ${habit.name} on $date");
        await scheduleNotification(
            generateNotificationId(date,
                habitId: habit.id, seriesId: series.id),
            "Habit Reminder: ${habit.name}",
            "Time to complete your habit!",
            date);
      }
    }
  }

  Future<List<ScheduledNotification>> getScheduledNotifications() async {
    final List<PendingNotificationRequest> pendingNotifications =
        await _notificationsPlugin.pendingNotificationRequests();

    return pendingNotifications.map((n) {
      final payloadData = _parseNotificationPayload(n.payload);

      return ScheduledNotification(
        id: n.id,
        habitId: payloadData['habitId'],
        seriesId: payloadData['seriesId'],
        scheduledDate: (DateTime.tryParse(payloadData['scheduledDate'] ?? '') ??
                DateTime.now())
            .toUtc(),
      );
    }).toList();
  }

  Map<String, String?> _parseNotificationPayload(String? payload) {
    if (payload == null || payload.trim().isEmpty) {
      debugPrint('Empty or null payload received.');
      return {};
    }

    try {
      final data = jsonDecode(payload);
      return {
        'habitId': data['habitId'],
        'seriesId': data['seriesId'],
        'scheduledDate': data['scheduledDate']
      };
    } catch (e) {
      debugPrint('Failed to parse payload: $e\nPayload: $payload');
      return {};
    }
  }

  /// Extract habitId from notification payload
  String extractHabitIdFromPayload(String? payload) {
    if (payload == null) return "";
    try {
      final data = jsonDecode(payload);
      return data['habitId'] ?? "";
    } catch (e) {
      return "";
    }
  }
}
