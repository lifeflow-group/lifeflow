import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_category.dart';
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
                  final selectedCategory =
                      await _showCategoryBottomSheet(context);
                  if (selectedCategory != null) {
                    controller.updateHabitCategory(selectedCategory);
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
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
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
                  final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: ref.read(habitTimeProvider),
                      initialEntryMode: TimePickerEntryMode.input);
                  if (pickedTime != null) {
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
                  final selectedFrequency =
                      await _showRepeatFrequencyBottomSheet(context);
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
                        getRepeatFrequencyLabel(
                            context, ref.watch(habitRepeatFrequencyProvider)),
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
                              onPressed: () =>
                                  _showProgressDialog(context, ref),
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
                        ? () async {
                            final Habit? habitResult;
                            if (isEditing) {
                              habitResult = await controller.updateHabit(
                                  habit!, () => showScopeDialog(context));
                            } else {
                              habitResult = await controller.createHabit();
                            }
                            if (context.mounted) {
                              context.pop(habitResult);
                            }
                          }
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

  Future<HabitCategory?> _showCategoryBottomSheet(BuildContext context) async {
    return await showModalBottomSheet<HabitCategory>(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return CategoryBottomSheet();
      },
    );
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
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancelButton),
            ),
            TextButton(
              onPressed: () {
                controller.updateHabitTargetValue(
                    int.tryParse(targetValueController.text) ?? 0);
                controller.updateHabitUnit(unitController.text);
                Navigator.pop(context);
              },
              child: Text(l10n.saveButton),
            ),
          ],
        );
      },
    );
  }

  Future<RepeatFrequency?> _showRepeatFrequencyBottomSheet(
      BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    return await showModalBottomSheet<RepeatFrequency>(
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
                  SizedBox(width: 54),
                  Text(l10n.selectRepeatSheetTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Container(
                    width: 54,
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        icon: Icon(Icons.close, color: Colors.grey),
                        onPressed: () => Navigator.pop(context)),
                  ),
                ],
              ),
              ListTile(
                title: Text(l10n.noRepeatLabel,
                    style: Theme.of(context).textTheme.titleMedium),
                onTap: () => Navigator.pop(context, null),
                contentPadding: EdgeInsets.only(left: 22.0),
              ),
              ...RepeatFrequency.values.map((frequency) {
                return ListTile(
                  title: Text(getRepeatFrequencyLabel(context, frequency),
                      style: Theme.of(context).textTheme.titleMedium),
                  onTap: () => Navigator.pop(context, frequency),
                  contentPadding: EdgeInsets.only(left: 22.0),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
