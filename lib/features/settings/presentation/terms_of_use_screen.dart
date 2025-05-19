import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

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
    // Track the state of termsOfUseControllerProvider
    final termsState = ref.watch(termsOfUseControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Use'), centerTitle: true),
      body: termsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Error loading terms: ${error.toString()}')),
        data: (content) => Padding(
          padding: const EdgeInsets.all(16),
          child: MarkdownWidget(data: content),
        ),
      ),
    );
  }
}
