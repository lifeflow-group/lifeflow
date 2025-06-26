import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/domain/models/habit.dart';
import '../../../../data/services/analytics/analytics_service.dart';
import '../../../../shared/actions/habit_actions.dart';
import '../../controllers/ai_picks_controller.dart';
import '../widgets/action_selection_bar.dart';
import '../widgets/empty_suggestions_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/suggestion_card.dart';
import '../widgets/error_view.dart';
import '../widgets/no_connectivity_view.dart';

/// Tab that displays personalized suggestions for the user
class AIPicksTab extends ConsumerStatefulWidget {
  /// Optional controller to switch between tabs
  final TabController? tabController;

  const AIPicksTab({super.key, this.tabController});

  @override
  ConsumerState<AIPicksTab> createState() => _AIPicksTabState();
}

class _AIPicksTabState extends ConsumerState<AIPicksTab> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final analyticsService = ref.read(analyticsServiceProvider);
    final suggestionsState = ref.watch(aiPicksControllerProvider);
    final notifier = ref.read(aiPicksControllerProvider.notifier);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => notifier.refresh(),
        child: suggestionsState.when(
          loading: () => const LoadingView(),
          error: (err, stack) => ErrorView(
            error: err,
            controller: notifier,
            l10n: l10n,
            analyticsService: analyticsService,
            tabController: widget.tabController,
            componentName: 'AIPicksTab',
          ),
          data: (state) {
            // Check connectivity status from controller
            if (state.hasConnectivity == false) {
              return NoConnectivityView(onRetry: () => notifier.refresh());
            }

            final suggestions = state.suggestions;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: Column(
                  children: [
                    if (suggestions.isEmpty)
                      EmptySuggestionsView(
                        l10n: l10n,
                        analyticsService: analyticsService,
                        tabController: widget.tabController,
                      )
                    else
                      ...suggestions.map((suggestion) {
                        return SuggestionCard(
                          suggestion: suggestion,
                          isSelected: state.selectedIds.contains(suggestion.id),
                          onToggleSelection: () =>
                              notifier.toggleSuggestion(suggestion.id),
                          onHabitTap: (newHabit) =>
                              _handleHabitTap(context, newHabit, suggestion.id),
                        );
                      }),
                    // Add padding at the bottom for the action bar
                    if (suggestions.isNotEmpty) const SizedBox(height: 65),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      // Add bottomSheet based on state
      bottomSheet: suggestionsState.maybeWhen(
        data: (state) {
          final suggestions = state.suggestions;
          if (suggestions.isEmpty) {
            // Don't show bottomSheet when there are no suggestions
            return null;
          }

          return ActionSelectionBar(
            isAllSelected: state.isAllSelected(),
            hasAnySelection: state.hasSelections,
            selectAllLabel: l10n.selectAll,
            applyButtonLabel: l10n.applySelected,
            onToggleAll: (selected) {
              notifier.toggleAll(selected);
            },
            onApply: () => _handleApplySelected(
              context: context,
              notifier: notifier,
              l10n: l10n,
              analyticsService: analyticsService,
              selectedCount: state.selectedCount,
            ),
          );
        },
        orElse: () => null, // Don't show when loading or error
      ),
    );
  }

  // Handles applying selected suggestions and navigating to summary screen
  Future<void> _handleApplySelected({
    required BuildContext context,
    required AIPicksController notifier,
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

  Future<void> _handleHabitTap(
      BuildContext context, Habit newHabit, String suggestionId) async {
    final analyticsService = ref.read(analyticsServiceProvider);
    final l10n = AppLocalizations.of(context)!;

    // Track suggestion habit tap
    analyticsService.trackSuggestionCardTapped(
        int.tryParse(suggestionId) ?? 0, newHabit.name, newHabit.category.name);

    // Get the controller and state
    final aiPicksController = ref.read(aiPicksControllerProvider.notifier);
    final suggestions =
        ref.read(aiPicksControllerProvider).value?.suggestions ?? [];

    // Find and update the modified suggestion
    final updatedSuggestions = suggestions.map((s) {
      // If this is the suggestion we modified
      if (s.id == suggestionId && s.habit != null) {
        // Return an updated suggestion with the new habit data
        return s.rebuild((b) => b..habit = newHabit.toBuilder());
      }
      // Return unchanged suggestions
      return s;
    }).toList();

    // Update the state with the modified suggestions
    aiPicksController.updateSuggestions(updatedSuggestions);

    // Show a snackbar confirming the update
    showSnackbar(l10n.habitAdded);
  }
}
