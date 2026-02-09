import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeflow/app.dart';
import 'package:lifeflow/data/services/analytics/analytics_service.dart';
import 'package:lifeflow/data/services/user_service.dart';
import 'package:lifeflow/data/datasources/local/app_database.dart';
import 'package:lifeflow/features/login/presentation/login_screen.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockAnalyticsService extends Mock implements AnalyticsService {}

class MockUserService extends Mock implements UserService {}

class MockAppDatabase extends Mock implements AppDatabase {}

void main() {
  late MockAnalyticsService mockAnalytics;
  late MockUserService mockUserService;

  setUp(() {
    mockAnalytics = MockAnalyticsService();
    mockUserService = MockUserService();

    // Stub all methods that might be called
    when(() => mockAnalytics.trackAppInitializationStarted())
        .thenAnswer((_) async {});
    when(() => mockAnalytics.logScreenView(any())).thenAnswer((_) async {});
    when(() => mockAnalytics.trackScreenViewed(any(), any(), any(), any()))
        .thenAnswer((_) async {});
    when(() => mockAnalytics.trackUserAuthStateChecked(any()))
        .thenAnswer((_) async {});
    when(() => mockAnalytics.trackNotificationPayloadChecked(any()))
        .thenAnswer((_) async {});
    when(() => mockAnalytics.trackUserSettingsLoadingStarted(any()))
        .thenAnswer((_) async {});
    when(() => mockAnalytics.trackUserSettingsLoaded(any()))
        .thenAnswer((_) async {});
    when(() => mockAnalytics.trackAppInitializationCompleted(any()))
        .thenAnswer((_) async {});
    when(() => mockAnalytics.trackInitialNavigation(any(), any(), any()))
        .thenAnswer((_) async {});

    // Mock user service to return no logged-in user
    when(() => mockUserService.getCurrentUserId())
        .thenAnswer((_) async => null);
  });

  testWidgets('redirects to /login if user is not logged in',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          analyticsServiceProvider.overrideWithValue(mockAnalytics),
          userServiceProvider.overrideWithValue(mockUserService),
        ],
        child: const LifeFlowApp(),
      ),
    );

    // Wait for all animations and async operations to complete
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Check if app navigated to login screen
    // (adjust the finder based on your actual LoginScreen structure)
    expect(
      find.byType(LoginScreen),
      findsOneWidget,
      reason: 'Should navigate to LoginScreen when user is not logged in',
    );
  });
}
