import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifeflow/data/domain/models/habit_category.dart';
import 'package:lifeflow/data/services/user_service.dart';
import 'package:lifeflow/data/services/analytics/analytics_service.dart';
import 'package:lifeflow/data/datasources/local/app_database.dart';
import 'package:lifeflow/data/datasources/local/database_provider.dart';
import 'package:lifeflow/features/home/controllers/home_controller.dart';
import 'package:drift/native.dart';
import 'package:mocktail/mocktail.dart';

// Define the mock classes at the top level
class MockAnalyticsService extends Mock implements AnalyticsService {}

class FakeUserService extends Fake implements UserService {
  @override
  Future<String?> getCurrentUserId() async => 'user-123';
}

void main() {
  late AppDatabase db;
  late ProviderContainer container;
  late MockAnalyticsService mockAnalyticsService;
  const testUserId = 'user-123';
  final testDate = DateTime(2025, 4, 16);
  final selectDate = testDate.add(Duration(days: 5));

  setUpAll(() {
    registerFallbackValue(
        DateTime(2025, 1, 1)); // Fallback DateTime value for any() matchers
  });

  setUp(() {
    final inMemory = DatabaseConnection(NativeDatabase.memory());
    db = AppDatabase.forTesting(inMemory);
    mockAnalyticsService = MockAnalyticsService();

    // Setup mock method responses
    when(() => mockAnalyticsService.trackHomeHabitsFetching(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockAnalyticsService.trackHomeHabitsFetched(
        any(), any(), any(), any(), any())).thenAnswer((_) async {});
    when(() => mockAnalyticsService.trackHomeCategoryFilterApplied(any()))
        .thenAnswer((_) async {});

    container = ProviderContainer(overrides: [
      selectedDateProvider
          .overrideWith((ref) => SelectedDateNotifier(testDate)),
      userServiceProvider.overrideWithValue(FakeUserService()),
      appDatabaseProvider.overrideWithValue(db),
      analyticsServiceProvider.overrideWithValue(mockAnalyticsService),
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
          id: 'health',
          name: 'Health',
          iconPath: 'assets/icons/health.png',
          colorHex: '#FF5733'),
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

    // Verify analytics calls - use typed matchers
    verify(() => mockAnalyticsService.trackHomeHabitsFetching(
        any<DateTime>(), any<String?>())).called(2);
    verify(() => mockAnalyticsService.trackHomeHabitsFetched(
        any<DateTime>(), any<String?>(), 1, 1, 0)).called(2);
  });

  test('Returns base habit without recurring', () async {
    await db.habitCategoriesTable.insertOne(
      HabitCategoriesTableCompanion.insert(
          id: 'work',
          name: 'Work',
          iconPath: 'assets/icons/work.png',
          colorHex: '#FF5733'),
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

    // Update verification
    verify(() => mockAnalyticsService.trackHomeHabitsFetching(
        any<DateTime>(), any<String?>())).called(2);
    verify(() => mockAnalyticsService.trackHomeHabitsFetched(
        any<DateTime>(), any<String?>(), 2, 2, 0)).called(2);
  });

  test('Skips habit with exception marked isSkipped = true', () async {
    final habitId = 'habit-3';
    final seriesId = 'series-3';

    await db.habitCategoriesTable.insertOne(
      HabitCategoriesTableCompanion.insert(
          id: 'cat-3',
          name: 'Fitness',
          iconPath: 'assets/icons/fitness.png',
          colorHex: '#FF5733'),
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

    // Update verification
    verify(() => mockAnalyticsService.trackHomeHabitsFetching(
        any<DateTime>(), any<String?>())).called(2);
    verify(() => mockAnalyticsService.trackHomeHabitsFetched(
        any<DateTime>(), any<String?>(), 0, 0, 0)).called(2);
  });

  // Test category filtering
  test('Filters habits by selected category', () async {
    // Insert two categories
    await db.habitCategoriesTable.insertAll([
      HabitCategoriesTableCompanion.insert(
        id: 'work',
        name: 'Work',
        iconPath: 'assets/icons/work.png',
        colorHex: '#FF5733',
      ),
      HabitCategoriesTableCompanion.insert(
        id: 'fitness',
        name: 'Fitness',
        iconPath: 'assets/icons/fitness.png',
        colorHex: '#3366FF',
      ),
    ]);

    // Insert habits from different categories
    await db.habitsTable.insertAll([
      HabitsTableCompanion.insert(
        id: 'habit-work-1',
        name: 'Work Task 1',
        userId: testUserId,
        startDate: testDate.toUtc(),
        categoryId: 'work',
        trackingType: 'complete',
      ),
      HabitsTableCompanion.insert(
        id: 'habit-fitness-1',
        name: 'Workout',
        userId: testUserId,
        startDate: testDate.toUtc(),
        categoryId: 'fitness',
        trackingType: 'complete',
      ),
    ]);

    // Get the work category to filter by
    final categories = await db.habitCategoriesTable.select().get();
    final workCategory = categories.firstWhere((cat) => cat.id == 'work');

    // Set the selected category
    container.read(selectedCategoryProvider.notifier).updateSelectedCategory(
          HabitCategory.fromJson({
            'id': workCategory.id,
            'name': workCategory.name,
            'iconPath': workCategory.iconPath,
            'colorHex': workCategory.colorHex,
          }),
        );

    // Fetch habits
    final controller = container.read(homeControllerProvider.notifier);
    final result = await controller.fetchHabits();

    // Should only get the work habit
    expect(result.length, 1);
    expect(result.first.name, 'Work Task 1');
    expect(result.first.category.id, 'work');

    // Update verification - use captureAny if you need to verify specific values
    verify(() => mockAnalyticsService.trackHomeHabitsFetching(
        any<DateTime>(), any<String?>())).called(2);
  });
}
