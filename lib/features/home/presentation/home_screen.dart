import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lifeflow/data/models/habit.dart';

import '../state/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(filteredHabitsProvider);

    return Scaffold(
      body: Column(
        children: [
          _DateSelector(),
          SizedBox(height: 8),
          Expanded(
            child: habits.isEmpty
                ? Center(child: Text("No habits scheduled for this day."))
                : ListView.builder(
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      final habit = habits[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(12.0)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        padding: EdgeInsets.all(4.0),
                        child: ListTile(
                          title: Text(habit.name),
                          subtitle: Text(habit.trackingType ==
                                  TrackingType.complete
                              ? DateFormat('HH:mm')
                                  .format(habit.startDate.toLocal())
                              : '${habit.progress ?? 0}/${habit.quantity} ${habit.unit}'),
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
                                  icon: Icon(Icons.add_circle_outline)),
                        ),
                      );
                    },
                  ),
          ),
          SizedBox(height: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement logic to Navigate to the add new habit screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _DateSelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final notifier = ref.read(selectedDateProvider.notifier);
    final startOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));

    return Container(
      color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  notifier.state = selectedDate.subtract(Duration(days: 7));
                },
              ),
              Text(
                DateFormat('MMMM yyyy').format(selectedDate),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  notifier.state = selectedDate.add(Duration(days: 7));
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                final date = startOfWeek.add(Duration(days: index));
                final isSelected = DateFormat('yyyy-MM-dd').format(date) ==
                    DateFormat('yyyy-MM-dd').format(selectedDate);

                return GestureDetector(
                  onTap: () => notifier.state = date,
                  child: Container(
                    width: 45,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat.E().format(date),
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(height: 5),
                        Text(
                          date.day.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
