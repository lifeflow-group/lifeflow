import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../data/services/analytics_service.dart';
import '../controllers/terms_of_use_controller.dart';

class TermsOfUseScreen extends ConsumerStatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  ConsumerState<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends ConsumerState<TermsOfUseScreen> {
  final ScrollController _scrollController = ScrollController();
  final Set<int> _trackedMilestones = {};

  @override
  void initState() {
    super.initState();
    _loadTerms();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final scrollPosition = _scrollController.position;
    if (scrollPosition.maxScrollExtent <= 0) return;

    final scrollPercent =
        scrollPosition.pixels / scrollPosition.maxScrollExtent;
    final analyticsService = ref.read(analyticsServiceProvider);

    // Track at 25%, 50%, 75%, and 100%
    if (scrollPercent >= 0.25 &&
        scrollPercent < 0.5 &&
        !_trackedMilestones.contains(25)) {
      analyticsService.trackTermsOfUseScrollMilestone(25);
      _trackedMilestones.add(25);
    } else if (scrollPercent >= 0.5 &&
        scrollPercent < 0.75 &&
        !_trackedMilestones.contains(50)) {
      analyticsService.trackTermsOfUseScrollMilestone(50);
      _trackedMilestones.add(50);
    } else if (scrollPercent >= 0.75 &&
        scrollPercent < 0.95 &&
        !_trackedMilestones.contains(75)) {
      analyticsService.trackTermsOfUseScrollMilestone(75);
      _trackedMilestones.add(75);
    } else if (scrollPercent >= 0.95 && !_trackedMilestones.contains(100)) {
      analyticsService.trackTermsOfUseScrollMilestone(100);
      _trackedMilestones.add(100);
    }
  }

  Future<void> _loadTerms() async {
    try {
      await ref.read(termsOfUseControllerProvider.notifier).loadTerms(context);
    } catch (e) {
      // Error is already tracked in controller
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final termsState = ref.watch(termsOfUseControllerProvider);
    final analyticsService = ref.read(analyticsServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.termsOfUseTitle),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            analyticsService.trackTermsOfUseExited();
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: termsState.when(
          loading: () => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(l10n.loading),
              ],
            ),
          ),
          error: (error, stackTrace) =>
              Center(child: Text(l10n.errorLoadingTerms(error.toString()))),
          data: (content) => SingleChildScrollView(
            controller: _scrollController,
            child: MarkdownWidget(
              data: content,
              shrinkWrap: true,
              config: MarkdownConfig(
                configs: [
                  LinkConfig(onTap: (String url) {
                    analyticsService.trackTermsOfUseLinkTapped(
                        url, url.startsWith('http'));
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
