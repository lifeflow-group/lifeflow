import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';
import 'widgets/delete_scope_dialog.dart';
import 'widgets/habit_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(homeControllerProvider);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _DateSelector(),
            const SizedBox(height: 8),
            habitsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
              data: (habits) {
                if (habits.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        "No habits yet. Tap '+' to add your habit!",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      final habit = habits[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Slidable(
                          key: ValueKey(habit.id),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            extentRatio: 0.25,
                            children: [
                              CustomSlidableAction(
                                onPressed: (context) =>
                                    handleDeleteHabit(context, ref, habit),
                                padding: const EdgeInsets.all(0),
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete),
                                      const SizedBox(width: 8),
                                      Text('Delete',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          child: HabitItem(habit: habit),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final newHabit = await context.push('/habit-detail');
            if (newHabit == null) return;
            // Re-fetch the homeControllerProvider (auto triggers build())
            ref.invalidate(homeControllerProvider);
          },
          child: const Icon(Icons.add),
        ),
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
                  notifier.updateSelectedDate(
                      selectedDate.subtract(Duration(days: 7)));
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
                  notifier
                      .updateSelectedDate(selectedDate.add(Duration(days: 7)));
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
                final isSelected = date.year == selectedDate.year &&
                    date.month == selectedDate.month &&
                    date.day == selectedDate.day;

                return GestureDetector(
                  onTap: () => notifier.updateSelectedDate(date),
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
                                          .onSurface),
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
