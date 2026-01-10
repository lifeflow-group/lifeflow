import 'package:flutter/material.dart';

import '../../../../core/utils/logger.dart';
import '../../../../data/services/analytics/analytics_service.dart';
import '../../../../src/generated/l10n/app_localizations.dart';

/// Error state widget for when there's an error loading content
class ErrorView extends StatelessWidget {
  /// The error object
  final Object error;

  /// Controller for refreshing content
  final dynamic controller;

  /// Localization for text display
  final AppLocalizations l10n;

  /// Analytics service for tracking events
  final AnalyticsService analyticsService;

  /// Optional tab controller to allow switching tabs
  final TabController? tabController;

  /// Whether to show the "Explore Habit Plans" button
  final bool showExploreButton;

  /// The name of the component (for logging purposes)
  final String componentName;

  ErrorView({
    super.key,
    required this.error,
    required this.controller,
    required this.l10n,
    required this.analyticsService,
    this.tabController,
    this.showExploreButton = true, // Default is to show the button
    this.componentName = 'ErrorView',
  }) {
    // Log error when widget is initialized
    AppLogger(componentName).error("Content loading failed", error);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 56,
              color: Theme.of(context).colorScheme.error.withAlpha(204),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.tryAgainLaterMessage,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    analyticsService.trackSuggestionRetryButtonTapped();
                    controller.refresh();
                  },
                  child: Text(l10n.retryButton),
                ),
                // Only show the Explore button if specified
                if (showExploreButton) ...[
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Switch to Habit Plans tab if we have a controller
                      if (tabController != null) {
                        tabController!.animateTo(0);
                        analyticsService.trackHabitPlansSwitchedFromError();
                      }
                    },
                    child: Text(l10n.exploreHabitPlans),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
