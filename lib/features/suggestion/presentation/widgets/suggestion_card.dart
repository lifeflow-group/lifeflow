import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lifeflow/features/suggestion/presentation/widgets/suggested_habit_card.dart';
import 'package:lifeflow/features/suggestion/controllers/suggestion_controller.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/domain/models/suggestion.dart';
import '../../../../data/services/analytics/analytics_service.dart';
import '../../../../data/services/user_service.dart';
import '../../../../shared/actions/habit_actions.dart';
import '../../../habit_detail/controllers/habit_detail_controller.dart';

class SuggestionCard extends ConsumerWidget {
  const SuggestionCard({
    super.key,
    required this.suggestion,
    required this.isSelected,
    required this.onToggleSelection,
  });

  final Suggestion suggestion;
  final bool isSelected;
  final VoidCallback onToggleSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.onPrimary,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: isSelected,
                    shape: CircleBorder(),
                    side: WidgetStateBorderSide.resolveWith(
                      (states) => BorderSide(
                        width: isSelected ? 4 : 2,
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                    onChanged: (_) {
                      onToggleSelection();
                    },
                    activeColor: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    suggestion.title,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            if (suggestion.habitData != null)
              InkWell(
                  onTap: () =>
                      handleTapSuggestionHabit(ref, suggestion, context),
                  child: SuggestedHabitCard(habit: suggestion.habitData!)),
            SizedBox(height: 4.0),
            Text(
              suggestion.description,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleTapSuggestionHabit(
      WidgetRef ref, Suggestion suggestion, BuildContext context) async {
    final analyticsService = ref.read(analyticsServiceProvider);
    final l10n = AppLocalizations.of(context)!;

    // Track suggestion habit tap
    analyticsService.trackSuggestionCardTapped(int.tryParse(suggestion.id) ?? 0,
        suggestion.title, suggestion.habitData?.category.name ?? 'unknown');

    final userId = await ref.read(userServiceProvider).getCurrentUserId();
    if (suggestion.habitData == null || userId == null) {
      return;
    }

    final habit = habitDataToHabit(suggestion.habitData!, userId);

    if (!context.mounted) return;

    // Navigate to habit detail screen and await the result
    final result = await context.pushNamed('habit-detail', extra: habit);

    // If no result or invalid type, return early
    if (result == null || result is! HabitFormResult) return;

    // Get the current suggestion controller and state
    final suggestionController =
        ref.read(suggestionControllerProvider.notifier);
    final suggestions =
        ref.read(suggestionControllerProvider).value?.suggestions ?? [];

    // Find and update the modified suggestion
    final updatedSuggestions = suggestions.map((s) {
      // If this is the suggestion we modified
      if (s.id == suggestion.id && s.habitData != null) {
        // Create updated habitData from the returned habit
        final updatedHabitData = habitToHabitData(result.newHabit);

        // Return an updated suggestion with the new habit data
        return s.rebuild((b) => b..habitData = updatedHabitData.toBuilder());
      }
      // Return unchanged suggestions
      return s;
    }).toList();

    // Update the state with the modified suggestions
    suggestionController.updateSuggestions(updatedSuggestions);

    // Show a snackbar confirming the update
    showSnackbar(l10n.habitAdded);
  }
}
