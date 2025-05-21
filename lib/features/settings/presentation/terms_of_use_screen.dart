import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controllers/terms_of_use_controller.dart';

class TermsOfUseScreen extends ConsumerStatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  ConsumerState<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends ConsumerState<TermsOfUseScreen> {
  @override
  void initState() {
    super.initState();
    _loadTerms();
  }

  Future<void> _loadTerms() async {
    // Load terms of use
    await ref.read(termsOfUseControllerProvider.notifier).loadTerms(context);
  }

  @override
  Widget build(BuildContext context) {
    // Get localization instance
    final l10n = AppLocalizations.of(context)!;

    // Track the state of termsOfUseControllerProvider
    final termsState = ref.watch(termsOfUseControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.termsOfUseTitle),
        centerTitle: true,
      ),
      body: termsState.when(
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
        data: (content) => Padding(
          padding: const EdgeInsets.all(16),
          child: MarkdownWidget(data: content),
        ),
      ),
    );
  }
}
