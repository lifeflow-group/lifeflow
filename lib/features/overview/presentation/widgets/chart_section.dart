import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/domain/models/category.dart';
import '../../../../data/services/analytics/analytics_service.dart';
import '../../../settings/controllers/settings_controller.dart';
import '../../controllers/overview_controller.dart';
import 'category_list_tile.dart';
import 'legend_item.dart';

class ChartSection extends ConsumerStatefulWidget {
  const ChartSection({super.key, required this.month});

  final DateTime month;

  @override
  ConsumerState<ChartSection> createState() => _ChartSectionState();
}

class _ChartSectionState extends ConsumerState<ChartSection> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final overviewController = ref.watch(overviewControllerProvider);
    final overviewNotifier = ref.read(overviewControllerProvider.notifier);
    final analyticsService = ref.read(analyticsServiceProvider);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: theme.colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side:
            BorderSide(color: theme.colorScheme.outlineVariant.withAlpha(127)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: overviewController.when(
          loading: () => Center(
              child:
                  CircularProgressIndicator(color: theme.colorScheme.primary)),
          error: (error, stack) {
            // Log chart loading error
            return Center(
              child: Text(l10n.errorLoadingChartData(error.toString()),
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.error)),
            );
          },
          data: (stats) {
            // Handle empty data case
            if (stats.totalHabits == 0) {
              // Log empty chart data
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

            final List<CategoryStats> sortedCategories =
                List<CategoryStats>.from(stats.categoryDistribution)
                  ..sort((a, b) => b.percentage.compareTo(a.percentage));

            final middleIndex = 4;
            double cumulativePercentage = 0;
            bool hasOthers = false;
            final rightCategories = <CategoryStats>[];
            final leftCategories = <CategoryStats>[];

            for (final category in sortedCategories) {
              if (cumulativePercentage < 50 &&
                  rightCategories.length < middleIndex) {
                rightCategories.add(category);
                cumulativePercentage += category.percentage;
              } else {
                leftCategories.insert(0, category);
                if (leftCategories.length >= middleIndex - 1 &&
                    rightCategories.length + leftCategories.length <
                        sortedCategories.length) {
                  hasOthers = true;
                  break;
                }
              }
            }
            final visibleLimit = rightCategories.length + leftCategories.length;

            final List<CategoryStats> visibleCategories = hasOthers
                ? sortedCategories.take(visibleLimit).toList()
                : sortedCategories;
            final List<CategoryStats> othersCategories =
                hasOthers ? sortedCategories.skip(visibleLimit).toList() : [];
            // Prepare chart data from category distribution
            final pieChartSections = _preparePieChartSections(
                context, visibleCategories, othersCategories, touchedIndex);

            return Column(
              children: [
                SizedBox(height: 4.0),
                Text(l10n.categoryTitle, style: theme.textTheme.titleMedium),
                SizedBox(height: 12.0),
                SizedBox(
                  height: 210,
                  child: Row(
                    children: [
                      // Left Legend
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (hasOthers)
                              LegendItem(
                                categoryStats: CategoryStats(
                                  category: Category((p0) => p0
                                    ..id = 'others'
                                    ..name = l10n.othersLabel
                                    ..iconPath = 'assets/icons/others.png'
                                    ..colorHex = '#B0BEC5'),
                                  habitCount: othersCategories.length,
                                  percentage: othersCategories.fold(
                                      0, (sum, item) => sum + item.percentage),
                                ),
                              ),
                            ...leftCategories.map((categoryStats) =>
                                LegendItem(categoryStats: categoryStats)),
                          ],
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
                                  if (event is! FlTapUpEvent) return;

                                  final newIndex = pieTouchResponse
                                      ?.touchedSection?.touchedSectionIndex;

                                  if (newIndex != null &&
                                      newIndex != touchedIndex) {
                                    String categoryName = 'others';
                                    double percentage = 0;

                                    if (newIndex < visibleCategories.length) {
                                      categoryName = visibleCategories[newIndex]
                                          .category
                                          .name;
                                      percentage = visibleCategories[newIndex]
                                          .percentage;
                                    } else if (hasOthers) {
                                      percentage = othersCategories.fold(0,
                                          (sum, item) => sum + item.percentage);
                                    }

                                    analyticsService.trackChartSectionTapped(
                                        categoryName, percentage, newIndex);
                                  }

                                  setState(() {
                                    touchedIndex = newIndex;
                                  });
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
                              .map((categoryStats) => LegendItem(
                                  categoryStats: categoryStats,
                                  isRightAligned: true))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                /// Habits List
                Column(
                  children: [
                    ...List.generate(visibleCategories.length, (i) {
                      return Column(
                        children: [
                          CategoryListTile(
                              categoryStats: visibleCategories[i],
                              month: widget.month,
                              isSelected: i == touchedIndex,
                              onTap: () => _navigateToDetail(
                                  context,
                                  visibleCategories[i].category,
                                  widget.month,
                                  overviewNotifier)),

                          // Add divider if not the last item
                          if (i < visibleCategories.length - 1)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                height: 1,
                                thickness: 0.5,
                                color: theme.colorScheme.outlineVariant,
                              ),
                            ),
                        ],
                      );
                    }),

                    // "Others" section with divider before it if we have visible categories
                    if (hasOthers) ...[
                      Container(
                        decoration: BoxDecoration(
                          border: touchedIndex == visibleCategories.length
                              ? Border.all(
                                  color: theme.colorScheme.primary, width: 1)
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: othersCategories.map((categoryStats) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Divider(
                                    height: 1,
                                    thickness: 0.5,
                                    color: theme.colorScheme.outlineVariant,
                                  ),
                                ),
                                CategoryListTile(
                                  categoryStats: categoryStats,
                                  month: widget.month,
                                  onTap: () => _navigateToDetail(
                                      context,
                                      categoryStats.category,
                                      widget.month,
                                      overviewNotifier),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _navigateToDetail(
    BuildContext context,
    Category category,
    DateTime month,
    OverviewController overviewNotifier,
  ) async {
    if (context.mounted) {
      final analyticsService = ref.read(analyticsServiceProvider);

      analyticsService.trackNavigateToCategoryDetail(
          category.name,
          formatDateWithUserLanguage(
              ref.read(settingsControllerProvider), month, 'yyyy-MM'),
          true);

      // Use named routes instead of paths
      await context.pushNamed('category-habit-analytics',
          extra: {'category': category, 'month': month});

      analyticsService.trackReturnFromCategoryDetail(
          category.name,
          formatDateWithUserLanguage(
              ref.read(settingsControllerProvider), month, 'yyyy-MM'));

      ref.invalidate(overviewControllerProvider);
    }
  }

  List<PieChartSectionData> _preparePieChartSections(
      BuildContext context,
      List<CategoryStats> visibleCategories,
      List<CategoryStats> othersCategories,
      int? touchedIndex) {
    final l10n = AppLocalizations.of(context)!;

    final othersPercentage =
        othersCategories.fold(0.0, (sum, item) => sum + item.percentage);

    final List<PieChartSectionData> sections = [];

    for (int i = 0; i < visibleCategories.length; i++) {
      final category = visibleCategories[i];
      final isTouched = touchedIndex == i;

      sections.add(PieChartSectionData(
        color: hexToColor(category.category.colorHex),
        value: category.percentage,
        radius: isTouched ? 65 : 60, // Highlight when selected
        showTitle: false,
      ));
    }

    // Add "Others" section if needed
    if (othersPercentage > 0) {
      final isTouched = touchedIndex == visibleCategories.length;
      sections.add(PieChartSectionData(
        color: Colors.grey.shade400,
        value: othersPercentage,
        radius: isTouched ? 65 : 60,
        showTitle: false,
        title: l10n.othersLabel,
      ));
    }

    return sections;
  }
}
