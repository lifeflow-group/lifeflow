import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_category.dart';
import '../controllers/habit_detail_controller.dart';
import 'widgets/category_bottom_sheet.dart';
import 'widgets/edit_scope_dialog.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habitName = ref.watch(habitNameProvider);
    final habitCategory = ref.watch(habitCategoryProvider);
    final selectedDate = ref.watch(habitDateProvider);
    final habitTrackingType = ref.watch(habitTrackingTypeProvider);
    final habitQuantity = ref.watch(habitQuantityProvider);
    final habitUnit = ref.watch(habitUnitProvider);
    final habitReminder = ref.watch(habitReminderProvider);
    final isFormValid = habitName.isNotEmpty && habitCategory != null;

    return Scaffold(
      appBar: AppBar(title: const Text("Create Habit")),
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
                  labelText: "Habit Name",
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
                    labelText: "Select Category",
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
                            habitCategory?.label ?? "Select a category",
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
                    labelText: "Select Date",
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
                    labelText: "Time",
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
                    labelText: "Repeat",
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
                        _getRepeatFrequencyLabel(
                            ref.watch(habitRepeatFrequencyProvider), context),
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
                  labelText: "Tracking Type",
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
                            title: Text("Complete",
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
                            title: Text("Progress",
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
                                  habitQuantity == 0 &&
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
                            Text(
                                "Goal: $habitQuantity ${habitUnit.isNotEmpty ? habitUnit : 'unit'}"),
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
                title: Text("Enable Notifications",
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
                                  habit!, () => showEditScopeDialog(context));
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
                      "Save Habit",
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
    final controller = ref.read(habitDetailControllerProvider);
    final quantityController =
        TextEditingController(text: ref.read(habitQuantityProvider).toString());
    final unitController =
        TextEditingController(text: ref.read(habitUnitProvider));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Set Progress Goal"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Quantity"),
                onChanged: (value) {
                  final quantity = int.tryParse(value) ?? 0;
                  controller.updateHabitQuantity(quantity);
                },
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: unitController,
                decoration: const InputDecoration(labelText: "Unit"),
                onChanged: (value) {
                  controller.updateHabitUnit(value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.updateHabitQuantity(
                    int.tryParse(quantityController.text) ?? 0);
                controller.updateHabitUnit(unitController.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  String _getRepeatFrequencyLabel(
      RepeatFrequency? frequency, BuildContext context) {
    if (frequency == null) {
      return "No Repeat";
    }
    final label = frequency.toString().split('.').last;
    return label[0].toUpperCase() + label.substring(1);
  }

  Future<RepeatFrequency?> _showRepeatFrequencyBottomSheet(
      BuildContext context) async {
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
                  Text("Select Repeat",
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
                title: Text("No Repeat",
                    style: Theme.of(context).textTheme.titleMedium),
                onTap: () => Navigator.pop(context, null),
                contentPadding: EdgeInsets.only(left: 22.0),
              ),
              ...RepeatFrequency.values.map((frequency) {
                final label = frequency.toString().split('.').last;
                return ListTile(
                  title: Text(label[0].toUpperCase() + label.substring(1),
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
