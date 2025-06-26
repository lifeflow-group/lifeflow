import '../../../core/utils/logger.dart';
import '../../datasources/local/app_database.dart';
import '../../domain/models/habit.dart';
import '../../domain/models/scheduled_notification.dart';
import 'notification_service_interface.dart';

class WebNotificationService implements NotificationServiceInterface {
  final AppLogger _logger = AppLogger('WebNotificationService');

  // Use browser's notifications API in the future
  // For now, implement dummy methods that don't crash

  @override
  Future<void> initialize(
      Function(String? payload) onNotificationSelected) async {
    _logger.info('NotificationService initialized');
  }

  @override
  Future<void> requestPermission() async {
    _logger.info('Notification permissions requested');
    // In a real implementation, we would use:
    // Notification.requestPermission()
  }

  @override
  Future<void> scheduleNotification(
      int id, String title, String body, DateTime dateTime,
      {String? payload}) async {
    _logger.info('Would schedule notification: $title at $dateTime');
  }

  @override
  Future<void> scheduleRecurringReminders(Habit habit,
      {Set<DateTime>? excludedDatesUtc}) async {
    _logger.info('Would schedule recurring reminder for ${habit.name}');
  }

  @override
  Future<void> cancelNotification(int id) async {
    _logger.info('Would cancel notification #$id');
  }

  @override
  Future<void> cancelAllNotifications() async {
    _logger.info('Would cancel all notifications');
  }

  @override
  Future<void> cancelNotificationsByHabitSeriesId(String seriesId) async {
    _logger.info('Would cancel notifications for series $seriesId');
  }

  @override
  Future<void> cancelFutureNotificationsByHabitSeriesId(
      String seriesId, DateTime startDate) async {
    _logger.info(
        'Would cancel future notifications for series $seriesId from $startDate');
  }

  @override
  Future<void> scheduleUpcomingNotifications(AppDatabase database) async {
    _logger.info('Would schedule upcoming notifications');
  }

  @override
  Future<List<ScheduledNotification>> getScheduledNotifications() async {
    _logger.info('Returning empty scheduled notifications list');
    return [];
  }

  @override
  String extractHabitIdFromPayload(String? payload) {
    return "";
  }
}
