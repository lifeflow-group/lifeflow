import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/domain/models/habit.dart';
import '../../../home/presentation/widgets/habit_item.dart';

class HabitListWithDateHeaders extends StatelessWidget {
  final List<Habit> habits;
  final VoidCallback? controllerInvalidate;

  const HabitListWithDateHeaders({
    super.key,
    required this.habits,
    this.controllerInvalidate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Sort habits by date
    final sortedHabits = List<Habit>.from(habits)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));

    // Group habits by date (using DD/MM/YYYY format as key)
    final Map<String, List<Habit>> habitsByDate = {};

    for (final habit in sortedHabits) {
      final dateKey = DateFormat('dd/MM/yyyy').format(habit.startDate);
      if (!habitsByDate.containsKey(dateKey)) {
        habitsByDate[dateKey] = [];
      }
      habitsByDate[dateKey]!.add(habit);
    }

    // Build list with headers
    final List<Widget> result = [];

    habitsByDate.forEach((dateStr, habitsForDate) {
      // Add date header
      result.add(
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
          child: Center(
            child: Text(
              dateStr,
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withAlpha(170)),
            ),
          ),
        ),
      );

      // Add habits for this date
      for (final habit in habitsForDate) {
        result.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4, top: 4),
            child: HabitItem(
              habit: habit,
              colorBackground: theme.colorScheme.onPrimary,
              colorBorder: theme.colorScheme.shadow.withAlpha(38),
              controllerInvalidate: controllerInvalidate,
            ),
          ),
        );
      }
    });

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: result);
  }
}
