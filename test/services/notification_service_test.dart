import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifeflow/core/utils/helpers.dart';
import 'package:lifeflow/data/datasources/local/app_database.dart';
import 'package:lifeflow/data/datasources/local/dao/habit_dao.dart';
import 'package:lifeflow/data/datasources/local/dao/habit_series_dao.dart';
import 'package:lifeflow/data/domain/models/habit.dart';
import 'package:lifeflow/data/domain/models/habit_category.dart';
import 'package:lifeflow/data/services/notification_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MockNotificationService extends Mock implements NotificationService {}

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

class MockAndroidFlutterLocalNotificationsPlugin extends Mock
    implements AndroidFlutterLocalNotificationsPlugin {}

class MockIOSFlutterLocalNotificationsPlugin extends Mock
    implements IOSFlutterLocalNotificationsPlugin {}

class FakeTZDateTime extends Fake implements tz.TZDateTime {}

class FakeNotificationDetails extends Fake implements NotificationDetails {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockHabitDao extends Mock implements HabitDao {}

class MockHabitSeriesDao extends Mock implements HabitSeriesDao {}

void main() {
  late NotificationService service;
  late MockFlutterLocalNotificationsPlugin mockPlugin;

  setUpAll(() {
    tz.initializeTimeZones();
    registerFallbackValue(FakeTZDateTime());
    registerFallbackValue(FakeNotificationDetails());
    registerFallbackValue(UILocalNotificationDateInterpretation.absoluteTime);
    registerFallbackValue(AndroidScheduleMode.exact);
  });

  setUp(() {
    mockPlugin = MockFlutterLocalNotificationsPlugin();
    service = NotificationService(plugin: mockPlugin);
  });

  test('scheduleNotification calls zonedSchedule with correct arguments',
      () async {
    when(() => mockPlugin.zonedSchedule(
          any(),
          any(),
          any(),
          any(),
          any(),
          payload: any(named: 'payload'),
          uiLocalNotificationDateInterpretation:
              any(named: 'uiLocalNotificationDateInterpretation'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
        )).thenAnswer((_) async => {});

    final date = DateTime.now().add(Duration(hours: 1));

    await service.scheduleNotification(
      123,
      "Test Title",
      "Test Body",
      date,
      payload: jsonEncode({
        "habitId": "habit1",
        "seriesId": "series1",
        "scheduledDate": date.toIso8601String()
      }),
    );

    verify(() => mockPlugin.zonedSchedule(
          123,
          "Test Title",
          "Test Body",
          any(that: isA<tz.TZDateTime>()),
          any(that: isA<NotificationDetails>()),
          payload: any(named: 'payload'),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidScheduleMode: AndroidScheduleMode.exact,
        )).called(1);
  });

  test('cancelNotificationsByHabitSeriesId cancels correct notifications',
      () async {
    final mockDate = DateTime.now().add(Duration(days: 1));

    when(() => mockPlugin.pendingNotificationRequests()).thenAnswer(
      (_) async => [
        PendingNotificationRequest(
          101,
          "Reminder",
          "Body",
          jsonEncode({
            "habitId": "habit1",
            "seriesId": "series123",
            "scheduledDate": mockDate.toIso8601String(),
          }),
        ),
        PendingNotificationRequest(
          102,
          "Other Reminder",
          "Body",
          jsonEncode({
            "habitId": "habit2",
            "seriesId": "otherSeries",
            "scheduledDate": mockDate.toIso8601String(),
          }),
        ),
      ],
    );

    when(() => mockPlugin.cancel(101)).thenAnswer((_) async => {});
    when(() => mockPlugin.cancel(102)).thenAnswer((_) async => {});

    await service.cancelNotificationsByHabitSeriesId("series123");

    verify(() => mockPlugin.cancel(101)).called(1);
    verifyNever(() => mockPlugin.cancel(102));
  });

  test('getScheduledNotifications returns list of scheduled notifications',
      () async {
    final now = DateTime.now();

    final mockNotifications = [
      PendingNotificationRequest(
        1,
        'Reminder: Drink Water',
        'Don’t forget to hydrate!',
        jsonEncode({
          'seriesId': 'series123',
          'habitId': 'habitA',
          'scheduledDate': now.toIso8601String(),
        }),
      ),
      PendingNotificationRequest(
        2,
        'Reminder: Meditate',
        'Take a deep breath...',
        jsonEncode({
          'seriesId': 'series456',
          'habitId': 'habitB',
          'scheduledDate': now.add(Duration(hours: 1)).toIso8601String(),
        }),
      ),
    ];

    when(() => mockPlugin.pendingNotificationRequests())
        .thenAnswer((_) async => mockNotifications);

    final result = await service.getScheduledNotifications();

    expect(result.length, 2);
    expect(result[0].id, 1);
    expect(result[1].habitId, 'habitB');
  });

  test(
      'cancelFutureNotificationsByHabitSeriesId cancels only future notifications of given seriesId',
      () async {
    final now = DateTime.now();

    final notifications = [
      PendingNotificationRequest(
        1,
        'notif1',
        'body1',
        jsonEncode({
          'seriesId': 'series123',
          'scheduledDate':
              now.subtract(Duration(days: 1)).toUtc().toIso8601String()
        }),
      ),
      PendingNotificationRequest(
        2,
        'notif2',
        'body2',
        jsonEncode({
          'seriesId': 'series123',
          'scheduledDate': now.add(Duration(hours: 1)).toUtc().toIso8601String()
        }),
      ),
      PendingNotificationRequest(
        3,
        'notif3',
        'body3',
        jsonEncode({
          'seriesId': 'otherSeries',
          'scheduledDate': now.add(Duration(days: 2)).toUtc().toIso8601String()
        }),
      ),
    ];

    when(() => mockPlugin.pendingNotificationRequests())
        .thenAnswer((_) async => notifications);

    when(() => mockPlugin.cancel(any())).thenAnswer((_) async {});

    await service.cancelFutureNotificationsByHabitSeriesId('series123', now);

    verify(() => mockPlugin.cancel(2)).called(1); // should cancel
    verifyNever(() => mockPlugin.cancel(1)); // past notification, don't cancel
    verifyNever(() => mockPlugin.cancel(3)); // different seriesId
  });

  test(
      'scheduleRecurringReminders schedules notifications excluding skipped dates',
      () async {
    final habitSeriesId = generateNewId('series');
    final habitId = generateNewId('habit');
    final startDate = DateTime.now().toUtc();

    final habit = newHabit(
      id: habitId,
      userId: 'user-1',
      habitSeriesId: habitSeriesId,
      name: 'Drink Water',
      startDate: startDate,
      reminderEnabled: true,
      category: HabitCategory((p0) => p0
        ..id = 'category-1'
        ..label = 'Health'
        ..iconPath = 'assets/icons/health.png'),
    );

    final habitSeries = newHabitSeries(
      id: habitSeriesId,
      userId: 'user-1',
      habitId: habitId,
      startDate: startDate,
      repeatFrequency: RepeatFrequency.daily,
      untilDate: startDate.add(Duration(days: 9)),
    );

    final excludedDatesUtc = {
      startDate.add(Duration(days: 3)),
      startDate.add(Duration(days: 6))
    };

    when(() => mockPlugin.pendingNotificationRequests()).thenAnswer(
      (_) async => [
        PendingNotificationRequest(
          1,
          'Reminder',
          'Body',
          jsonEncode({
            'habitId': habitId,
            'seriesId': habitSeriesId,
            'scheduledDate': startDate.toIso8601String(),
          }),
        ),
      ],
    );

    when(() => mockPlugin.zonedSchedule(
          any(),
          any(),
          any(),
          any(),
          any(),
          payload: any(named: 'payload'),
          uiLocalNotificationDateInterpretation:
              any(named: 'uiLocalNotificationDateInterpretation'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
        )).thenAnswer((_) async => {});

    await service.scheduleRecurringReminders(habit, habitSeries,
        excludedDatesUtc: excludedDatesUtc);

    // Verify that scheduleNotification is called exactly 8 times
    verify(() => mockPlugin.zonedSchedule(
          any(),
          any(),
          any(),
          any(),
          any(),
          payload: any(named: 'payload'),
          uiLocalNotificationDateInterpretation:
              any(named: 'uiLocalNotificationDateInterpretation'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
        )).called(8);
  });

  test(
      'scheduleUpcomingNotifications schedules notifications up to limit and skips existing ones',
      () async {
    final habitId = generateNewId('habit');
    final seriesId = generateNewId('series');
    final userId = 'user-1';
    final now = DateTime.now().toUtc();
    final startDate = now.subtract(Duration(days: 490));

    final habit = HabitsTableData(
        id: habitId,
        userId: userId,
        habitSeriesId: seriesId,
        name: 'Morning Run',
        startDate: startDate,
        reminderEnabled: true,
        categoryId: 'category-1',
        trackingType: 'complete');

    final habitSeries = HabitSeriesTableData(
        id: seriesId,
        userId: userId,
        habitId: habitId,
        startDate: startDate,
        repeatFrequency: 'daily');

    // Mock DB and DAO
    final mockDatabase = MockAppDatabase();
    final mockHabitDao = MockHabitDao();
    final mockHabitSeriesDao = MockHabitSeriesDao();

    when(() => mockDatabase.habitDao).thenReturn(mockHabitDao);
    when(() => mockDatabase.habitSeriesDao).thenReturn(mockHabitSeriesDao);

    when(() => mockHabitDao.getAllRecurringHabits())
        .thenAnswer((_) async => [habit]);
    when(() => mockHabitSeriesDao.getHabitSeries(seriesId))
        .thenAnswer((_) async => habitSeries);

    // Mock existing notifications
    when(() => mockPlugin.pendingNotificationRequests())
        .thenAnswer((_) async => List.generate(
            490,
            (i) => PendingNotificationRequest(
                i + 1,
                "Habit Reminder: ${habit.name}",
                "Time to complete your habit!",
                jsonEncode(
                  {
                    'habitId': habitId,
                    'seriesId': seriesId,
                    'scheduledDate':
                        startDate.add(Duration(days: i)).toIso8601String()
                  },
                ))));

    // Mock zonedSchedule call
    when(() => mockPlugin.zonedSchedule(
          any(),
          any(),
          any(),
          any(),
          any(),
          payload: any(named: 'payload'),
          uiLocalNotificationDateInterpretation:
              any(named: 'uiLocalNotificationDateInterpretation'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
        )).thenAnswer((_) async => {});

    // Call the method
    await service.scheduleUpcomingNotifications(mockDatabase);

    // Should schedule up to 11 notifications, because 490 exist and limit is 500
    verify(() => mockPlugin.zonedSchedule(
          any(),
          any(),
          any(),
          any(),
          any(),
          payload: any(named: 'payload'),
          uiLocalNotificationDateInterpretation:
              any(named: 'uiLocalNotificationDateInterpretation'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
        )).called(11);
  });
}
