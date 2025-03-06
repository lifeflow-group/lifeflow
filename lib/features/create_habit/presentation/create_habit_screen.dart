import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/models/habit_category.dart';
import '../controllers/create_habit_controller.dart';
import 'widgets/category_bottom_sheet.dart';

class CreateHabitScreen extends ConsumerWidget {
  const CreateHabitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitName = ref.watch(habitNameProvider);
    final habitCategory = ref.watch(habitCategoryProvider);
    final selectedDate = ref.watch(habitDateProvider);
    final controller = ref.read(createHabitControllerProvider);
    final isFormValid = habitName.isNotEmpty && habitCategory != null;

    return Scaffold(
      appBar: AppBar(title: const Text("Create Habit")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
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
                                    ? Theme.of(context).colorScheme.onSecondary
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
                  labelText: "Select Start Date",
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    Icon(Icons.calendar_today,
                        color: Theme.of(context).colorScheme.onSurface),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Select time
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    Icon(Icons.access_time,
                        color: Theme.of(context).colorScheme.onSurface),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                  onPressed: isFormValid
                      ? () async {
                          final habit = await controller.saveHabit();
                          if (context.mounted) {
                            context.pop(habit);
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
}
