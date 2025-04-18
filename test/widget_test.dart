import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifeflow/core/providers/user_provider.dart';
import 'package:lifeflow/core/routing/app_router.dart';
import 'package:lifeflow/core/services/user_service.dart';
import 'package:lifeflow/features/login/presentation/login_screen.dart';
import 'package:lifeflow/features/main/presentation/main_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockUserService extends Mock implements UserService {}

void main() {
  late MockUserService mockUserService;

  setUp(() {
    mockUserService = MockUserService();
  });

  testWidgets('redirects to /login if user is not logged in', (tester) async {
    when(() => mockUserService.getCurrentUserId())
        .thenAnswer((_) async => null);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userServiceProvider.overrideWithValue(mockUserService),
        ],
        child: Consumer(
          builder: (context, ref, _) {
            final router = ref.watch(routerProvider);
            return MaterialApp.router(routerConfig: router);
          },
        ),
      ),
    );

    // Wait for animation & Timer
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('redirects to / if user is logged in', (tester) async {
    when(() => mockUserService.getCurrentUserId())
        .thenAnswer((_) async => 'user123');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userServiceProvider.overrideWithValue(mockUserService),
        ],
        child: Consumer(
          builder: (context, ref, _) {
            final router = ref.watch(routerProvider);
            return MaterialApp.router(routerConfig: router);
          },
        ),
      ),
    );

    // Wait for animation & Timer
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(MainScreen), findsOneWidget);
  });
}
