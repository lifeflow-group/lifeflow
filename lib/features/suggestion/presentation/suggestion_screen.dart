import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../data/services/analytics/analytics_service.dart';
import '../../../shared/actions/habit_actions.dart';
import '../controllers/suggestion_controller.dart';
import 'widgets/loading_view.dart';
import 'widgets/suggestion_card.dart';

class SuggestionScreen extends ConsumerWidget {
  const SuggestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final analyticsService = ref.read(analyticsServiceProvider);
    final suggestionsState = ref.watch(suggestionControllerProvider);
    final notifier = ref.read(suggestionControllerProvider.notifier);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.cardTheme.color,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: CircleAvatar(
                radius: 18,
                backgroundColor: theme.colorScheme.onPrimary,
                child: Icon(Icons.auto_awesome,
                    color: theme.primaryColor, size: 20)),
          ),
          leadingWidth: 46,
          title: Text(
            l10n.suggestionTitle,
            style: theme.textTheme.titleMedium
                ?.copyWith(color: theme.colorScheme.onSurface),
          ),
          backgroundColor: theme.cardTheme.color,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: l10n.refreshButton,
              onPressed: () {
                analyticsService.trackSuggestionRefreshButtonTapped();
                notifier.refresh();
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => notifier.refresh(),
          child: suggestionsState.when(
            loading: () => const LoadingView(),
            error: (err, stack) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.suggestionError(err.toString())),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        analyticsService.trackSuggestionRetryButtonTapped();
                        notifier.refresh();
                      },
                      child: Text(l10n.retryButton),
                    ),
                  ],
                ),
              );
            },
            data: (state) {
              final suggestions = state.suggestions;
              final isAllSelected = state.isAllSelected();
              final hasAnySelection = state.hasSelections;
              final selectedCount = state.selectedCount;

              return Stack(
                children: [
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 12.0),
                      child: Column(
                        children: [
                          if (suggestions.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(Icons.lightbulb_outline,
                                        size: 48,
                                        color: theme.colorScheme.onSurface
                                            .withAlpha(150)),
                                    const SizedBox(height: 16),
                                    Text(l10n.noSuggestionsAvailable,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodyLarge),
                                  ],
                                ),
                              ),
                            )
                          else
                            ...suggestions.map((suggestion) {
                              return SuggestionCard(
                                suggestion: suggestion,
                                isSelected:
                                    state.selectedIds.contains(suggestion.id),
                                onToggleSelection: () =>
                                    notifier.toggleSuggestion(suggestion.id),
                              );
                            }),
                          // Add padding at the bottom for the action bar
                          if (suggestions.isNotEmpty)
                            const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),

                  // Bottom action bar for selection and apply
                  if (suggestions.isNotEmpty)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: theme.cardTheme.color,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withAlpha(26),
                                blurRadius: 4.0,
                                offset: const Offset(0, -2)),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Select All Checkbox
                            Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    value: isAllSelected,
                                    shape: CircleBorder(),
                                    side: WidgetStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                        width: isAllSelected ? 4 : 2,
                                        color: isAllSelected
                                            ? theme.colorScheme.primary
                                            : theme.colorScheme.onSurface,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                      ),
                                    ),
                                    onChanged: (_) {
                                      notifier.toggleAll(!isAllSelected);
                                    },
                                    activeColor: theme.colorScheme.primary,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                    onTap: () {
                                      notifier.toggleAll(!isAllSelected);
                                    },
                                    child: Text(l10n.selectAll,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold))),
                              ],
                            ),
                            const Spacer(),
                            // Apply Button
                            ElevatedButton(
                              onPressed: hasAnySelection
                                  ? () => _handleApplySelected(
                                        context: context,
                                        notifier: notifier,
                                        l10n: l10n,
                                        analyticsService: analyticsService,
                                        selectedCount: selectedCount,
                                      )
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                disabledBackgroundColor:
                                    theme.colorScheme.primary.withAlpha(135),
                              ),
                              child: Text(l10n.applySelected),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Handles applying selected suggestions and navigating to summary screen
  Future<void> _handleApplySelected({
    required BuildContext context,
    required SuggestionController notifier,
    required AppLocalizations l10n,
    required AnalyticsService analyticsService,
    required int selectedCount,
  }) async {
    final appliedHabits = await notifier.applySelectedSuggestions();

    // Track the application results
    analyticsService.trackSuggestionsApplied(
        selectedCount, appliedHabits.length);

    // Navigate to summary screen if there are applied habits
    if (context.mounted && appliedHabits.isNotEmpty) {
      // Use await to pause execution until returning from summary screen
      await context.pushNamed('applied-habits-summary',
          extra: {'habits': appliedHabits});

      // Track return from summary screen
      if (context.mounted) {
        // Refresh suggestions when returning from summary
        notifier.refresh();
      }
    } else {
      // Track that no habits were applied
      if (appliedHabits.isEmpty) {
        analyticsService.trackSuggestionsApplyEmptyResult(selectedCount);
      }

      // Show snackbar if no habits were applied or navigation isn't possible
      showSnackbar(l10n.habitsApplied);
    }
  }
}
