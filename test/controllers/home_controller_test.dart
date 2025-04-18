import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifeflow/core/providers/user_provider.dart';
import 'package:lifeflow/core/services/user_service.dart';
import 'package:lifeflow/data/database/app_database.dart';
import 'package:lifeflow/data/database/database_provider.dart';
import 'package:lifeflow/features/home/controllers/home_controller.dart';
import 'package:drift/native.dart';

class FakeUserService extends Fake implements UserService {
  @override
  Future<String?> getCurrentUserId() async => 'user-123';
}

void main() {
  late AppDatabase db;
  late ProviderContainer container;
  const testUserId = 'user-123';
  final testDate = DateTime(2025, 4, 16);
  final selectDate = testDate.add(Duration(days: 5));

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    container = ProviderContainer(overrides: [
      selectedDateProvider
          .overrideWith((ref) => SelectedDateNotifier(testDate)),
      userServiceProvider.overrideWithValue(FakeUserService()),
      appDatabaseProvider.overrideWithValue(db)
    ]);
  });

  tearDown(() async {
    await db.close();
    container.dispose();
  });

  test('Returns habit with override from recurring series', () async {
    final habitId = 'habit-1';
    final seriesId = 'series-1';

    await db.habitCategoriesTable.insertOne(
      HabitCategoriesTableCompanion.insert(
          id: 'health', label: 'Health', iconPath: 'assets/icons/health.png'),
    );

    await db.habitsTable.insertOne(
      HabitsTableCompanion.insert(
        id: habitId,
        name: 'Drink Water',
        userId: testUserId,
        startDate: testDate.toUtc(),
        categoryId: 'health',
        trackingType: 'progress',
        targetValue: Value(10),
        unit: Value('ml'),
        habitSeriesId: Value(seriesId),
      ),
    );

    await db.habitSeriesTable.insertOne(
      HabitSeriesTableCompanion.insert(
        id: seriesId,
        habitId: habitId,
        userId: testUserId,
        startDate: testDate.toUtc(),
        repeatFrequency: Value('daily'),
      ),
    );

    await db.habitExceptionsTable.insertOne(
      HabitExceptionsTableCompanion.insert(
        id: 'habit-2',
        date: selectDate.toUtc(),
        habitSeriesId: seriesId,
        isSkipped: Value(false),
        currentValue: Value(5),
      ),
    );

    final selectedDateNotifier = container.read(selectedDateProvider.notifier);
    selectedDateNotifier.updateSelectedDate(selectDate);

    final controller = container.read(homeControllerProvider.notifier);
    final result = await controller.fetchHabits();

    expect(result.length, 1);
    expect(result.first.name, 'Drink Water');
    expect(result.first.currentValue, 5);

    debugPrint('Passed!');
  });

  test('Returns base habit without recurring', () async {
    await db.habitCategoriesTable.insertOne(
      HabitCategoriesTableCompanion.insert(
          id: 'work', label: 'Work', iconPath: 'assets/icons/work.png'),
    );

    await db.habitsTable.insertAll([
      HabitsTableCompanion.insert(
        id: 'habit-0',
        name: 'Write Report',
        userId: testUserId,
        startDate: selectDate.toUtc(),
        categoryId: 'work',
        trackingType: 'complete',
      ),
      HabitsTableCompanion.insert(
        id: 'habit-1',
        name: 'Morning Run',
        userId: testUserId,
        startDate: selectDate.toUtc(),
        categoryId: 'work',
        trackingType: 'complete',
      ),
      HabitsTableCompanion.insert(
        id: 'habit-2',
        name: 'Evening Walk',
        userId: testUserId,
        startDate: testDate.toUtc(),
        categoryId: 'work',
        trackingType: 'complete',
      ),
    ]);

    final selectedDateNotifier = container.read(selectedDateProvider.notifier);
    selectedDateNotifier.updateSelectedDate(selectDate);

    final controller = container.read(homeControllerProvider.notifier);
    final result = await controller.fetchHabits();

    expect(result.length, 2);
    expect(result.first.name, 'Write Report');
    expect(result[1].name, 'Morning Run');

    debugPrint('Passed!');
  });

  test('Skips habit with exception marked isSkipped = true', () async {
    final habitId = 'habit-3';
    final seriesId = 'series-3';

    await db.habitCategoriesTable.insertOne(
      HabitCategoriesTableCompanion.insert(
          id: 'cat-3', label: 'Fitness', iconPath: 'assets/icons/fitness.png'),
    );

    await db.habitsTable.insertOne(
      HabitsTableCompanion.insert(
        id: habitId,
        name: 'Morning Run',
        userId: testUserId,
        startDate: testDate.toUtc(),
        categoryId: 'cat-3',
        trackingType: 'complete',
        habitSeriesId: Value(seriesId),
      ),
    );

    await db.habitSeriesTable.insertOne(
      HabitSeriesTableCompanion.insert(
        id: seriesId,
        habitId: habitId,
        repeatFrequency: Value('daily'),
        userId: testUserId,
        startDate: testDate.toUtc(),
      ),
    );

    await db.habitExceptionsTable.insertOne(
      HabitExceptionsTableCompanion.insert(
        id: 'habit-4',
        date: testDate.toUtc(),
        isSkipped: Value(true),
        habitSeriesId: seriesId,
      ),
    );

    final controller = container.read(homeControllerProvider.notifier);
    final result = await controller.fetchHabits();

    expect(result.isEmpty, true);

    debugPrint('Passed!');
  });
}
