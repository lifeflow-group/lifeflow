import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final indexTab = ref.watch(indexTabProvider);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) =>
            ref.read(mainControllerProvider).setTab(index),
        // Disable swipe to change tab
        physics: const NeverScrollableScrollPhysics(),

        children: [
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
                  .withAlpha((0.1 * 255).toInt()), // Shadow color
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, -0.01), // changes position of shadow
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
          showUnselectedLabels: true,
          currentIndex: indexTab,
          onTap: (index) {
            ref.read(mainControllerProvider).setTab(index);
            _pageController.jumpToPage(index); // Jump to the selected page
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: "Overview"),
            BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb), label: "Suggestions"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
