import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeflow/core/providers/user_provider.dart';
import 'package:lifeflow/data/database/app_database.dart';
import 'package:lifeflow/data/database/database_provider.dart';
import 'package:lifeflow/data/domain/models/habit.dart';
import 'package:lifeflow/features/habit_detail/controllers/habit_detail_controller.dart';
import 'package:lifeflow/features/habit_detail/presentation/widgets/edit_scope_dialog.dart';
import 'package:lifeflow/features/habit_detail/repositories/habit_detail_repository.dart';

import 'home_controller_test.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;
  late HabitDetailController controller;
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

    controller = container.read(habitDetailControllerProvider);
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
        id: 'habit-2',
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
      final habit = await repository.getHabit(habitId);
      await controller.fromHabit(habit!);

      // Change the habit name
      controller.updateHabitName('Read Manga');

      // Save the habit with ActionScope.onlyThis
      final updatedHabit =
          await controller.updateHabit(habit, () async => ActionScope.onlyThis);

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

      debugPrint('Passed!');
    });

    test('updateHabit with ActionScope.all updates series and original habit',
        () async {
      // Navigate to the habit detail screen
      final habit = await repository.getHabit(habitId);
      await controller.fromHabit(habit!);

      // Change the habit name and repeat frequency
      controller.updateHabitName('Read Manga');
      controller.updateHabitRepeatFrequency(RepeatFrequency.weekly);

      // Act: Call updateHabit with ActionScope.all
      final updatedHabit =
          await controller.updateHabit(habit, () async => ActionScope.all);

      // Assert: Fetch updated habit and its series from the database
      final updated = await repository.getHabit(habitId);
      final updatedSeries = await repository.getHabitSeries(seriesId);

      // Expect: The habit was updated in-place (no new habit created)
      expect(updatedHabit!.id, habitId);

      // Expect: The original habit name was updated
      expect(updated!.name, 'Read Manga');

      // Expect: The original series was updated in-place
      expect(updatedSeries!.repeatFrequency, RepeatFrequency.weekly);

      debugPrint('Passed!');
    });

    test(
        'updateHabit with ActionScope.thisAndFollowing creates trimmed old series and new series',
        () async {
      final selectDate = habitDate.add(Duration(days: 5));
      // Navigate to the habit detail screen (Habit in selectDate)
      Habit? habit = await repository.getHabit(habitId);
      habit = habit?.rebuild((p0) => p0..startDate = selectDate);
      await controller.fromHabit(habit!);

      // Change the habit name
      controller.updateHabitName('Read Manga');

      // Save the habit with ActionScope.thisAndFollowing
      final updateHabit = await controller.updateHabit(
          habit, () async => ActionScope.thisAndFollowing);

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

      debugPrint('Passed!');
    });
  });
}
