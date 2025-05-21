import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../home/presentation/home_screen.dart';
import '../../overview/presentation/overview_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import '../../suggestion/presentation/suggestion_screen.dart';
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
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final indexTab = ref.watch(indexTabProvider);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) =>
            ref.read(mainControllerProvider).setTab(index),
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
              color: Theme.of(context)
                  .colorScheme
                  .shadow
                  .withAlpha((0.1 * 255).toInt()),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, -0.01),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
          showUnselectedLabels: true,
          currentIndex: indexTab,
          onTap: (index) {
            ref.read(mainControllerProvider).setTab(index);
            _pageController.jumpToPage(index);
          },
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
