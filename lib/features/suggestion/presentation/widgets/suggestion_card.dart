import 'package:flutter/material.dart';
import 'package:lifeflow/features/suggestion/presentation/widgets/suggested_habit_card.dart';

import '../../../../data/models/suggestion.dart';

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
                    child: Text(
                      suggestion.icon,
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
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
            if (suggestion.habit != null)
              SuggestedHabitCard(habit: suggestion.habit!),
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
