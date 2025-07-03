import 'package:flutter/material.dart';

class PersonalizationActionChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool hasDropdown;
  final bool hasCloseIcon;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onClose;
  final bool showBorder;

  const PersonalizationActionChip({
    super.key,
    required this.label,
    this.icon,
    this.hasDropdown = false,
    this.hasCloseIcon = false,
    this.isSelected = false,
    this.onTap,
    this.onClose,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color bgColor = isSelected
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.surface;
    final Color fgColor = isSelected
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onSurface;
    final Color borderColor =
        isSelected ? theme.colorScheme.primary : theme.colorScheme.outline;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.0),
          border: showBorder ? Border.all(color: borderColor) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: fgColor, size: 20),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: fgColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (hasCloseIcon && onClose != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onClose,
                child: Icon(Icons.close, color: fgColor, size: 18),
              ),
            ],
            if (hasDropdown) ...[
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, color: fgColor.withAlpha(178)),
            ],
          ],
        ),
      ),
    );
  }
}
