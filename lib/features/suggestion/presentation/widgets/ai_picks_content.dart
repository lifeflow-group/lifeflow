import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/domain/models/habit.dart';
import '../../../../data/services/analytics/analytics_service.dart';
import '../../../../src/generated/l10n/app_localizations.dart';
import '../../controllers/ai_picks_controller.dart';
import 'empty_suggestions_view.dart';
import 'loading_view.dart';
import 'personalization_chip.dart';
import 'suggestion_card.dart';
import 'error_view.dart';
import 'no_connectivity_view.dart';

class AIPicksContent extends StatelessWidget {
  final AsyncValue<AIPicksState> suggestionsState;
  final AppLocalizations l10n;
  final AnalyticsService analyticsService;
  final AIPicksController notifier;
  final TabController? tabController;
  final void Function(BuildContext context, Habit newHabit, String suggestionId)
      onHabitTap;

  const AIPicksContent({
    super.key,
    required this.suggestionsState,
    required this.l10n,
    required this.analyticsService,
    required this.notifier,
    required this.tabController,
    required this.onHabitTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return suggestionsState.when(
      loading: () => const LoadingView(),
      error: (err, stack) => ErrorView(
        error: err,
        controller: notifier,
        l10n: l10n,
        analyticsService: analyticsService,
        tabController: tabController,
        componentName: 'AIPicksTab',
      ),
      data: (state) {
        if (state.hasConnectivity == false) {
          return NoConnectivityView(onRetry: () => notifier.refresh());
        }

        final suggestions = state.suggestions;
        final personalizationContext =
            state.aiSuggestionRequestInput?.personalizationContext;

        return SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                personalizationContext != null
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        if (personalizationContext
                                                .personalityType !=
                                            null)
                                          PersonalizationChip(
                                            icon: Icons.person_outline,
                                            label: personalizationContext
                                                .personalityType!
                                                .getLocalizedName(context),
                                          ),
                                        if (personalizationContext
                                                .timePreference !=
                                            null)
                                          PersonalizationChip(
                                            icon: Icons.access_time,
                                            label: personalizationContext
                                                .timePreference!
                                                .getLocalizedName(context),
                                          ),
                                        if (personalizationContext
                                                .guidanceLevel !=
                                            null)
                                          PersonalizationChip(
                                            icon: Icons.layers_outlined,
                                            label: personalizationContext
                                                .guidanceLevel!
                                                .getLocalizedName(context),
                                          ),
                                      ],
                                    ),
                                    if (personalizationContext.goals.isNotEmpty)
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: theme.colorScheme.primary
                                              .withAlpha(20),
                                        ),
                                        child: Text(
                                            personalizationContext.goals,
                                            style: theme.textTheme.titleSmall),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                padding: EdgeInsets.all(8),
                                constraints: BoxConstraints(),
                                style: const ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap),
                                icon: Icon(Icons.refresh,
                                    color: theme.colorScheme.onSurface
                                        .withAlpha(180),
                                    size: 20),
                                onPressed: () => notifier.refresh(),
                                tooltip: l10n.loading,
                              ),
                              IconButton(
                                padding: EdgeInsets.all(8),
                                constraints: BoxConstraints(),
                                style: const ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap),
                                icon: Icon(Icons.mode_edit_outline_outlined,
                                    color: theme.colorScheme.onSurface
                                        .withAlpha(180),
                                    size: 20),
                                onPressed: () => notifier.setSubmitted(false),
                              ),
                              IconButton(
                                padding: EdgeInsets.all(6),
                                constraints: BoxConstraints(),
                                style: const ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap),
                                icon: Icon(Icons.open_in_new_outlined,
                                    color: theme.colorScheme.onSurface
                                        .withAlpha(180),
                                    size: 20),
                                onPressed: () {
                                  notifier.setSubmitted(false);
                                  notifier.invalidateSelf();
                                },
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                if (suggestions.isEmpty)
                  EmptySuggestionsView(
                    l10n: l10n,
                    analyticsService: analyticsService,
                    tabController: tabController,
                  )
                else
                  ...suggestions.map((suggestion) {
                    return SuggestionCard(
                      suggestion: suggestion,
                      isSelected: state.selectedIds.contains(suggestion.id),
                      onToggleSelection: () =>
                          notifier.toggleSuggestion(suggestion.id),
                      onHabitTap: (newHabit) =>
                          onHabitTap(context, newHabit, suggestion.id),
                    );
                  }),
                if (suggestions.isNotEmpty) const SizedBox(height: 65),
              ],
            ),
          ),
        );
      },
    );
  }
}
