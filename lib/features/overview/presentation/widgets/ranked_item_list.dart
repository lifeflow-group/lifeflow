import 'package:flutter/material.dart';

import '../../../../src/generated/l10n/app_localizations.dart';

class RankedItemData {
  final int rank;
  final String iconPath;
  final String habitName;
  final String value;

  const RankedItemData({
    required this.rank,
    required this.iconPath,
    required this.habitName,
    required this.value,
  });
}

class RankedItem extends StatelessWidget {
  final RankedItemData data;

  const RankedItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Row(
        children: [
          Text(data.rank.toString(), style: theme.textTheme.bodyMedium),
          const SizedBox(width: 12),
          Image.asset(data.iconPath, width: 28, height: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(data.habitName,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 12),
          Text(
            data.value,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class RankedItemList extends StatelessWidget {
  final List<RankedItemData> items;
  final bool showDividers;

  const RankedItemList({
    super.key,
    required this.items,
    this.showDividers = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!; // Get localization

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Empty state
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                l10n.noRankedItemsAvailable,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
          ),

        // Items and dividers
        for (int i = 0; i < items.length; i++) ...[
          // Add the item
          RankedItem(data: items[i]),

          // Add divider if not the last item and dividers are enabled
          if (showDividers && i < items.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Divider(
                height: 1,
                thickness: 0.5,
                color: theme.colorScheme.outlineVariant,
              ),
            ),
        ],
      ],
    );
  }
}
