import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/services/analytics/analytics_service.dart';
import '../controllers/suggestion_controller.dart';
import 'widgets/loading_view.dart';
import 'widgets/suggestion_card.dart';

class SuggestionScreen extends ConsumerWidget {
  const SuggestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final analyticsService = ref.read(analyticsServiceProvider);
    final controller = ref.watch(suggestionControllerProvider);
    final notifier = ref.read(suggestionControllerProvider.notifier);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).cardTheme.color,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: CircleAvatar(
                radius: 18,
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                child: Icon(Icons.auto_awesome,
                    color: Theme.of(context).primaryColor, size: 20)),
          ),
          leadingWidth: 46,
          title: Text(
            l10n.suggestionTitle,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          backgroundColor: Theme.of(context).cardTheme.color,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: l10n.refreshButton,
              onPressed: () {
                analyticsService.trackSuggestionRefreshButtonTapped();
                notifier.refresh();
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => notifier.refresh(),
          child: controller.when(
            loading: () => const LoadingView(),
            error: (err, stack) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.suggestionError(err.toString())),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        analyticsService.trackSuggestionRetryButtonTapped();
                        notifier.refresh();
                      },
                      child: Text(l10n.retryButton),
                    ),
                  ],
                ),
              );
            },
            data: (suggestions) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 12.0),
                  child: Column(
                    children: [
                      if (suggestions.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(Icons.lightbulb_outline,
                                    size: 48,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withAlpha(150)),
                                const SizedBox(height: 16),
                                Text(l10n.noSuggestionsAvailable,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                          ),
                        )
                      else
                        ...suggestions.map((suggestion) {
                          return SuggestionCard(suggestion: suggestion);
                        }),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
