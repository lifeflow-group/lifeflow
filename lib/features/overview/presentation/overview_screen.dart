import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/overview_provider.dart';

class OverviewScreen extends ConsumerWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewData = ref.watch(overviewDataProvider);

    return SafeArea(
      child: Scaffold(
        body: Center(child: Text(overviewData)),
      ),
    );
  }
}
