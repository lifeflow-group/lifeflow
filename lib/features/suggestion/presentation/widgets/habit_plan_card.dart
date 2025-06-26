import 'package:flutter/material.dart';

import '../../../../core/config/environment.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../data/domain/models/habit_plan.dart';

class HabitPlanCard extends StatelessWidget {
  const HabitPlanCard({super.key, required this.plan, required this.onTap});

  final HabitPlan plan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryColor = hexToColor(plan.category.colorHex);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background image covering the entire card
            Positioned.fill(
              child: plan.imagePath.startsWith('assets/')
                  ? Image.asset(
                      plan.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: categoryColor.withAlpha(50),
                          child: Icon(
                            Icons.image_not_supported,
                            color: categoryColor,
                            size: 32,
                          ),
                        );
                      },
                    )
                  : Image.network(
                      '${Environment.apiBaseUrl}/${plan.imagePath}',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: categoryColor.withAlpha(30),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: categoryColor,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: categoryColor.withAlpha(50),
                          child: Icon(
                            Icons.image_not_supported,
                            color: categoryColor,
                            size: 32,
                          ),
                        );
                      },
                    ),
            ),

            // Gradient overlay for better text readability
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 155,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(128),
                      Colors.black.withAlpha(179),
                    ],
                    stops: const [0.4, 0.7, 1.0],
                  ),
                ),
              ),
            ),

            // Text content
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plan title at the bottom
                    Text(
                      plan.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              blurRadius: 1,
                              color: Colors.black.withAlpha(102),
                              offset: const Offset(1, 1)),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Habits count
                    Row(
                      children: [
                        Icon(Icons.list_outlined,
                            size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          '${plan.suggestions.length} habits',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
