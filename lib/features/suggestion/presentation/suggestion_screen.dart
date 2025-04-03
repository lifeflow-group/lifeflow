import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/suggestion_controller.dart';
import 'widgets/suggestion_card.dart';

class SuggestionScreen extends ConsumerWidget {
  const SuggestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(suggestionControllerProvider);

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
            "Optimization Suggestions",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          backgroundColor: Theme.of(context).cardTheme.color,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(suggestionControllerProvider.notifier).refresh();
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async =>
              ref.read(suggestionControllerProvider.notifier).refresh(),
          child: controller.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text("Error: $err")),
            data: (suggestions) => SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: Column(
                  children: [
                    ...suggestions.map(
                        (suggestion) => SuggestionCard(suggestion: suggestion)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
