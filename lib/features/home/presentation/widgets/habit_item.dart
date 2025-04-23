import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../data/domain/models/habit.dart';
import '../../controllers/home_controller.dart';

class HabitItem extends ConsumerWidget {
  const HabitItem({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () async {
          final result = await context.push('/habit-view', extra: habit);
          if (result != null) {
            // If there are changes → refresh home
            ref.invalidate(homeControllerProvider);
          }
        },
        leading: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Image.asset(habit.category.iconPath, width: 32, height: 32)),
        title: Text(habit.name),
        subtitle: Text(
          habit.trackingType == TrackingType.complete
              ? DateFormat('HH:mm').format(habit.startDate.toLocal())
              : '${habit.currentValue ?? 0}/${habit.targetValue} ${habit.unit}',
        ),
        trailing: habit.trackingType == TrackingType.complete
            ? SizedBox(
                width: 20,
                child: Radio<bool>(
                  value: true,
                  groupValue: habit.isCompleted ?? false,
                  onChanged: (value) {
                    // TODO: Implement the onChanged logic for habit completion
                  },
                ),
              )
            : IconButton(
                padding: EdgeInsets.all(4.0),
                constraints: BoxConstraints(),
                onPressed: () {
                  // TODO: Implement the logic for incrementing the habit progress
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
