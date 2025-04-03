import 'package:flutter/material.dart';
import 'package:lifeflow/features/suggestion/presentation/widgets/suggested_habit_card.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/domain/models/suggestion.dart';

class SuggestionCard extends StatelessWidget {
  final Suggestion suggestion;

  const SuggestionCard({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Theme.of(context).cardTheme.color,
                  child: Image.asset(
                      suggestion.habitData?.category.iconPath ??
                          defaultCategories[0].iconPath,
                      width: 24,
                      height: 24),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '"${suggestion.title}"',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            if (suggestion.habitData != null)
              SuggestedHabitCard(habit: suggestion.habitData!),
            SizedBox(height: 4.0),
            Text(
              suggestion.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
