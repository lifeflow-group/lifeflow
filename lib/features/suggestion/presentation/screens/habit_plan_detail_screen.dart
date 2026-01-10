import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../../../core/config/environment.dart';
import '../../../../data/domain/models/habit.dart';
import '../../../../data/domain/models/habit_plan.dart';
import '../../../../data/services/analytics/analytics_service.dart';
import '../../../../shared/actions/habit_actions.dart';
import '../../../../src/generated/l10n/app_localizations.dart';
import '../../controllers/habit_plan_detail_controller.dart'; // Import controller mới
import '../widgets/action_selection_bar.dart';
import '../widgets/suggestion_card.dart';

class HabitPlanDetailScreen extends ConsumerWidget {
  final HabitPlan plan;

  const HabitPlanDetailScreen({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final analyticsService = ref.read(analyticsServiceProvider);

    final planDetailState = ref.watch(habitPlanDetailControllerProvider(plan));
    final controller =
        ref.read(habitPlanDetailControllerProvider(plan).notifier);

    final isAllSelected = planDetailState.isAllSelected();
    final hasAnySelection = planDetailState.hasSelections;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with image
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            iconTheme: IconThemeData(color: theme.colorScheme.primary),
            flexibleSpace: FlexibleSpaceBar(
              background: planDetailState.plan.imagePath.startsWith('assets/')
                  ? Image.asset(
                      planDetailState.plan.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: theme.colorScheme.primary.withAlpha(26),
                          child: Icon(
                            Icons.image_not_supported,
                            color: theme.colorScheme.primary,
                            size: 64,
                          ),
                        );
                      },
                    )
                  : Image.network(
                      '${Environment.apiBaseUrl}/${planDetailState.plan.imagePath}',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: theme.colorScheme.primary.withAlpha(26),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: theme.colorScheme.primary.withAlpha(26),
                          child: Icon(
                            Icons.image_not_supported,
                            color: theme.colorScheme.primary,
                            size: 64,
                          ),
                        );
                      },
                    ),
            ),
            backgroundColor: theme.scaffoldBackgroundColor,
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 8.0, left: 12.0, right: 12.0),
              child: Text(
                planDetailState.plan.title,
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),

          // List of habits
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final suggestion = planDetailState.plan.suggestions[index];

                  return SuggestionCard(
                    suggestion: suggestion,
                    isSelected:
                        planDetailState.selectedIds.contains(suggestion.id),
                    onToggleSelection: () =>
                        controller.toggleHabitSelection(suggestion.id),
                    onHabitTap: (newHabit) => _handleHabitTap(
                        context, controller, newHabit, suggestion.id),
                  );
                },
                childCount: planDetailState.plan.suggestions.length,
              ),
            ),
          ),

          // Plan description
          SliverToBoxAdapter(
            child: MarkdownWidget(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                data: planDetailState.plan.description,
                shrinkWrap: true),
          ),

          // Extra space at bottom for the button
          SliverToBoxAdapter(child: SizedBox(height: 65)),
        ],
      ),

      // Bottom action bar
      bottomSheet: ActionSelectionBar(
        isAllSelected: isAllSelected,
        hasAnySelection: hasAnySelection,
        selectAllLabel: l10n.selectAll,
        applyButtonLabel: l10n.applySelected,
        onToggleAll: (selected) => controller.toggleAll(selected),
        onApply: () => _handleApplySelected(
            context, controller, planDetailState, l10n, analyticsService),
      ),
    );
  }

  // Simplified _handleHabitTap using the new controller
  Future<void> _handleHabitTap(
      BuildContext context,
      HabitPlanDetailController controller,
      Habit newHabit,
      String suggestionId) async {
    final l10n = AppLocalizations.of(context)!;

    // Update the suggestion directly in the controller
    controller.updateSuggestion(suggestionId, newHabit);

    // Show a snackbar confirming the update
    showSnackbar(l10n.habitAdded);
  }

  // Handle applying selected habits
  Future<void> _handleApplySelected(
    BuildContext context,
    HabitPlanDetailController controller,
    HabitPlanDetailState planDetailState,
    AppLocalizations l10n,
    AnalyticsService analyticsService,
  ) async {
    // Apply selected suggestions using the controller
    final appliedHabits = await controller.applySelectedSuggestions();

    // Navigate to summary screen if there are applied habits
    if (context.mounted && appliedHabits.isNotEmpty) {
      await context.pushNamed('applied-habits-summary',
          extra: {'habits': appliedHabits});

      if (context.mounted) {
        // Return to suggestions screen after applying
        context.pop();
      }
    } else {
      // Show snackbar if no habits were applied
      if (appliedHabits.isEmpty) {
        analyticsService.trackHabitPlanApplyEmptyResult(
            planDetailState.plan.id, planDetailState.selectedCount);
      }

      showSnackbar(l10n.habitsApplied);
    }
  }
}
