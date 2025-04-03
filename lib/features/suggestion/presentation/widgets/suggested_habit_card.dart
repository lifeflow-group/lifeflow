import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/domain/models/habit.dart';
import '../../../../data/domain/models/habit_analysis_input.dart';

class SuggestedHabitCard extends StatelessWidget {
  final HabitData habit;

  const SuggestedHabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              color: Theme.of(context).colorScheme.secondary,
            ),
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 12.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Image.asset(habit.category.iconPath,
                      width: 24, height: 24),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(habit.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4.0),
                      Text(
                        habit.trackingType == TrackingType.complete
                            ? DateFormat('HH:mm')
                                .format(habit.startDate.toLocal())
                            : '${habit.targetValue} ${habit.unit}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                habit.trackingType == TrackingType.complete
                    ? Radio<bool>(
                        value: false,
                        groupValue: null,
                        onChanged: (bool? value) {},
                      )
                    : Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.add_circle_outline,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
              ],
            ),
          ),
          Container(
            height: 36.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0)),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: Center(
              child: Text(
                _buildSubtitle(habit),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build subtitle text dynamically
  String _buildSubtitle(HabitData habit) {
    String repeatText = "Repeats every ${habit.repeatFrequency?.name}.";
    String reminderText =
        habit.reminderEnabled ? "Has Reminder." : "No Reminder.";
    return "$repeatText $reminderText";
  }
}
