import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import '../../home/presentation/widgets/delete_scope_dialog.dart';
import '../controllers/habit_detail_controller.dart';
import 'widgets/view_row.dart';

class HabitViewScreen extends ConsumerStatefulWidget {
  const HabitViewScreen({super.key, this.habit});
  final Habit? habit;

  @override
  ConsumerState<HabitViewScreen> createState() => _HabitViewScreenState();
}

class _HabitViewScreenState extends ConsumerState<HabitViewScreen> {
  HabitDetailController get controller =>
      ref.read(habitDetailControllerProvider);
  Habit? get habit => widget.habit;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (habit == null) {
        controller.resetForm();
      } else {
        await controller.fromHabit(habit!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final repeat =
        getRepeatFrequencyLabel(ref.watch(habitRepeatFrequencyProvider));
    final date = DateFormat('dd/MM/yyyy').format(ref.watch(habitDateProvider));
    final time = ref.watch(habitTimeProvider).format(context);

    return Scaffold(
      // Habit name as the title
      appBar: AppBar(
          title: Text(habit?.name ?? ''), centerTitle: true, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewRow(
                label: "Category",
                valueText: habit?.category.label ?? '',
                valueIcon: habit != null
                    ? Image.asset(habit!.category.iconPath,
                        width: 24, height: 24)
                    : null),
            ViewRow(label: "Date", valueText: date),
            ViewRow(label: "Time", valueText: time),
            ViewRow(label: "Repeat", valueText: repeat),
            ViewRow(
                label: "Reminder",
                valueText: habit == null
                    ? ''
                    : habit!.reminderEnabled
                        ? "Enabled"
                        : "Disabled"),
            const SizedBox(height: 16),
            Container(
              color:
                  Theme.of(context).colorScheme.shadow.withValues(alpha: 0.015),
              height: 45,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12)),
                      onPressed: () async {
                        if (habit == null) return;
                        final isDeleted =
                            await handleDeleteHabit(context, ref, habit!);
                        if (isDeleted && context.mounted) context.pop();
                      },
                      child: Text("Delete",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ),
                  Container(
                      width: 1.2,
                      color: Theme.of(context).colorScheme.onPrimary,
                      margin: EdgeInsets.symmetric(vertical: 8)),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12)),
                      onPressed: () async {
                        final result =
                            await context.push('/habit-detail', extra: habit);
                        if (context.mounted) {
                          context.pop(result);
                        }
                      },
                      child: Text("Edit",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
