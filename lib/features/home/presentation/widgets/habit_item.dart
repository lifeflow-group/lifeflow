import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../data/domain/models/habit.dart';
import '../../../../shared/actions/habit_actions.dart';

class HabitItem extends ConsumerWidget {
  const HabitItem({
    super.key,
    required this.habit,
    this.colorBackground,
    this.colorBorder,
    this.controllerInvalidate,
  });

  final Habit habit;
  final Color? colorBackground;
  final Color? colorBorder;
  final VoidCallback? controllerInvalidate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          color: colorBackground ?? Theme.of(context).cardTheme.color,
          border:
              Border.all(color: colorBorder ?? Colors.transparent, width: 0.5),
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () async {
          await context.push('/habit-view', extra: {'habit': habit});
          // Invalidate controller after navigating to habit view
          controllerInvalidate?.call();
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
                child: Checkbox(
                  value: habit.isCompleted ?? false,
                  shape: CircleBorder(),
                  onChanged: (value) async {
                    final result = await recordHabitCompletion(ref, habit);
                    if (result) {
                      // If completion was successful, invalidate controller
                      controllerInvalidate?.call();
                    }
                  },
                ),
              )
            : SizedBox(
                width: 27,
                child: IconButton(
                  padding: EdgeInsets.all(4.0),
                  constraints: BoxConstraints(),
                  onPressed: () async {
                    final result =
                        await recordHabitProgress(context, ref, habit);
                    if (result != null) {
                      // If progress was recorded, invalidate controller
                      controllerInvalidate?.call();
                    }
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
