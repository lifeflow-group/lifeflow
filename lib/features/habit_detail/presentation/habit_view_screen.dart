import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/controllers/habit_controller.dart';
import '../../../data/domain/models/habit.dart';
import '../../../shared/actions/habit_actions.dart';
import '../../../shared/widgets/enter_number_dialog.dart';
import '../../home/controllers/home_controller.dart';
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
    final isCompleted = ref.watch(habitIsCompletedProvider);
    final currentValue = ref.watch(habitCurrentValueProvider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () => context.pop(),
            color: Theme.of(context).colorScheme.onSurface),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: habit?.trackingType == TrackingType.progress
            ? TextButton(
                onPressed: () => _handelUpdateCurrentValue(
                    context: context,
                    habit: habit,
                    currentValue: currentValue,
                    ref: ref),
                child: Text(
                  habit?.trackingType == TrackingType.progress
                      ? '$currentValue/${habit?.targetValue} ${habit?.unit}'
                      : '',
                  style: Theme.of(context).textTheme.titleMedium,
                ))
            : null,
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: 5.0),
        actions: [
          habit?.trackingType == TrackingType.complete
              ? Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                      value: isCompleted,
                      shape: CircleBorder(),
                      side: WidgetStateBorderSide.resolveWith(
                        (states) => BorderSide(
                          width: isCompleted ? 4.0 : 2.0,
                          color: isCompleted
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        ),
                      ),
                      onChanged: (value) async {
                        final result = await recordHabitCompletion(ref, habit!);
                        if (result == false) return;
                        controller.updateHabitIsCompleted(!isCompleted);
                      }),
                )
              : IconButton(
                  padding: EdgeInsets.all(4.0),
                  constraints: BoxConstraints(),
                  onPressed: () async {
                    final currentValue =
                        await recordHabitProgress(context, ref, habit!);
                    if (currentValue == null) return;
                    controller.updateHabitCurrentValue(currentValue);
                  },
                  icon: Icon(Icons.add_circle_outline,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 12.0),
                child: Text(habit?.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w500))),
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

  Future<void> _handelUpdateCurrentValue({
    required BuildContext context,
    required WidgetRef ref,
    required Habit? habit,
    required int currentValue,
  }) async {
    if (habit == null) return;
    final newValue = await showDialog<int?>(
        context: context,
        builder: (context) => EnterNumberDialog(
            currentValue: currentValue, title: 'Update Progress'));
    if (newValue == null) return;
    print('New value: $newValue');

    final controllerProvider = ref.read(habitControllerProvider);
    final startDate = habit.startDate.toLocal();
    final date = DateTime(startDate.year, startDate.month, startDate.day);
    await controllerProvider.recordHabit(
        habit: habit,
        selectedDate: date,
        isCompleted: newValue >= (habit.targetValue ?? 1),
        currentValue: newValue);

    controller.updateHabitCurrentValue(newValue);
    ref.invalidate(homeControllerProvider);
  }
}
