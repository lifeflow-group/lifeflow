class ScheduledNotification {
  final int id;
  final String? habitId;
  final String? seriesId;
  final DateTime scheduledDate;

  ScheduledNotification({
    required this.id,
    this.habitId,
    this.seriesId,
    required this.scheduledDate,
  });

  @override
  String toString() {
    return 'ScheduledNotification(id: $id, habitId: $habitId, seriesId: $seriesId, scheduledDate: $scheduledDate)';
  }
}
