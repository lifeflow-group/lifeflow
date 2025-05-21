import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../controllers/overview_controller.dart';
import 'legend_item.dart';

class ChartSection extends ConsumerWidget {
  const ChartSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final overviewController = ref.watch(overviewControllerProvider);

    return overviewController.when(
      loading: () => Center(
          child: CircularProgressIndicator(color: theme.colorScheme.primary)),
      error: (error, stack) => Center(
        child: Text(l10n.errorLoadingChartData(error.toString()),
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.error)),
      ),
      data: (stats) {
        // Handle empty data case
        if (stats.totalHabits == 0) {
          return SizedBox(
            height: 230,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pie_chart_outline,
                      size: 48,
                      color: theme.colorScheme.onSurface
                          .withAlpha((0.4 * 255).round())),
                  const SizedBox(height: 16),
                  Text(l10n.noHabitDataMonth,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withAlpha((0.6 * 255).round()))),
                ],
              ),
            ),
          );
        }

        // Prepare chart data from category distribution
        final pieChartSections = _preparePieChartSections(context, stats);

        final List<CategoryStats> sortedCategories =
            List<CategoryStats>.from(stats.categoryDistribution)
              ..sort((a, b) => b.percentage.compareTo(a.percentage));

        final List<CategoryStats> rightCategories = [];
        final List<CategoryStats> leftCategories = [];

        final middleIndex = (stats.categoryDistribution.length / 2).ceil();
        double cumulativePercentage = 0;

        for (final category in sortedCategories) {
          if (cumulativePercentage < 50 &&
              rightCategories.length < middleIndex) {
            rightCategories.add(category);
            cumulativePercentage += category.percentage;
          } else if (leftCategories.length < middleIndex) {
            leftCategories.add(category);
          }
        }

        return SizedBox(
          height: 230, // Adjust height to fit chart and legends comfortably
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.categoryTitle, style: theme.textTheme.titleMedium),
              SizedBox(height: 12.0),
              Expanded(
                child: Row(
                  children: [
                    // Left Legend
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: leftCategories
                            .map((category) => LegendItem(
                                iconPath: category.iconPath,
                                iconColor: category.color,
                                percentageColor: category.color
                                    .withAlpha((0.8 * 255).round()),
                                percentage:
                                    '${category.percentage.toStringAsFixed(0)}%',
                                label: category.categoryName))
                            .toList(),
                      ),
                    ),

                    // Chart
                    Expanded(
                      flex: 2, // Give more space for chart
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 2,
                        width: MediaQuery.of(context).size.width / 2,
                        child: PieChart(
                          PieChartData(
                            sections: pieChartSections,
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 2.5, // Space between sections
                            centerSpaceRadius: 30, // Donut hole size
                            startDegreeOffset: -90,
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                // TODO: Handle touch interaction
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Right Legend
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: rightCategories
                            .map((category) => LegendItem(
                                  iconPath: category.iconPath,
                                  iconColor: category.color,
                                  percentageColor: category.color
                                      .withAlpha((0.8 * 255).round()),
                                  percentage:
                                      '${category.percentage.toStringAsFixed(0)}%',
                                  label: category.categoryName,
                                  isRightAligned: true,
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> _preparePieChartSections(
      BuildContext context, OverviewStats stats) {
    final l10n = AppLocalizations.of(context)!;

    // Sort categories by percentage (descending)
    final sortedCategories =
        List<CategoryStats>.from(stats.categoryDistribution)
          ..sort((a, b) => b.percentage.compareTo(a.percentage));

    // Define max categories to show individually
    final int maxIndividualCategories = 7;
    List<CategoryStats> visibleCategories;
    double othersPercentage = 0;

    if (sortedCategories.length > 8) {
      // Case: More than 8 categories -> take top 7 + "Others"
      visibleCategories =
          sortedCategories.take(maxIndividualCategories).toList();

      // Calculate "Others" percentage (sum of all remaining categories)
      for (var i = maxIndividualCategories; i < sortedCategories.length; i++) {
        othersPercentage += sortedCategories[i].percentage;
      }
    } else {
      // Case: 8 or fewer categories -> show all categories, no "Others"
      visibleCategories = sortedCategories;
    }

    // Create pie sections for visible categories
    final List<PieChartSectionData> sections =
        visibleCategories.map((category) {
      return PieChartSectionData(
          color: category.color,
          value: category.percentage,
          radius: 60, // Default radius
          showTitle: false);
    }).toList();

    // Add "Others" section if needed
    if (othersPercentage > 0) {
      sections.add(PieChartSectionData(
          color: Colors.grey.shade400,
          value: othersPercentage,
          radius: 60,
          showTitle: false,
          title: l10n.othersLabel));
    }

    return sections;
  }
}
