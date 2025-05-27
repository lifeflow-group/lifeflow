import 'package:flutter/material.dart';

import '../../controllers/overview_controller.dart';

class CategoryListTile extends StatelessWidget {
  final CategoryStats categoryStats;
  final DateTime month;
  final bool isSelected;
  final Function()? onTap;

  const CategoryListTile({
    super.key,
    required this.categoryStats,
    required this.month,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: isSelected
            ? Border.all(color: theme.colorScheme.primary, width: 1)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Image.asset(
          categoryStats.category.iconPath,
          width: 20,
          height: 20,
        ),
        title: Text(
          categoryStats.category.name,
          style: theme.textTheme.bodyMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${categoryStats.habitCount}',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(width: 1),
            Icon(
              Icons.chevron_right_outlined,
              size: 15,
              color: theme.colorScheme.onSurface,
            ),
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        onTap: onTap,
      ),
    );
  }
}
