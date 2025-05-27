import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/domain/models/habit_category.dart';

Future<dynamic> showCategoryBottomSheet(
  BuildContext context, {
  HabitCategory? initialCategory,
}) async {
  return await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) {
      return CategoryBottomSheet(initialCategory: initialCategory);
    },
  );
}

class CategoryBottomSheet extends StatefulWidget {
  const CategoryBottomSheet({super.key, this.initialCategory});

  final HabitCategory? initialCategory;

  @override
  State<CategoryBottomSheet> createState() => _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends State<CategoryBottomSheet> {
  HabitCategory? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
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
                  onPressed: () => context.pop(),
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
              itemCount: defaultCategories.length,
              itemBuilder: (context, index) {
                final category = defaultCategories[index];
                final isSelected = selectedCategory?.id == category.id;

                return GestureDetector(
                  onTap: () => setState(() {
                    if (isSelected) {
                      // If already selected, clear selection
                      selectedCategory = null;
                    } else {
                      selectedCategory = category;
                    }
                  }),
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
                    onPressed: () => context.pop(),
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
