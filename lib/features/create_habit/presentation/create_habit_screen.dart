import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/habit_category.dart';
import '../controllers/create_habit_controller.dart';
import 'widgets/category_bottom_sheet.dart';

class CreateHabitScreen extends ConsumerWidget {
  const CreateHabitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitName = ref.watch(habitNameProvider);
    final habitCategory = ref.watch(habitCategoryProvider);
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
                border: OutlineInputBorder(),
                labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              onChanged: controller.updateHabitName,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                final selectedCategory =
                    await _showCategoryBottomSheet(context);
                if (selectedCategory != null) {
                  controller.updateHabitCategory(selectedCategory);
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Select Category",
                  border: OutlineInputBorder(),
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
            const SizedBox(height: 20),
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
