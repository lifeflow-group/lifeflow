import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/domain/models/habit_category.dart';
import '../../../data/services/analytics/analytics_service.dart';
import '../../../shared/actions/habit_actions.dart';
import '../../habit_detail/presentation/widgets/category_bottom_sheet.dart';
import '../controllers/home_controller.dart';
import 'widgets/date_selector.dart';
import 'widgets/habit_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final habitsAsync = ref.watch(homeControllerProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final controller = ref.read(homeControllerProvider.notifier);
    final analyticsService = ref.read(analyticsServiceProvider);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            DateSelector(),
            const SizedBox(height: 12),

            /// Category Filter Chip
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 12.0),
              child: FilterChip(
                label: Text(
                  selectedCategory != null
                      ? selectedCategory.getLocalizedName(context)
                      : l10n.filterByCategoryLabel,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface.withAlpha(180)),
                ),
                selected: selectedCategory != null,
                onSelected: (_) => _handleCategoryFilter(context, ref),
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                selectedColor: theme.colorScheme.primary.withAlpha(60),
                checkmarkColor: theme.colorScheme.onSurface.withAlpha(120),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 8),

            /// Habits List
            habitsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  Center(child: Text(l10n.errorMessage(error.toString()))),
              data: (habits) {
                if (habits.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedCategory != null
                                ? l10n.noHabitsInCategoryMessage
                                : l10n.noHabitsMessage,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          if (selectedCategory != null) ...[
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                analyticsService
                                    .trackHomeEmptyStateAllHabitsClicked();
                                controller.clearCategoryFilter();
                              },
                              child: Text(l10n.showAllHabitsButton),
                            ),
                          ],
                        ],
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
                                onPressed: (context) {
                                  analyticsService.trackHomeHabitDeleteAttempt(
                                      habit.id,
                                      habit.name,
                                      habit.category.name);
                                  handleDeleteHabit(context, ref, habit);
                                },
                                padding: const EdgeInsets.all(0),
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.error,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete),
                                      const SizedBox(width: 8),
                                      Text(l10n.deleteButton,
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  color: theme
                                                      .colorScheme.onPrimary)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              analyticsService.trackHomeHabitViewed(
                                  habit.id,
                                  habit.name,
                                  habit.category.name,
                                  habit.trackingType.toString());
                              context.goNamed('habit-view',
                                  extra: {'habit': habit});
                            },
                            child: HabitItem(
                                habit: habit,
                                controllerInvalidate: () =>
                                    ref.invalidate(homeControllerProvider)),
                          ),
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
            analyticsService.trackHomeAddHabitInitiated();

            final newHabit = await context.pushNamed('habit-detail');
            if (newHabit == null) return;

            // Re-fetch the homeControllerProvider (auto triggers build())
            ref.invalidate(homeControllerProvider);

            analyticsService.trackHomeHabitCreated();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _handleCategoryFilter(
      BuildContext context, WidgetRef ref) async {
    final controller = ref.read(homeControllerProvider.notifier);
    final currentCategory = ref.read(selectedCategoryProvider);
    final analyticsService = ref.read(analyticsServiceProvider);

    analyticsService.trackHomeCategoryFilterOpened(currentCategory?.name);

    final result = await showCategoryBottomSheet(context,
        initialCategory: currentCategory);

    if (result == null) return;
    if (result is String && result == "clear") {
      // Clear category filter
      controller.clearCategoryFilter();
    } else if (result is HabitCategory) {
      // Apply category filter
      controller.filterByCategory(result);
    }
  }
}
