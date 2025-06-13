import 'package:drift/drift.dart'
    hide isNull, isNotNull; // Hide the conflicting names
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeflow/core/utils/helpers.dart';
import 'package:lifeflow/data/controllers/habit_controller.dart';
import 'package:lifeflow/data/domain/models/habit_category.dart';
import 'package:lifeflow/data/domain/models/scheduled_notification.dart';
import 'package:lifeflow/data/services/user_service.dart';
import 'package:lifeflow/data/datasources/local/app_database.dart';
import 'package:lifeflow/data/datasources/local/database_provider.dart';
import 'package:lifeflow/data/domain/models/habit.dart';
import 'package:lifeflow/features/habit_detail/controllers/habit_detail_controller.dart';
import 'package:lifeflow/features/habit_detail/repositories/habit_detail_repository.dart';
import 'package:lifeflow/shared/widgets/scope_dialog.dart';
import 'package:mocktail/mocktail.dart';

import '../services/notification_service_test.dart';
import 'home_controller_test.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;
  late HabitDetailController controller;
  late HabitDetailRepository repository;
  final mockNotification = MockMobileNotificationService();

  final habitDate = DateTime(2025, 4, 17);
  const testUserId = 'user-123';
  const categoryId = 'education';
  final seriesId = generateNewId('series');
  final habitId = generateNewId('habit');
  final exceptionId = generateNewId('habit');

  setUpAll(() {
    // Create a valid HabitCategory first
    final mockCategory = HabitCategory((b) => b
      ..id = 'mock-category-id'
      ..name = 'Mock Category'
      ..iconPath = 'assets/icons/mock.png'
      ..colorHex = '#FFFFFF');

    // Create a valid Habit with the required fields
    final mockHabit = Habit((b) => b
      ..id = 'mock-habit-id'
      ..name = 'Mock Habit'
      ..userId = 'mock-user-id'
      ..category = mockCategory.toBuilder()
      ..startDate = DateTime(2025, 1, 1)
      ..trackingType = TrackingType.complete
      ..isCompleted = false
      ..reminderEnabled = false
      ..currentValue = 0);

    // Register the valid habit as the fallback value
    registerFallbackValue(mockHabit);
  });

  setUp(() async {
    final inMemory = DatabaseConnection(NativeDatabase.memory());
    db = AppDatabase.forTesting(inMemory);

    container = ProviderContainer(overrides: [
      userServiceProvider.overrideWithValue(FakeUserService()),
      appDatabaseProvider.overrideWithValue(db),
      habitDetailControllerProvider.overrideWith((ref) {
        final repo = ref.read(habitDetailRepositoryProvider);
        final habitController = ref.read(habitControllerProvider);
        return HabitDetailController(
            ref, repo, mockNotification, habitController);
      }),
    ]);

    controller = container.read(habitDetailControllerProvider);
    repository = container.read(habitDetailRepositoryProvider);

    await db.habitCategoriesTable.insertOne(
      HabitCategoriesTableCompanion.insert(
        id: categoryId,
        name: 'Education',
        iconPath: 'assets/icons/education.png',
        colorHex: '#FF5733',
      ),
    );

    await db.habitsTable.insertOne(
      HabitsTableCompanion.insert(
        id: habitId,
        name: 'Read Book',
        userId: testUserId,
        startDate: habitDate.toUtc(),
        categoryId: categoryId,
        reminderEnabled: Value(false),
        trackingType: 'complete',
        habitSeriesId: Value(seriesId),
      ),
    );

    await db.habitSeriesTable.insertOne(
      HabitSeriesTableCompanion.insert(
        id: seriesId,
        habitId: habitId,
        userId: testUserId,
        startDate: habitDate.toUtc(),
        repeatFrequency: Value('daily'),
      ),
    );

    await db.habitExceptionsTable.insertOne(
      HabitExceptionsTableCompanion.insert(
        id: exceptionId,
        habitSeriesId: seriesId,
        date: habitDate.add(Duration(days: 10)).toUtc(),
        isSkipped: Value(true),
        reminderEnabled: Value(false),
        isCompleted: Value(true),
      ),
    );

    when(() => mockNotification.scheduleRecurringReminders(any(), any()))
        .thenAnswer((_) async {});

    when(() => mockNotification.requestPermission())
        .thenAnswer((_) async => true);
  });

  tearDown(() async {
    await db.close();
    container.dispose();
  });

  group('HabitDetailController - Form State Management', () {
    test('updateHabitName should update habitNameProvider state', () {
      // Act
      controller.updateHabitName('New Habit Name');

      // Assert
      expect(container.read(habitNameProvider), 'New Habit Name');
    });

    test('updateHabitCategory should update habitCategoryProvider state',
        () async {
      // Arrange
      final category = await repository.repos.category.getCategory(categoryId);

      // Act
      controller.updateHabitCategory(category);

      // Assert
      expect(container.read(habitCategoryProvider), category);
    });

    test('updateHabitDate should update habitDateProvider state', () {
      // Arrange
      final newDate = DateTime(2025, 6, 15);

      // Act
      controller.updateHabitDate(newDate);

      // Assert
      expect(container.read(habitDateProvider), newDate);
    });

    test('updateHabitTime should update habitTimeProvider state', () {
      // Arrange
      const newTime = TimeOfDay(hour: 14, minute: 30);

      // Act
      controller.updateHabitTime(newTime);

      // Assert
      expect(container.read(habitTimeProvider), newTime);
    });

    test(
        'updateHabitRepeatFrequency should update habitRepeatFrequencyProvider state',
        () {
      // Act
      controller.updateHabitRepeatFrequency(RepeatFrequency.weekly);

      // Assert
      expect(
          container.read(habitRepeatFrequencyProvider), RepeatFrequency.weekly);
    });

    test('updateTrackingType should update habitTrackingTypeProvider state',
        () {
      // Act
      controller.updateTrackingType(TrackingType.progress);

      // Assert
      expect(container.read(habitTrackingTypeProvider), TrackingType.progress);
    });

    test(
        'updateHabitReminder should update habitReminderProvider state and request permissions',
        () async {
      // Act
      await controller.updateHabitReminder(true);

      // Assert
      expect(container.read(habitReminderProvider), true);
      verify(() => mockNotification.requestPermission()).called(1);
    });

    test('resetForm should reset all form providers to default values', () {
      // Arrange - Set values
      controller.updateHabitName('Test Habit');
      controller.updateTrackingType(TrackingType.progress);
      controller.updateHabitTargetValue(10);

      // Act
      controller.resetForm();

      // Assert
      expect(container.read(habitNameProvider), '');
      expect(container.read(habitCategoryProvider), null);
      expect(container.read(habitTrackingTypeProvider), TrackingType.complete);
      expect(container.read(habitTargetValueProvider), 0);
      expect(container.read(habitReminderProvider), false);
    });
  });

  group('HabitDetailController - Loading Habit Data', () {
    test('fromHabit should populate all providers with habit data', () async {
      // Arrange
      final habit = await repository.habit.getHabit(habitId);

      // Act
      await controller.fromHabit(habit!);

      // Assert
      expect(container.read(habitNameProvider), 'Read Book');
      expect(container.read(habitCategoryProvider)!.id, categoryId);
      expect(
          container.read(habitRepeatFrequencyProvider), RepeatFrequency.daily);
      expect(container.read(habitTrackingTypeProvider), TrackingType.complete);
      expect(container.read(habitReminderProvider), false);
    });

    test('loadHabitFromNotification should load habit by habitId', () async {
      // Arrange
      final notification = ScheduledNotification(
        id: 1,
        scheduledDate: DateTime.now(),
        habitId: habitId,
      );

      // Act
      final result = await controller.loadHabitFromNotification(notification);

      // Assert
      expect(result, isNotNull); // Using Flutter's isNotNull matcher
      expect(result!.id, habitId);
      expect(container.read(habitNameProvider), 'Read Book');
    });

    test('loadHabitFromNotification should load habit by seriesId and date',
        () async {
      // Arrange
      final notification = ScheduledNotification(
        id: 1,
        scheduledDate: habitDate,
        seriesId: seriesId,
      );

      // Act
      final result = await controller.loadHabitFromNotification(notification);

      // Assert
      expect(result, isNotNull);
      expect(container.read(habitNameProvider), 'Read Book');
    });

    test(
        'loadHabitFromNotification should return null for invalid notification',
        () async {
      // Arrange
      final notification = ScheduledNotification(
        id: 1,
        scheduledDate: habitDate,
      );

      // Act
      final result = await controller.loadHabitFromNotification(notification);

      // Assert
      expect(result, isNull); // Using Flutter's isNull matcher
    });
  });

  group('HabitDetailController - Building Models', () {
    test('buildHabitFromForm should create a valid Habit from provider states',
        () async {
      // Arrange
      final category = await repository.repos.category.getCategory(categoryId);
      controller.updateHabitName('New Test Habit');
      controller.updateHabitCategory(category);
      controller.updateHabitDate(DateTime(2025, 5, 20));
      controller.updateHabitTime(TimeOfDay(hour: 9, minute: 0));
      controller.updateTrackingType(TrackingType.progress);
      controller.updateHabitTargetValue(5);
      controller.updateHabitUnit('glasses');
      controller.updateHabitRepeatFrequency(RepeatFrequency.weekly);

      // Act
      final result = await controller.buildHabitFromForm();

      // Assert
      expect(result, isNotNull);
      expect(result!.name, 'New Test Habit');
      expect(result.category.id, categoryId);
      expect(result.trackingType, TrackingType.progress);
      expect(result.targetValue, 5);
      expect(result.unit, 'glasses');
      expect(result.repeatFrequency, RepeatFrequency.weekly);
    });

    test(
        'buildHabitFromForm should return null when required fields are missing',
        () async {
      // Arrange - don't set name or category
      controller.resetForm();

      // Act
      final result = await controller.buildHabitFromForm();

      // Assert
      expect(result, isNull);
    });

    test('buildHabitSeries should create a valid HabitSeries from a habit',
        () async {
      // Arrange
      final category = await repository.repos.category.getCategory(categoryId);
      controller.updateHabitName('New Test Habit');
      controller.updateHabitCategory(category);
      controller.updateHabitRepeatFrequency(RepeatFrequency.daily);
      final habit = await controller.buildHabitFromForm();

      // Act
      final series = controller.buildHabitSeries(habit!);

      // Assert
      expect(series, isNotNull);
      expect(series!.habitId, habit.id);
      expect(series.repeatFrequency, RepeatFrequency.daily);
    });

    test('buildHabitSeries should return null when repeatFrequency is null',
        () async {
      // Arrange
      final category = await repository.repos.category.getCategory(categoryId);
      controller.updateHabitName('New Test Habit');
      controller.updateHabitCategory(category);
      controller.updateHabitRepeatFrequency(null); // No repeat frequency
      final habit = await controller.buildHabitFromForm();

      // Act
      final series = controller.buildHabitSeries(habit!);

      // Assert
      expect(series, isNull);
    });

    test('buildHabitSeries should reuse ID when frequency matches old series',
        () async {
      // Arrange
      final oldSeries = await repository.habitSeries.getHabitSeries(seriesId);
      Habit? habit = await repository.habit.getHabit(habitId);

      // Act - Create with same frequency (daily)
      await controller.fromHabit(habit!);
      habit = await controller.buildHabitFromForm();
      final newSeries =
          controller.buildHabitSeries(habit!, oldSeries: oldSeries);

      // Assert - Should keep the same ID
      expect(newSeries!.id, seriesId);
    });

    test(
        'generateHabitFormResult should create result with scope for existing habit',
        () async {
      // Arrange
      final oldHabit = await repository.habit.getHabit(habitId);
      await controller.fromHabit(oldHabit!);
      controller.updateHabitName('Modified Habit');

      bool pickScopeCalled = false;
      Future<ActionScope?> mockPickScope() async {
        pickScopeCalled = true;
        return ActionScope.all;
      }

      // Act
      final result =
          await controller.generateHabitFormResult(oldHabit, mockPickScope);

      // Assert
      expect(result, isNotNull);
      expect(result!.newHabit.name, 'Modified Habit');
      expect(result.oldHabit, oldHabit);
      expect(result.actionScope, ActionScope.all);
      expect(pickScopeCalled, true);
    });

    test('generateHabitFormResult should not require scope for new habit',
        () async {
      // Arrange
      final category = await repository.repos.category.getCategory(categoryId);
      controller.updateHabitName('Brand New Habit');
      controller.updateHabitCategory(category);

      bool pickScopeCalled = false;
      Future<ActionScope?> mockPickScope() async {
        pickScopeCalled = true;
        return ActionScope.all;
      }

      // Act
      final result =
          await controller.generateHabitFormResult(null, mockPickScope);

      // Assert
      expect(result, isNotNull);
      expect(result!.newHabit.name, 'Brand New Habit');
      expect(result.oldHabit, null);
      expect(pickScopeCalled, false); // Should not be called for new habits
    });

    test(
        'generateHabitFormResult should return null if buildHabitFromForm returns null',
        () async {
      // Arrange - Don't set name or category
      controller.resetForm();

      // Act
      final result = await controller.generateHabitFormResult(
          null, () async => ActionScope.all);

      // Assert
      expect(result, isNull);
    });

    test(
        'generateHabitFormResult should return null if user cancels scope selection',
        () async {
      // Arrange
      final oldHabit = await repository.habit.getHabit(habitId);
      await controller.fromHabit(oldHabit!);
      controller.updateHabitName('Modified Habit');

      // Act - Return null from scope picker to simulate cancellation
      final result =
          await controller.generateHabitFormResult(oldHabit, () async => null);

      // Assert
      expect(result, isNull);
    });
  });
}
