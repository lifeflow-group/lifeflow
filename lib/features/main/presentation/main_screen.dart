import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../src/generated/l10n/app_localizations.dart';
import '../../home/presentation/home_screen.dart';
import '../../overview/presentation/screens/overview_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import '../../suggestion/presentation/screens/suggestion_screen.dart';
import '../controllers/main_controller.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(keepPage: true, initialPage: ref.read(indexTabProvider));

    // Add a listener that runs after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Setup the listener to sync tab changes
      ref.listenManual(indexTabProvider, _onTabChanged);
    });
  }

  // This will be called whenever indexTabProvider changes
  void _onTabChanged(int? previous, int current) {
    // Only jump if the controller has clients and the page is different
    if (_pageController.hasClients &&
        _pageController.page?.round() != current) {
      _pageController.jumpToPage(current);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final indexTab = ref.watch(indexTabProvider);
    final mainController = ref.read(mainControllerProvider);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          mainController.setTabFromSwipe(index);
        },
        // Disable swipe to change tab
        physics: const NeverScrollableScrollPhysics(),

        children: const [
          HomeScreen(),
          OverviewScreen(),
          SuggestionScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withAlpha((0.1 * 255).toInt()),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, -0.01),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: theme.brightness == Brightness.dark
              ? theme.cardTheme.color
              : theme.colorScheme.onPrimary,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: theme.primaryColor,
          unselectedItemColor: theme.colorScheme.onSecondary,
          showUnselectedLabels: true,
          currentIndex: indexTab,
          onTap: (index) => mainController.setTab(index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: l10n.navHome),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: l10n.navOverview),
            BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb), label: l10n.navSuggestions),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: l10n.navSettings),
          ],
        ),
      ),
    );
  }
}
