import 'package:flutter/material.dart';

/// A reusable bottom action bar with a "Select All" checkbox and an "Apply" button.
class ActionSelectionBar extends StatelessWidget {
  /// Whether all items are currently selected
  final bool isAllSelected;

  /// Whether any items are currently selected
  final bool hasAnySelection;

  /// Text for the select all label
  final String selectAllLabel;

  /// Text for the apply button
  final String applyButtonLabel;

  /// Callback when select all is toggled
  final void Function(bool) onToggleAll;

  /// Callback when apply button is pressed
  final VoidCallback onApply;

  const ActionSelectionBar({
    super.key,
    required this.isAllSelected,
    required this.hasAnySelection,
    required this.selectAllLabel,
    required this.applyButtonLabel,
    required this.onToggleAll,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 4.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Select All Checkbox
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: isAllSelected,
                  shape: const CircleBorder(),
                  side: WidgetStateBorderSide.resolveWith(
                    (states) => BorderSide(
                      width: isAllSelected ? 4 : 2,
                      color: isAllSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                      strokeAlign: BorderSide.strokeAlignCenter,
                    ),
                  ),
                  onChanged: (selected) {
                    onToggleAll(selected ?? false);
                  },
                  activeColor: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  onToggleAll(!isAllSelected);
                },
                child: Text(
                  selectAllLabel,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Spacer(),
          // Apply Button
          ElevatedButton(
            onPressed: hasAnySelection ? onApply : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              disabledBackgroundColor: theme.colorScheme.primary.withAlpha(135),
            ),
            child: Text(applyButtonLabel),
          ),
        ],
      ),
    );
  }
}
