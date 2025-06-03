import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/services/analytics_service.dart';

final indexTabProvider = StateProvider<int>((ref) => 0);

final mainControllerProvider = Provider((ref) => MainController(ref));

class MainController {
  final Ref ref;

  MainController(this.ref);

  AnalyticsService get _analyticsService => ref.read(analyticsServiceProvider);

  void setTab(int index) {
    final currentIndex = ref.read(indexTabProvider);

    if (index == currentIndex) {
      // User selected the already active tab
      _trackTabReselected(index);
      return;
    }

    // Track tab change before updating state
    _trackTabChanged(currentIndex, index, 'tab_bar_tap');

    // Update state
    ref.read(indexTabProvider.notifier).state = index;
  }

  void setTabFromSwipe(int index) {
    final currentIndex = ref.read(indexTabProvider);

    // Track tab change from swipe before updating state
    _trackTabChanged(currentIndex, index, 'swipe');

    // Update state
    ref.read(indexTabProvider.notifier).state = index;
  }

  void _trackTabReselected(int index) {
    _analyticsService.trackTabReselected(_getTabName(index));
  }

  void _trackTabChanged(int fromIndex, int toIndex, String method) {
    final previousTab = _getTabName(fromIndex);
    final newTab = _getTabName(toIndex);

    _analyticsService.trackTabChanged(previousTab, newTab, method);
  }

  // Helper method to convert tab index to name
  String _getTabName(int index) {
    switch (index) {
      case 0:
        return 'home_tab';
      case 1:
        return 'overview_tab';
      case 2:
        return 'suggestions_tab';
      case 3:
        return 'settings_tab';
      default:
        return 'unknown_tab';
    }
  }
}
