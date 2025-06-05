import '../../datasources/local/app_database.dart';
import '../../domain/models/habit.dart';
import '../../domain/models/habit_series.dart';
import '../../domain/models/scheduled_notification.dart';

abstract class NotificationServiceInterface {
  Future<void> initialize(Function(String? payload) onNotificationSelected);

  Future<void> requestPermission();

  Future<void> scheduleNotification(
      int id, String title, String body, DateTime dateTime,
      {String? payload});

  Future<void> scheduleRecurringReminders(Habit habit, HabitSeries? habitSeries,
      {Set<DateTime>? excludedDatesUtc});

  Future<void> cancelNotification(int id);

  Future<void> cancelAllNotifications();

  Future<void> cancelNotificationsByHabitSeriesId(String seriesId);

  Future<void> cancelFutureNotificationsByHabitSeriesId(
      String seriesId, DateTime startDate);

  Future<void> scheduleUpcomingNotifications(AppDatabase database);

  Future<List<ScheduledNotification>> getScheduledNotifications();

  String extractHabitIdFromPayload(String? payload);
}
