import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/domain/models/habit_category.dart';
import '../../controllers/category_habit_analytics_controller.dart';
import '../widgets/habit_list_with_date_headers.dart';
import '../widgets/month_picker.dart';
import '../widgets/stat_card.dart';
import '../widgets/filter_chip_button.dart';
import '../widgets/ranked_item_list.dart';

enum CategoryDetailFilterType {
  all,
  mostFrequent,
  topPerformed,
}

class CategoryHabitAnalyticsScreen extends ConsumerWidget {
  final HabitCategory category;
  final DateTime month;

  const CategoryHabitAnalyticsScreen(
      {super.key, required this.category, required this.month});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Use controller with family provider
    final controller = ref.watch(categoryHabitAnalyticsControllerProvider(
        (category: category, initialMonth: month)));

    final notifier = ref.read(categoryHabitAnalyticsControllerProvider(
        (category: category, initialMonth: month)).notifier);

    // Get data from controller state
    final selectedMonth = controller.selectedMonth;
    final habitsList = controller.habits;
    final isLoading = controller.isLoading;
    final errorMessage = controller.errorMessage;

    // Format month based on current locale
    final monthName = formatDateWithUserLanguage(ref, selectedMonth, 'MMMM');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        title: Text(category.name,
            style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton.icon(
            icon:
                Icon(Icons.calendar_month, color: theme.colorScheme.onSurface),
            label: Text(monthName,
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: theme.colorScheme.onSurface)),
            onPressed: () async {
              final monthSelected = await showMonthPicker(
                  context: context, initialDate: selectedMonth);
              if (monthSelected != null) {
                notifier.changeMonth(monthSelected);
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(l10n.errorMessage(errorMessage)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              iconWidget: Icon(Icons.summarize_outlined,
                                  color: theme.colorScheme.primary, size: 20),
                              title: l10n.totalHabits,
                              amount: notifier.totalHabits.toString(),
                              isHighlighted: false,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              iconWidget: Icon(Icons.check_circle_outline,
                                  color: theme.colorScheme.primary, size: 20),
                              title: l10n.completionRate,
                              amount: '${notifier.completionRate.toInt()} %',
                              isHighlighted: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Filter chips
                      Wrap(
                        spacing: 8,
                        children: [
                          FilterChipButton(
                            label: l10n.filterAll,
                            isSelected: controller.currentFilter ==
                                CategoryDetailFilterType.all,
                            filterType: CategoryDetailFilterType.all,
                            onFilterChange: (filterType) =>
                                notifier.changeFilter(filterType),
                          ),
                          FilterChipButton(
                            label: l10n.filterMostFrequent,
                            isSelected: controller.currentFilter ==
                                CategoryDetailFilterType.mostFrequent,
                            filterType: CategoryDetailFilterType.mostFrequent,
                            onFilterChange: (filterType) =>
                                notifier.changeFilter(filterType),
                          ),
                          FilterChipButton(
                            label: l10n.filterTopPerformed,
                            isSelected: controller.currentFilter ==
                                CategoryDetailFilterType.topPerformed,
                            filterType: CategoryDetailFilterType.topPerformed,
                            onFilterChange: (filterType) =>
                                notifier.changeFilter(filterType),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      if (habitsList.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(l10n.noHabitsInCategory(monthName),
                                style: theme.textTheme.bodyLarge),
                          ),
                        )
                      else if (controller.currentFilter ==
                          CategoryDetailFilterType.all)
                        // Habit list grouped by date
                        HabitListWithDateHeaders(
                            habits: habitsList,
                            // Reload habits
                            controllerInvalidate: () =>
                                notifier.loadHabitsForMonth(selectedMonth))
                      else if (controller.currentFilter ==
                          CategoryDetailFilterType.mostFrequent)
                        RankedItemList(items: notifier.mostFrequentList)
                      else if (controller.currentFilter ==
                          CategoryDetailFilterType.topPerformed)
                        RankedItemList(items: notifier.topPerformedList),
                    ],
                  ),
                ),
    );
  }
}
