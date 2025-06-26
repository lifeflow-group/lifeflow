import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeflow/core/utils/logger.dart';
import 'package:lifeflow/data/domain/models/habit.dart';
import 'package:lifeflow/data/factories/model_factories.dart';
import 'package:lifeflow/data/datasources/local/repositories/repositories.dart';
import 'package:lifeflow/data/services/user_service.dart';
import 'package:lifeflow/data/datasources/local/app_database.dart';
import 'package:lifeflow/data/datasources/local/database_provider.dart';
import 'package:lifeflow/features/habit_detail/controllers/habit_detail_controller.dart';
import 'package:lifeflow/features/habit_detail/repositories/habit_detail_repository.dart';
import 'package:lifeflow/data/controllers/habit_controller.dart';
import 'package:lifeflow/shared/widgets/scope_dialog.dart';
import 'package:mocktail/mocktail.dart';

import '../services/notification_service_test.dart';
import 'home_controller_test.dart';

final _testLogger = AppLogger('Test');

void main() {
  late AppDatabase db;
  late ProviderContainer container;
  late HabitController controller;
  late HabitDetailController detailController;
  late HabitDetailRepository repository;
  final mockNotification = MockMobileNotificationService();

  final habitDate = DateTime(2025, 4, 17);
  const testUserId = 'user-123';
  const categoryId = 'cat-1';
  final seriesId = generateNewId('series');
  final habitId = generateNewId('habit');
  final exceptionId = generateNewId('habit');

  setUp(() async {
    final inMemory = DatabaseConnection(NativeDatabase.memory());
    db = AppDatabase.forTesting(inMemory);

    container = ProviderContainer(overrides: [
      userServiceProvider.overrideWithValue(FakeUserService()),
      appDatabaseProvider.overrideWithValue(db),
      habitControllerProvider.overrideWith((ref) {
        final repo = ref.read(repositoriesProvider);
        return HabitController(ref, repo, mockNotification);
      }),
    ]);

    controller = container.read(habitControllerProvider);
    detailController = container.read(habitDetailControllerProvider);
    repository = container.read(habitDetailRepositoryProvider);

    await db.habitCategoriesTable.insertOne(
      HabitCategoriesTableCompanion.insert(
        id: categoryId,
        name: 'Study',
        iconPath: 'assets/icons/study.png',
        colorHex: '#FF5733',
      ),
    );

    await db.habitsTable.insertOne(
      HabitsTableCompanion.insert(
        id: habitId,
        name: 'Read Book',
        userId: testUserId,
        date: habitDate.toUtc(),
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
  });

  tearDown(() async {
    await db.close();
    container.dispose();
  });

  group('Update Habit', () {
    test(
        'updateHabit with ActionScope.onlyThis creates new habit, series and exception',
        () async {
      // Navigate to the habit detail screen
      final habit = await repository.habit.getHabitRecord(habitId);
      await detailController.fromHabit(habit!);

      // Change the habit name
      detailController.updateHabitName('Read Manga');

      when(() => mockNotification.cancelNotification(any()))
          .thenAnswer((_) async {});

      final result = await detailController.generateHabitFormResult(
          habit, () async => ActionScope.onlyThis);
      // Save the habit with ActionScope.onlyThis
      final updatedHabit = await controller.updateHabit(result!);

      final allHabits = await db.habitsTable.select().get();
      final allExceptions = await db.habitExceptionsTable.select().get();
      final allSeries = await db.habitSeriesTable.select().get();

      // Expect: A new habit should be created (total habits = 2)
      expect(allHabits.length, 2);
      // Expect: One new exception should be created (total exceptions = 2)
      expect(allExceptions.length, 2);
      // Expect: One new series should be created (total series = 2)
      expect(allSeries.length, 2);
      // Expect: The exception should mark the original habit instance as skipped
      expect(allExceptions[1].isSkipped, true);
      // Expect: The new series should be linked to the new habit instance
      expect(allSeries[1].habitId, updatedHabit!.id);
      // Expect: The new habit ID should match the updated habit ID
      expect(allHabits[1].id, updatedHabit.id);
      // Expect: The new habit name should be 'Read Manga'
      expect(allHabits[1].name, 'Read Manga');

      _testLogger.info('Test passed: updateHabit with ActionScope.onlyThis');
    });

    test('updateHabit with ActionScope.all updates series and original habit',
        () async {
      // Navigate to the habit detail screen
      final habit = await repository.habit.getHabitRecord(habitId);
      await detailController.fromHabit(habit!);

      // Change the habit name and repeat frequency
      detailController.updateHabitName('Read Manga');
      detailController.updateHabitRepeatFrequency(RepeatFrequency.weekly);

      when(() => mockNotification.cancelNotificationsByHabitSeriesId(any()))
          .thenAnswer((_) async {});

      final result = await detailController.generateHabitFormResult(
          habit, () async => ActionScope.all);
      // Act: Call updateHabit with ActionScope.all
      final updatedHabit = await controller.updateHabit(result!);

      // Assert: Fetch updated habit and its series from the database
      final updated = await repository.habit.getHabitRecord(habitId);
      final updatedSeries =
          await repository.habitSeries.getHabitSeries(seriesId);

      // Expect: The habit was updated in-place (no new habit created)
      expect(updatedHabit!.id, habitId);

      // Expect: The original habit name was updated
      expect(updated!.name, 'Read Manga');

      // Expect: The original series was updated in-place
      expect(updatedSeries!.repeatFrequency, RepeatFrequency.weekly);

      _testLogger.info('Test passed: updateHabit with ActionScope.all');
    });

    test(
        'updateHabit with ActionScope.thisAndFollowing creates trimmed old series and new series',
        () async {
      final selectDate = habitDate.add(Duration(days: 5));
      // Navigate to the habit detail screen (Habit in selectDate)
      Habit? habit = await repository.habit.getHabitRecord(habitId);
      habit = habit?.rebuild((p0) => p0..date = selectDate);
      await detailController.fromHabit(habit!);

      // Change the habit name
      detailController.updateHabitName('Read Manga');

      when(() => mockNotification.cancelFutureNotificationsByHabitSeriesId(
          any(), any())).thenAnswer((_) async {});

      final result = await detailController.generateHabitFormResult(
          habit, () async => ActionScope.thisAndFollowing);
      // Save the habit with ActionScope.thisAndFollowing
      final updateHabit = await controller.updateHabit(result!);

      final allHabits = await db.habitsTable.select().get();
      final allSeries = await db.habitSeriesTable.select().get();
      final allExceptions = await db.habitExceptionsTable.select().get();

      expect(allHabits.length, 2);
      expect(allSeries.length, 2);
      expect(allExceptions.length, 1);

      // Expect: The original habit instance should be updated
      expect(allHabits[0].id, habitId);
      expect(allSeries[0].untilDate!.toLocal(),
          selectDate.subtract(Duration(days: 1)));

      // Expect: A new habit should be created
      expect(allHabits[1].id, updateHabit!.id);
      expect(allHabits[1].name, 'Read Manga');
      expect(allSeries[1].startDate, selectDate);

      // Expect: Exception habit after the split date must have habitSeriesId as newSeries.Id
      expect(allExceptions.first.id, exceptionId);
      expect(allExceptions.first.habitSeriesId, allSeries[1].id);

      _testLogger
          .info('Test passed: updateHabit with ActionScope.thisAndFollowing');
    });
  });

  group('Delete Habit', () {
    test('deleteHabit (not in series) deletes habit directly', () async {
      final habitIdAlone = generateNewId('habit');
      // Insert habit not in a series
      await db.habitsTable.insertOne(
        HabitsTableCompanion.insert(
          id: habitIdAlone,
          name: 'Walk',
          userId: testUserId,
          date: habitDate.toUtc(),
          categoryId: categoryId,
          reminderEnabled: Value(false),
          trackingType: 'complete',
          habitSeriesId: const Value.absent(),
        ),
      );

      final habit = await repository.habit.getHabitRecord(habitIdAlone);
      when(() => mockNotification.cancelNotification(any()))
          .thenAnswer((_) async {});
      final result = await controller.deleteSingleHabit(habit!.id, habit.date);

      final habits = await db.habitsTable.select().get();
      expect(result, true);
      expect(habits.any((h) => h.id == habitIdAlone), false);

      _testLogger.info('Test passed: deleteHabit (not in series)');
    });

    test(
        'deleteHabit with ActionScope.onlyThis adds or updates skipped exception',
        () async {
      final habit = await repository.habit.getHabitRecord(habitId);
      final series =
          await repository.habitSeries.getHabitSeries(habit!.series!.id);
      final result = await controller.handleDeleteOnlyThis(habit, series!);

      final exceptions = await db.habitExceptionsTable.select().get();
      expect(result, true);
      expect(
        exceptions.any((e) => e.date.day == habitDate.day && e.isSkipped),
        true,
      );

      _testLogger.info('Test passed: deleteHabit with ActionScope.onlyThis');
    });

    test(
        'deleteHabit with ActionScope.all deletes habit, series, and exceptions',
        () async {
      final series = await repository.habitSeries.getHabitSeries(seriesId);
      when(() => mockNotification.cancelNotificationsByHabitSeriesId(any()))
          .thenAnswer((_) async {});
      final result = await controller.handleDeleteAll(series!);

      final habits = await db.habitsTable.select().get();
      final seriesList = await db.habitSeriesTable.select().get();
      final exceptions = await db.habitExceptionsTable.select().get();

      expect(result, true);
      expect(habits.any((h) => h.id == habitId), false);
      expect(seriesList.any((s) => s.id == seriesId), false);
      expect(exceptions.any((e) => e.habitSeriesId == seriesId), false);

      _testLogger.info('Test passed: deleteHabit with ActionScope.all');
    });

    test(
        'deleteHabit with ActionScope.thisAndFollowing trims series and deletes future exceptions',
        () async {
      final habit = await repository.habit.getHabitRecord(habitId);
      final series =
          await repository.habitSeries.getHabitSeries(habit!.series!.id);
      when(() => mockNotification.cancelFutureNotificationsByHabitSeriesId(
          any(), any())).thenAnswer((_) async {});
      final result =
          await controller.handleDeleteThisAndFollowing(habit, series!);

      final updatedSeries =
          await db.habitSeriesTable.select().getSingleOrNull();
      final futureExceptions = await db.habitExceptionsTable.select().get();

      expect(result, true);
      expect(updatedSeries?.untilDate?.isBefore(habitDate), true);
      expect(
        futureExceptions.any((e) => e.date.isAfter(habitDate)),
        false,
      );

      _testLogger
          .info('Test passed: deleteHabit with ActionScope.thisAndFollowing');
    });
  });

  group('Record Habit', () {
    test('recordHabit updates a non-series habit', () async {
      final habitId = generateNewId('habit');

      // Insert a non-series habit
      await db.habitsTable.insertOne(
        HabitsTableCompanion.insert(
          id: habitId,
          name: 'Drink Water',
          userId: testUserId,
          date: habitDate.toUtc(),
          categoryId: categoryId,
          reminderEnabled: Value(true),
          trackingType: 'complete',
          habitSeriesId: const Value.absent(),
        ),
      );

      final habit = await repository.habit.getHabitRecord(habitId);
      expect(habit, isNotNull);

      when(() => mockNotification.cancelNotification(any()))
          .thenAnswer((_) async {});

      await controller.recordHabit(
          habit: habit!, currentValue: null, isCompleted: true);

      final updatedHabit = await repository.habit.getHabitRecord(habitId);
      expect(updatedHabit!.isCompleted, true);

      _testLogger.info('Test passed: recordHabit updates a non-series habit');
    });
    test('recordHabit inserts a new HabitException for series habit', () async {
      final habit = await repository.habit.getHabitRecord(habitId);
      expect(habit, isNotNull);

      final recordDate = habitDate.add(const Duration(days: 5));

      await controller.recordHabit(
        habit: habit!.rebuild((p0) => p0.date = recordDate),
        currentValue: 3,
        isCompleted: true,
      );

      final exception = await repository.habitException
          .getHabitExceptionByIdAndDate(seriesId, recordDate);

      expect(exception, isNotNull);
      expect(exception!.currentValue, 3);
      expect(exception.isCompleted, true);

      _testLogger.info('Test passed: recordHabit inserts a new HabitException');
    });
    test('recordHabit updates existing HabitException', () async {
      final habit = await repository.habit.getHabitRecord(habitId);
      expect(habit, isNotNull);

      final exceptionDate =
          habitDate.add(const Duration(days: 10)); // inserted from setUp

      await controller.recordHabit(
        habit: habit!.rebuild((p0) => p0.id = exceptionId),
        currentValue: null,
        isCompleted: true,
      );

      final updatedException = await repository.habitException
          .getHabitExceptionByIdAndDate(seriesId, exceptionDate);

      expect(updatedException, isNotNull);
      expect(updatedException!.isCompleted, true);

      _testLogger
          .info('Test passed: recordHabit updates existing HabitException');
    });
  });
}
