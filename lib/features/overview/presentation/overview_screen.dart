import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/overview_controller.dart';
import 'widgets/chart_section.dart';
import 'widgets/month_picker.dart';
import 'widgets/stat_card.dart';

class OverviewScreen extends ConsumerWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final monthNotifier = ref.read(selectedMonthProvider.notifier);
    final selectedMonth = ref.watch(selectedMonthProvider);
    final overviewController = ref.watch(overviewControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.cardTheme.color,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color:
                  theme.colorScheme.onSurface.withAlpha((0.72 * 255).round()),
              size: 20),
          onPressed: () => monthNotifier.previousMonth(),
        ),
        title: InkWell(
          onTap: () async {
            final now = DateTime.now();
            final pickedDate = await showMonthPicker(
                context: context,
                initialDate: selectedMonth,
                firstDate: DateTime(now.year - 5, 1),
                lastDate: DateTime(now.year + 5, 12));

            if (pickedDate != null) {
              monthNotifier.updateSelectedMonth(pickedDate);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_month_outlined,
                  color: theme.colorScheme.onSurface
                      .withAlpha((0.72 * 255).round()),
                  size: 22),
              const SizedBox(width: 8),
              Text(monthNotifier.getFormattedMonth(),
                  style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface
                          .withAlpha((0.72 * 255).round())))
            ],
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_forward_ios,
                  color: theme.colorScheme.onSurface
                      .withAlpha((0.72 * 255).round()),
                  size: 20),
              onPressed: () => monthNotifier.nextMonth())
        ],
        centerTitle: true,
      ),
      body: overviewController.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: theme.colorScheme.primary),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.error)),
        ),
        data: (stats) => SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Build Stats Cards
              Row(
                children: [
                  Expanded(
                      child: StatCard(
                    iconWidget: Icon(Icons.summarize_outlined,
                        color: theme.colorScheme.primary, size: 20),
                    title: "Total",
                    amount: stats.totalHabits.toString(),
                    isHighlighted: false,
                  )),
                  const SizedBox(width: 12),
                  Expanded(
                      child: StatCard(
                    iconWidget: Icon(Icons.check_circle_outline,
                        color: theme.colorScheme.primary, size: 20),
                    title: "Rate",
                    amount:
                        '${stats.totalHabits != 0 ? (stats.completedHabits / stats.totalHabits * 100).round() : 0}% (${stats.completedHabits}/${stats.totalHabits})',
                    isHighlighted: false,
                  )),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: StatCard(
                    iconWidget: Icon(Icons.timer,
                        color: theme.colorScheme.primary, size: 20),
                    title: "Complete",
                    amount: stats.completeTypeHabits.toString(),
                    isHighlighted: false,
                  )),
                  const SizedBox(width: 12),
                  Expanded(
                      child: StatCard(
                    iconWidget: Icon(Icons.hourglass_empty,
                        color: theme.colorScheme.primary, size: 20),
                    title: "Progress",
                    amount: stats.progressTypeHabits.toString(),
                    isHighlighted: false,
                  )),
                ],
              ),
              const SizedBox(height: 16),

              /// Build Chart Section
              const ChartSection(),
            ],
          ),
        ),
      ),
    );
  }
}
