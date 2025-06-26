import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeflow/features/suggestion/presentation/widgets/suggested_habit_card.dart';

import '../../../../data/domain/models/habit.dart';
import '../../../../data/domain/models/suggestion.dart';
import '../../../../data/services/user_service.dart';
import '../../../habit_detail/controllers/habit_detail_controller.dart';

class SuggestionCard extends ConsumerWidget {
  const SuggestionCard({
    super.key,
    required this.suggestion,
    required this.isSelected,
    required this.onToggleSelection,
    this.onHabitTap,
  });

  final Suggestion suggestion;
  final bool isSelected;
  final VoidCallback onToggleSelection;
  final void Function(Habit habit)? onHabitTap;

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
            if (suggestion.habit != null)
              InkWell(
                  onTap: () =>
                      handleTapSuggestionHabit(ref, suggestion, context),
                  child: SuggestedHabitCard(habit: suggestion.habit!)),
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
    final userId = await ref.read(userServiceProvider).getCurrentUserId();
    if (suggestion.habit == null || userId == null) {
      return;
    }

    if (!context.mounted) return;

    // Navigate to habit detail screen and await the result
    final result =
        await context.pushNamed('habit-detail', extra: suggestion.habit);

    // If no result or invalid type, return early
    if (result == null || result is! HabitFormResult) return;

    onHabitTap?.call(result.newHabit);
  }
}
