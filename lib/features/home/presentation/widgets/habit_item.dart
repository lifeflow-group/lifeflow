import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/habit.dart';

class HabitItem extends StatelessWidget {
  const HabitItem({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        leading: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Image.asset(habit.category.iconPath, width: 32, height: 32)),
        title: Text(habit.name),
        subtitle: Text(
          habit.trackingType == TrackingType.complete
              ? DateFormat('HH:mm').format(habit.startDate.toLocal())
              : '${habit.progress ?? 0}/${habit.quantity} ${habit.unit}',
        ),
        trailing: habit.trackingType == TrackingType.complete
            ? Radio<bool>(
                value: true,
                groupValue: habit.completed ?? false,
                onChanged: (value) {
                  // TODO: Implement the onChanged logic for habit completion
                },
              )
            : IconButton(
                padding: EdgeInsets.all(4.0),
                constraints: BoxConstraints(),
                onPressed: () {
                  // TODO: Implement the logic for incrementing the habit progress
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
      ),
    );
  }
}
