import 'package:flutter/material.dart';
import '../screens/category_habit_analytics_screen.dart';

class FilterChipButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final CategoryDetailFilterType filterType;
  final Function(CategoryDetailFilterType) onFilterChange;

  const FilterChipButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.filterType,
    required this.onFilterChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: isSelected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onSurface,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onFilterChange(filterType),
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      selectedColor: theme.colorScheme.primary.withAlpha(180),
      checkmarkColor: theme.colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
