import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';

import '../../../../data/domain/models/habit.dart';
import '../../../../data/services/analytics/analytics_service.dart';
import '../../../../src/generated/l10n/app_localizations.dart';
import '../../../main/controllers/main_controller.dart';
import '../widgets/suggested_habit_card.dart';

class AppliedHabitsSummaryScreen extends ConsumerStatefulWidget {
  const AppliedHabitsSummaryScreen({super.key, required this.appliedHabits});

  final List<Habit> appliedHabits;

  @override
  ConsumerState<AppliedHabitsSummaryScreen> createState() =>
      _AppliedHabitsSummaryScreenState();
}

class _AppliedHabitsSummaryScreenState
    extends ConsumerState<AppliedHabitsSummaryScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    // Play confetti animation when screen loads
    Future.microtask(() {
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final analyticsService = ref.read(analyticsServiceProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Confetti animation at the top
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: 3.14 / 2, // downward
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                maxBlastForce: 5,
                minBlastForce: 2,
                gravity: 0.1,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                  theme.colorScheme.tertiary,
                  Colors.orange,
                  Colors.green,
                ],
              ),
            ),

            // Main content
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header section
                Container(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 24, bottom: 8),
                  color: theme.colorScheme.surface,
                  child: Column(
                    children: [
                      Icon(Icons.celebration,
                          color: theme.colorScheme.primary, size: 64),
                      const SizedBox(height: 16),
                      Text(
                        l10n.appliedHabitsSuccessTitle,
                        style: theme.textTheme.headlineMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.appliedHabitsCountMessage(
                            widget.appliedHabits.length),
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(178)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.appliedHabitsDescription,
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // List of applied habits
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: widget.appliedHabits.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: SuggestedHabitCard(
                            habit: widget.appliedHabits[index]),
                      );
                    },
                  ),
                ),
              ],
            ),

            // Bottom action buttons
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(26),
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Track button click
                          analyticsService
                              .trackAppliedHabitsBackToSuggestionsClicked(
                                  widget.appliedHabits.length);

                          // Go back to suggestions
                          context.pop();
                        },
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: theme.colorScheme.outline, width: 0.5),
                            padding: const EdgeInsets.symmetric(vertical: 12)),
                        child: Text(
                          l10n.backToSuggestionsButton,
                          style: theme.textTheme.titleSmall
                              ?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Track button click
                          analyticsService.trackAppliedHabitsGoHomeClicked(
                              widget.appliedHabits.length);

                          // Set the tab index to home (0) before navigating
                          ref.read(mainControllerProvider).setTab(0);

                          // Go to home screen
                          context.go('/');
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: theme.colorScheme.primary),
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(l10n.goToHomeButton),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
