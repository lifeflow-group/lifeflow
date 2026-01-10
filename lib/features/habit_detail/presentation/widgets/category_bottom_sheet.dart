import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/domain/models/category.dart';
import '../../../../data/factories/default_data.dart';
import '../../../../data/services/analytics/analytics_service.dart';
import '../../../../src/generated/l10n/app_localizations.dart';

Future<dynamic> showCategoryBottomSheet(
  BuildContext context, {
  Category? initialCategory,
  List<Category>? categories,
}) async {
  // Create provider container and store analytics service reference
  final container = ProviderContainer();
  final analyticsService = container.read(analyticsServiceProvider);
  final categoryList = categories ?? defaultCategories;

  // Track bottom sheet opening
  analyticsService.trackCategorySheetOpened(initialCategory?.name);

  final result = await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) {
      return CategoryBottomSheet(
          initialCategory: initialCategory, categories: categoryList);
    },
  );

  // Track result
  if (result == null) {
    analyticsService
        .trackCategorySheetDismissedWithoutSelection(initialCategory?.name);
  } else if (result == "clear") {
    analyticsService.trackCategoryClearedFromSheet(initialCategory?.name);
  } else if (result is Category) {
    analyticsService.trackCategorySelectedFromSheet(
        result.name, initialCategory?.name, result.id != initialCategory?.id);
  }

  // Don't forget to dispose the container when done
  container.dispose();

  return result;
}

class CategoryBottomSheet extends ConsumerStatefulWidget {
  const CategoryBottomSheet(
      {super.key, this.initialCategory, required this.categories});

  final Category? initialCategory;
  final List<Category> categories;

  @override
  ConsumerState<CategoryBottomSheet> createState() =>
      _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends ConsumerState<CategoryBottomSheet> {
  Category? selectedCategory;
  late final AnalyticsService _analyticsService;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize analyticsService here to ensure ref is ready
    _analyticsService = ref.read(analyticsServiceProvider);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48),
              Text(
                l10n.selectCategoryTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 18),
              ),
              IconButton(
                  onPressed: () {
                    _analyticsService.trackCategorySheetClosedViaXButton(
                        selectedCategory != null);
                    context.pop();
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
          const SizedBox(height: 16),
          // Categories grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                final isSelected = selectedCategory?.id == category.id;

                return GestureDetector(
                  onTap: () {
                    _analyticsService.trackCategoryTappedInSheet(
                        category.name, isSelected);

                    setState(() {
                      if (isSelected) {
                        // If already selected, clear selection
                        selectedCategory = null;
                      } else {
                        selectedCategory = category;
                      }
                    });
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: isSelected
                        ? Theme.of(context).cardTheme.color
                        : Theme.of(context).colorScheme.onPrimary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(category.iconPath, width: 40, height: 40),
                        const SizedBox(height: 8),
                        Text(
                          category.getLocalizedName(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontWeight: isSelected ? FontWeight.w600 : null,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      _analyticsService.trackCategorySheetCanceledViaButton(
                          selectedCategory != null);
                      context.pop();
                    },
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .shadow
                                .withAlpha(30),
                            width: 1),
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary),
                    child: Text(l10n.cancelButton,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(220)))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _analyticsService.trackCategorySheetConfirmed(
                        selectedCategory?.name,
                        selectedCategory?.id != widget.initialCategory?.id);

                    // Return the selected category or "clear" if selectedCategory is null
                    context.pop(selectedCategory ?? "clear");
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1)),
                  child: Text(l10n.selectButton,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
