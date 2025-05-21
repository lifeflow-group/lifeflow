import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/actions/habit_actions.dart';
import '../controllers/home_controller.dart';
import 'widgets/date_selector.dart';
import 'widgets/habit_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final habitsAsync = ref.watch(homeControllerProvider);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            DateSelector(),
            const SizedBox(height: 8),
            habitsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(l10n.errorMessage(error.toString())),
              ),
              data: (habits) {
                if (habits.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        l10n.noHabitsMessage,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
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
                                      Text(l10n.deleteButton,
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
