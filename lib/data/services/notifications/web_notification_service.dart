import 'package:flutter/material.dart';

import '../../datasources/local/app_database.dart';
import '../../domain/models/habit.dart';
import '../../domain/models/habit_series.dart';
import '../../domain/models/scheduled_notification.dart';
import 'notification_service_interface.dart';

class WebNotificationService implements NotificationServiceInterface {
  // Use browser's notifications API in the future
  // For now, implement dummy methods that don't crash

  @override
  Future<void> initialize(
      Function(String? payload) onNotificationSelected) async {
    debugPrint('[Web] NotificationService initialized');
  }

  @override
  Future<void> requestPermission() async {
    debugPrint('[Web] Notification permissions requested');
    // In a real implementation, we would use:
    // Notification.requestPermission()
  }

  @override
  Future<void> scheduleNotification(
      int id, String title, String body, DateTime dateTime,
      {String? payload}) async {
    debugPrint('[Web] Would schedule notification: $title at $dateTime');
  }

  @override
  Future<void> scheduleRecurringReminders(Habit habit, HabitSeries? habitSeries,
      {Set<DateTime>? excludedDatesUtc}) async {
    debugPrint('[Web] Would schedule recurring reminder for ${habit.name}');
  }

  @override
  Future<void> cancelNotification(int id) async {
    debugPrint('[Web] Would cancel notification #$id');
  }

  @override
  Future<void> cancelAllNotifications() async {
    debugPrint('[Web] Would cancel all notifications');
  }

  @override
  Future<void> cancelNotificationsByHabitSeriesId(String seriesId) async {
    debugPrint('[Web] Would cancel notifications for series $seriesId');
  }

  @override
  Future<void> cancelFutureNotificationsByHabitSeriesId(
      String seriesId, DateTime startDate) async {
    debugPrint(
        '[Web] Would cancel future notifications for series $seriesId from $startDate');
  }

  @override
  Future<void> scheduleUpcomingNotifications(AppDatabase database) async {
    debugPrint('[Web] Would schedule upcoming notifications');
  }

  @override
  Future<List<ScheduledNotification>> getScheduledNotifications() async {
    debugPrint('[Web] Returning empty scheduled notifications list');
    return [];
  }

  @override
  String extractHabitIdFromPayload(String? payload) {
    return "";
  }
}
