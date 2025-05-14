import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/overview_controller.dart';
import 'widgets/chart_section.dart';
import 'widgets/stat_card.dart';

class OverviewScreen extends ConsumerWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthNotifier = ref.read(selectedMonthProvider.notifier);
    final overviewController = ref.watch(overviewControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.3),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Colors.black.withValues(alpha: 90), size: 20),
          onPressed: () => monthNotifier.previousMonth(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today_outlined,
                color: Colors.black.withValues(alpha: 90), size: 22),
            const SizedBox(width: 8),
            Text(
              monthNotifier.getFormattedMonth(),
              style: TextStyle(
                color: Colors.black.withValues(alpha: 90),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward_ios,
                color: Colors.black.withValues(alpha: 90), size: 20),
            onPressed: () => monthNotifier.nextMonth(),
          ),
        ],
        centerTitle: true,
      ),
      body: overviewController.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
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
                          color: Colors.pink.shade600, size: 20),
                      title: "Total",
                      amount: stats.totalHabits.toString(),
                      isHighlighted: true,
                      arrowIcon: Icons.arrow_upward,
                      arrowColor: Colors.red.shade400,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      iconWidget: Icon(Icons.check_circle_outline,
                          color: Colors.green.shade600, size: 20),
                      title: "Rate",
                      amount:
                          '${stats.totalHabits != 0 ? (stats.completedHabits / stats.totalHabits * 100).round() : 0}% (${stats.completedHabits}/${stats.totalHabits})',
                      isHighlighted: false,
                      arrowIcon: Icons.arrow_upward,
                      arrowColor: Colors.green.shade500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      iconWidget: Icon(Icons.timer,
                          color: Colors.green.shade600, size: 20),
                      title: "Complete",
                      amount: stats.completeTypeHabits.toString(),
                      isHighlighted: false,
                      arrowIcon: Icons.arrow_upward,
                      arrowColor: Colors.green.shade500,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      iconWidget: Icon(Icons.hourglass_empty,
                          color: Colors.green.shade600, size: 20),
                      title: "Progress",
                      amount: stats.progressTypeHabits.toString(),
                      isHighlighted: false,
                      arrowIcon: Icons.arrow_upward,
                      arrowColor: Colors.green.shade500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              /// Build Chart Section
              const ChartSection(),
            ],
          ),
        ),
      ),
    );
  }
}
