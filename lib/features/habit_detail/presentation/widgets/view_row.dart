import 'package:flutter/material.dart';

class ViewRow extends StatelessWidget {
  const ViewRow(
      {super.key,
      required this.label,
      required this.valueText,
      this.valueIcon});

  final String label;
  final String valueText;
  final Widget? valueIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(label,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (valueIcon != null) ...[
                      valueIcon!,
                      const SizedBox(width: 8)
                    ],
                    Flexible(
                        child: Text(valueText,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
            height: 0.4,
            color:
                Theme.of(context).colorScheme.shadow.withValues(alpha: 0.06)),
      ],
    );
  }
}
