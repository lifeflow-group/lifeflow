import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/services/analytics/analytics_service.dart';

/// Empty state widget for when no suggestions are available
class EmptySuggestionsView extends StatelessWidget {
  /// Localization for text display
  final AppLocalizations l10n;

  /// Analytics service for tracking events
  final AnalyticsService analyticsService;

  /// Optional tab controller to allow switching tabs
  final TabController? tabController;

  const EmptySuggestionsView({
    super.key,
    required this.l10n,
    required this.analyticsService,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.lightbulb_outline,
                size: 48, color: theme.colorScheme.onSurface.withAlpha(150)),
            const SizedBox(height: 16),
            Text(l10n.noSuggestionsAvailable,
                textAlign: TextAlign.center, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                if (tabController != null) {
                  tabController!.animateTo(0); // Switch to Habit Plans tab
                  analyticsService.trackHabitPlansSwitchedFromEmpty();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
              child: Text(l10n.exploreHabitPlans),
            ),
          ],
        ),
      ),
    );
  }
}
