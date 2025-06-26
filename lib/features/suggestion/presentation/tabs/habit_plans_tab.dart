import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/factories/default_data.dart';
import '../../../../data/providers/filter_providers.dart';
import '../../../../data/domain/models/category.dart';
import '../../../../data/services/analytics/analytics_service.dart';
import '../../../habit_detail/presentation/widgets/category_bottom_sheet.dart';
import '../../controllers/habit_plans_controller.dart';
import '../widgets/error_view.dart';
import '../widgets/habit_plan_card.dart';

class HabitPlansTab extends ConsumerWidget {
  const HabitPlansTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final analyticsService = ref.read(analyticsServiceProvider);
    final habitPlansState = ref.watch(habitPlansControllerProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final controller = ref.read(habitPlansControllerProvider.notifier);

    return RefreshIndicator(
      onRefresh: () => controller.refresh(),
      child: habitPlansState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stackTrace) => ErrorView(
          error: err,
          controller: controller,
          l10n: l10n,
          analyticsService: analyticsService,
          showExploreButton: false,
          componentName: 'HabitPlansTab',
        ),
        data: (habitPlans) {
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Category Filter Chip
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(12.0),
                  alignment: Alignment.centerLeft,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),

              // Grid of habit plans
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                sliver: habitPlans.isEmpty
                    ? SliverFillRemaining(
                        hasScrollBody: false,
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
                                        .trackHabitPlansEmptyStateAllPlansClicked();
                                    controller.clearCategoryFilter();
                                  },
                                  child: Text(l10n.showAllHabitsButton),
                                ),
                              ],
                            ],
                          ),
                        ),
                      )
                    : SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.0,
                          crossAxisSpacing: 12.0,
                          childAspectRatio: 0.72, // Adjust based on card design
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final plan = habitPlans[index];
                            return HabitPlanCard(
                              plan: plan,
                              onTap: () {
                                analyticsService.trackHabitPlanSelected(
                                    plan.id, plan.title);
                                context.pushNamed('habit-plan-details',
                                    extra: {'plan': plan});
                              },
                            );
                          },
                          childCount: habitPlans.length,
                        ),
                      ),
              ),

              // Bottom padding
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          );
        },
      ),
    );
  }

  Future<void> _handleCategoryFilter(
      BuildContext context, WidgetRef ref) async {
    final controller = ref.read(habitPlansControllerProvider.notifier);
    final currentCategory = ref.read(selectedCategoryProvider);
    final analyticsService = ref.read(analyticsServiceProvider);

    analyticsService.trackHabitPlansCategoryFilterOpened(currentCategory?.name);

    final result = await showCategoryBottomSheet(context,
        initialCategory: currentCategory, categories: defaultPlanCategories);

    if (result == null) return;
    if (result is String && result == "clear") {
      // Clear category filter
      controller.clearCategoryFilter();
    } else if (result is Category) {
      // Apply category filter
      controller.filterByCategory(result);
    }
  }
}
