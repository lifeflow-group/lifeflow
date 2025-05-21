import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/controllers/habit_controller.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/scheduled_notification.dart';
import '../../../shared/actions/habit_actions.dart';
import '../../../shared/widgets/enter_number_dialog.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/habit_detail_controller.dart';
import 'widgets/view_row.dart';

class HabitViewScreen extends ConsumerStatefulWidget {
  const HabitViewScreen({super.key, this.habit, this.scheduledNotification});
  final Habit? habit;
  final ScheduledNotification? scheduledNotification;

  @override
  ConsumerState<HabitViewScreen> createState() => _HabitViewScreenState();
}

class _HabitViewScreenState extends ConsumerState<HabitViewScreen> {
  HabitDetailController get controller =>
      ref.read(habitDetailControllerProvider);

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (widget.habit == null && widget.scheduledNotification == null) {
        controller.resetForm();
      } else if (widget.habit != null) {
        await controller.fromHabit(widget.habit!);
      } else if (widget.scheduledNotification != null) {
        await controller
            .loadHabitFromNotification(widget.scheduledNotification!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final habit = ref.watch(habitProvider);
    final repeat = getRepeatFrequencyLabel(
        context, ref.watch(habitRepeatFrequencyProvider));
    final date = DateFormat('dd/MM/yyyy').format(ref.watch(habitDateProvider));
    final time = ref.watch(habitTimeProvider).format(context);
    final isCompleted = ref.watch(habitIsCompletedProvider);
    final currentValue = ref.watch(habitCurrentValueProvider);
    final habitName = ref.watch(habitNameProvider);
    final habitCategory = ref.watch(habitCategoryProvider);
    final trackingType = ref.watch(habitTrackingTypeProvider);
    final targetValue = ref.watch(habitTargetValueProvider);
    final unit = ref.watch(habitUnitProvider);
    final habitReminder = ref.watch(habitReminderProvider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () => context.pop(),
            color: Theme.of(context).colorScheme.onSurface),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: trackingType == TrackingType.progress
            ? TextButton(
                onPressed: () => _handelUpdateCurrentValue(
                    context: context,
                    habit: habit,
                    currentValue: currentValue,
                    ref: ref),
                child: Text(
                  trackingType == TrackingType.progress
                      ? l10n.progressFormat(currentValue, targetValue, unit)
                      : '',
                  style: Theme.of(context).textTheme.titleMedium,
                ))
            : null,
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: 5.0),
        actions: [
          trackingType == TrackingType.complete
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
                child: Text(habitName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w500))),
            ViewRow(
                label: l10n.categoryLabel,
                valueText: habitCategory?.getLocalizedName(context) ?? '',
                valueIcon: habitCategory != null
                    ? Image.asset(habitCategory.iconPath, width: 24, height: 24)
                    : null),
            ViewRow(label: l10n.dateLabel, valueText: date),
            ViewRow(label: l10n.timeViewLabel, valueText: time),
            ViewRow(label: l10n.repeatViewLabel, valueText: repeat),
            ViewRow(
                label: l10n.reminderLabel,
                valueText:
                    habitReminder ? l10n.enabledLabel : l10n.disabledLabel),
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
                            await handleDeleteHabit(context, ref, habit);
                        if (isDeleted && context.mounted) context.pop();
                      },
                      child: Text(l10n.deleteButton,
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
                      child: Text(l10n.editButton,
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
    final l10n = AppLocalizations.of(context)!;

    if (habit == null) return;
    final newValue = await showDialog<int?>(
        context: context,
        builder: (context) => EnterNumberDialog(
            currentValue: currentValue, title: l10n.updateProgressTitle));
    if (newValue == null) return;

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
