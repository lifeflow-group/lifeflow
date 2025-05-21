import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/language_selection_controller.dart';

class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState
    extends ConsumerState<LanguageSelectionScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Delay state modification until after the current build cycle
    Future.microtask(() {
      if (mounted) {
        ref
            .read(languageSelectionControllerProvider.notifier)
            .loadInitialState();
      }
    });
  }

  // Custom widget for radio button
  Widget _buildRadioIndicator(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primaryColor, width: 2)),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: primaryColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Get state from controller
    final state = ref.watch(languageSelectionControllerProvider);
    final selectedLanguage = state.selectedLanguage;
    final supportedLanguages = state.supportedLanguages;

    // Controller reference
    final controller = ref.read(languageSelectionControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        title: Text(l10n.languageTitle,
            style: theme.textTheme.titleMedium
                ?.copyWith(color: theme.colorScheme.onSurface)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(selectedLanguage),
            child: Text(
              l10n.saveButton,
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: theme.colorScheme.onSurface),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: supportedLanguages.length,
        itemBuilder: (context, index) {
          final language = supportedLanguages[index];
          final bool isSelected = language == selectedLanguage;
          final Color tileBackgroundColor = theme.colorScheme.surface;

          return Material(
            color: tileBackgroundColor,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              title: Text(
                language.languageName,
                style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface
                        .withAlpha((0.65 * 255).toInt())),
              ),
              trailing: isSelected ? _buildRadioIndicator(context) : null,
              onTap: () {
                controller.selectLanguageCode(language);
              },
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 0.5,
          color: theme.colorScheme.outlineVariant,
          indent: 24,
          endIndent: 24,
        ),
      ),
    );
  }
}
