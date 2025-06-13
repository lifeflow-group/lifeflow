import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_category.dart';
import '../../../data/services/analytics/analytics_service.dart';
import '../../../shared/widgets/scope_dialog.dart';
import '../controllers/habit_detail_controller.dart';
import 'widgets/category_bottom_sheet.dart';

class HabitDetailScreen extends ConsumerStatefulWidget {
  const HabitDetailScreen({super.key, this.habit});

  final Habit? habit;

  @override
  ConsumerState<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends ConsumerState<HabitDetailScreen> {
  HabitDetailController get controller =>
      ref.read(habitDetailControllerProvider);
  AnalyticsService get _analyticsService => ref.read(analyticsServiceProvider);
  TextEditingController nameController = TextEditingController();
  final focusNode = FocusNode();
  Habit? get habit => widget.habit;
  bool get isEditing => habit != null;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (habit == null) {
        controller.resetForm();
      } else {
        nameController.text = habit!.name;
        await controller.fromHabit(habit!);
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final habitName = ref.watch(habitNameProvider);
    final habitCategory = ref.watch(habitCategoryProvider);
    final selectedDate = ref.watch(habitDateProvider);
    final repeatFrequency = ref.watch(habitRepeatFrequencyProvider);
    final habitTrackingType = ref.watch(habitTrackingTypeProvider);
    final habitTargetValue = ref.watch(habitTargetValueProvider);
    final habitUnit = ref.watch(habitUnitProvider);
    final habitReminder = ref.watch(habitReminderProvider);
    final isFormValid = habitName.isNotEmpty && habitCategory != null;

    return Scaffold(
      appBar: AppBar(
          title: Text(isEditing ? l10n.editHabitTitle : l10n.createHabitTitle)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Habit Name
              TextField(
                controller: nameController,
                focusNode: focusNode,
                onTapOutside: (event) => focusNode.unfocus(),
                decoration: InputDecoration(
                  labelText: l10n.habitNameLabel,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSecondary,
                        width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 0.5)),
                  labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
                onChanged: controller.updateHabitName,
              ),
              const SizedBox(height: 16.0),

              /// Select Category
              InkWell(
                onTap: () async {
                  _analyticsService
                      .trackCategorySelectorOpened(habitCategory?.name);

                  final category = await showCategoryBottomSheet(context,
                      initialCategory: habitCategory);

                  if (category == null) return;
                  if (category is String && category == "clear") {
                    _analyticsService.trackCategoryCleared(habitCategory?.name);
                    controller.updateHabitCategory(null);
                  } else if (category is HabitCategory) {
                    _analyticsService.trackCategorySelected(category.name);
                    controller.updateHabitCategory(category);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.selectCategoryLabel,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (habitCategory != null) ...[
                            Image.asset(habitCategory.iconPath,
                                width: 24, height: 24),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            habitCategory?.getLocalizedName(context) ??
                                l10n.selectACategoryDefault,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: habitCategory == null
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right_rounded,
                          color: Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              /// Select Date
              InkWell(
                onTap: () async {
                  _analyticsService.trackDatePickerOpened(selectedDate);

                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _analyticsService.trackDateSelected(pickedDate);
                    controller.updateHabitDate(pickedDate);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.selectDateLabel,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy').format(selectedDate),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Icon(Icons.calendar_today,
                          color: Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// Select time
              InkWell(
                onTap: () async {
                  // Use controller to track time picker opened
                  _analyticsService.trackTimePickerOpened(
                    ref.read(habitTimeProvider).format(context),
                  );

                  final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: ref.read(habitTimeProvider),
                      initialEntryMode: TimePickerEntryMode.input);
                  if (pickedTime != null) {
                    if (context.mounted) {
                      // Use controller to track time selected
                      _analyticsService
                          .trackTimeSelected(pickedTime.format(context));
                    }
                    controller.updateHabitTime(pickedTime);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.timeLabel,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ref.watch(habitTimeProvider).format(context),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Icon(Icons.access_time,
                          color: Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              /// Select Repeat Frequency
              InkWell(
                onTap: () async {
                  // Use controller to track repeat frequency selector opened
                  _analyticsService.trackRepeatFrequencyOpened(
                      ref.read(habitRepeatFrequencyProvider)?.name);

                  final selectedFrequency =
                      await _showRepeatFrequencyBottomSheet(
                          context, repeatFrequency);

                  if (selectedFrequency != null) {
                    // Use controller to track repeat frequency selected
                    _analyticsService
                        .trackRepeatFrequencySelected(selectedFrequency.name);
                  } else {
                    // Use controller to track repeat frequency cleared
                    _analyticsService.trackRepeatFrequencyCleared();
                  }

                  controller.updateHabitRepeatFrequency(selectedFrequency);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.repeatLabel,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getRepeatFrequencyLabel(context, repeatFrequency),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      Icon(Icons.chevron_right_rounded,
                          color: Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              /// Select Tracking Type
              InputDecorator(
                decoration: InputDecoration(
                  labelText: l10n.trackingTypeLabel,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSecondary,
                        width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 0.5)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<TrackingType>(
                            title: Text(l10n.trackingTypeComplete,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            value: TrackingType.complete,
                            groupValue: habitTrackingType,
                            onChanged: (value) {
                              if (value == null) return;

                              // Use controller to track tracking type changed
                              _analyticsService
                                  .trackTrackingTypeChanged('complete');

                              controller.updateTrackingType(value);
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<TrackingType>(
                            title: Text(l10n.trackingTypeProgress,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            value: TrackingType.progress,
                            groupValue: habitTrackingType,
                            onChanged: (value) {
                              if (value == null) return;

                              _analyticsService
                                  .trackTrackingTypeChanged(value.name);
                              controller.updateTrackingType(value);
                              if (value == TrackingType.progress &&
                                  habitTargetValue == 0 &&
                                  habitUnit == '') {
                                _showProgressDialog(context, ref);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    // --- Display Progress value if selected ---
                    if (habitTrackingType == TrackingType.progress)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.progressGoalLabel(
                                habitTargetValue.toString(),
                                habitUnit.isNotEmpty
                                    ? habitUnit
                                    : l10n.progressGoalUnitDefault)),
                            IconButton(
                              icon: const Icon(Icons.edit, size: 18),
                              onPressed: () {
                                // Use controller to track progress goal edit requested
                                _analyticsService
                                    .trackProgressGoalEditRequested(
                                        habitTargetValue, habitUnit);
                                _showProgressDialog(context, ref);
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),

              /// Toggle Reminder
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.enableNotificationsLabel,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                value: habitReminder,
                onChanged: (bool value) {
                  // Use controller to track reminder toggled
                  _analyticsService.trackReminderToggled(value);

                  controller.updateHabitReminder(value);
                },
              ),
              const SizedBox(height: 16.0),

              /// Save Habit
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                    onPressed: isFormValid
                        ? () => _finalizeAndPopResult(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFormValid
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardTheme.shadowColor,
                    ),
                    child: Text(
                      l10n.saveHabitButton,
                      style: TextStyle(
                          color: isFormValid
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _finalizeAndPopResult(BuildContext context) async {
    final result = await controller.generateHabitFormResult(
        widget.habit, () => showScopeDialog(context));

    if (result == null) return;

    if (context.mounted) {
      context.pop(result);
    }
  }

  void _showProgressDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final controller = ref.read(habitDetailControllerProvider);
    final targetValueController = TextEditingController(
        text: ref.read(habitTargetValueProvider).toString());
    final unitController =
        TextEditingController(text: ref.read(habitUnitProvider));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.setProgressGoalDialogTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: targetValueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: l10n.quantityLabel),
                onChanged: (value) {
                  final quantity = int.tryParse(value) ?? 0;
                  controller.updateHabitTargetValue(quantity);
                },
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: unitController,
                decoration: InputDecoration(labelText: l10n.unitLabel),
                onChanged: (value) {
                  controller.updateHabitUnit(value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Use controller to track progress goal dialog canceled
                _analyticsService.trackProgressGoalDialogCanceled();
                context.pop();
              },
              child: Text(l10n.cancelButton),
            ),
            TextButton(
              onPressed: () {
                final targetValue =
                    int.tryParse(targetValueController.text) ?? 0;
                final unitValue = unitController.text;

                // Use controller to track progress goal set
                _analyticsService.trackProgressGoalSet(targetValue, unitValue);

                controller.updateHabitTargetValue(targetValue);
                controller.updateHabitUnit(unitValue);
                context.pop();
              },
              child: Text(l10n.saveButton),
            ),
          ],
        );
      },
    );
  }

  Future<RepeatFrequency?> _showRepeatFrequencyBottomSheet(
      BuildContext context, RepeatFrequency? currentFrequency) async {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Create a special result to indicate cancellation
    final cancelResult = RepeatFrequency.values.length + 1;

    final result = await showModalBottomSheet<dynamic>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 54),
                  Text(l10n.selectRepeatSheetTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Container(
                    width: 54,
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          // Use controller to track repeat frequency sheet dismissed
                          _analyticsService
                              .trackRepeatFrequencySheetDismissed();

                          // Pop with cancelResult to indicate cancellation (no change)
                          context.pop(cancelResult);
                        }),
                  ),
                ],
              ),
              ListTile(
                title: Text(l10n.noRepeatLabel,
                    style: Theme.of(context).textTheme.titleMedium),
                onTap: () {
                  // Use controller to track repeat frequency none selected
                  _analyticsService.trackRepeatFrequencyNoneSelected();
                  context.pop(null);
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 22.0),
                // Show check icon if no frequency is currently selected
                trailing: currentFrequency == null
                    ? Icon(Icons.check, color: theme.colorScheme.primary)
                    : null,
              ),
              ...RepeatFrequency.values.map((frequency) {
                return ListTile(
                  title: Text(getRepeatFrequencyLabel(context, frequency),
                      style: Theme.of(context).textTheme.titleMedium),
                  onTap: () {
                    // Use controller to track repeat frequency option selected
                    _analyticsService
                        .trackRepeatFrequencyOptionSelected(frequency.name);
                    context.pop(frequency);
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 22.0),
                  // Show check icon if this frequency is currently selected
                  trailing: currentFrequency == frequency
                      ? Icon(Icons.check, color: theme.colorScheme.primary)
                      : null,
                );
              }),
            ],
          ),
        );
      },
    );

    // If user clicked the close button, return the current frequency (no change)
    if (result == cancelResult) {
      return currentFrequency;
    }

    // Otherwise return the selected result (either null for "No Repeat" or a RepeatFrequency)
    return result as RepeatFrequency?;
  }
}
