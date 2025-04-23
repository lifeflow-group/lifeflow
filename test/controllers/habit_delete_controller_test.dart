import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeflow/core/providers/user_provider.dart';
import 'package:lifeflow/data/database/app_database.dart';
import 'package:lifeflow/data/database/database_provider.dart';
import 'package:lifeflow/features/habit_detail/repositories/habit_detail_repository.dart';
import 'package:lifeflow/features/home/controllers/habit_delete_controller.dart';

import 'home_controller_test.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;
  late HabitDeleteController controller;
  late HabitDetailRepository repository;

  final habitDate = DateTime(2025, 4, 17);
  const testUserId = 'user-123';
  const categoryId = 'cat-1';
  const seriesId = 'series-1';
  const habitId = 'habit-1';
  const exceptionId = 'habit-2';

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());

    container = ProviderContainer(overrides: [
      userServiceProvider.overrideWithValue(FakeUserService()),
      appDatabaseProvider.overrideWithValue(db),
    ]);

    controller = container.read(habitDeleteControllerProvider);
    repository = container.read(habitDetailRepositoryProvider);

    await db.habitCategoriesTable.insertOne(
      HabitCategoriesTableCompanion.insert(
        id: categoryId,
        label: 'Study',
        iconPath: 'assets/icons/study.png',
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
  });

  tearDown(() async {
    await db.close();
    container.dispose();
  });

  group('Delete Habit', () {
    test('deleteHabit (not in series) deletes habit directly', () async {
      // Insert habit not in a series
      await db.habitsTable.insertOne(
        HabitsTableCompanion.insert(
          id: 'habit-alone',
          name: 'Walk',
          userId: testUserId,
          startDate: habitDate.toUtc(),
          categoryId: categoryId,
          reminderEnabled: Value(false),
          trackingType: 'complete',
          habitSeriesId: const Value.absent(),
        ),
      );

      final habit = await repository.getHabit('habit-alone');
      final result = await controller.deleteSingleHabit(habit!.id);

      final habits = await db.habitsTable.select().get();
      expect(result, true);
      expect(habits.any((h) => h.id == 'habit-alone'), false);

      debugPrint('Passed!');
    });

    test(
        'deleteHabit with ActionScope.onlyThis adds or updates skipped exception',
        () async {
      final habit = await repository.getHabit(habitId);
      final series = await repository.getHabitSeries(habit!.habitSeriesId);
      final result = await controller.handleDeleteOnlyThis(habit, series!);

      final exceptions = await db.habitExceptionsTable.select().get();
      expect(result, true);
      expect(
        exceptions.any((e) => e.date.day == habitDate.day && e.isSkipped),
        true,
      );

      debugPrint('Passed!');
    });

    test(
        'deleteHabit with ActionScope.all deletes habit, series, and exceptions',
        () async {
      final series = await repository.getHabitSeries(seriesId);
      final result = await controller.handleDeleteAll(series!);

      final habits = await db.habitsTable.select().get();
      final seriesList = await db.habitSeriesTable.select().get();
      final exceptions = await db.habitExceptionsTable.select().get();

      expect(result, true);
      expect(habits.any((h) => h.id == habitId), false);
      expect(seriesList.any((s) => s.id == seriesId), false);
      expect(exceptions.any((e) => e.habitSeriesId == seriesId), false);

      debugPrint('Passed!');
    });

    test(
        'deleteHabit with ActionScope.thisAndFollowing trims series and deletes future exceptions',
        () async {
      final habit = await repository.getHabit(habitId);
      final series = await repository.getHabitSeries(habit!.habitSeriesId);
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

      debugPrint('Passed!');
    });
  });
}
