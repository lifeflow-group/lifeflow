import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/domain/models/ai_suggestion_request_input.dart';
import '../../../../data/domain/models/personalization_context.dart';
import '../../controllers/ai_picks_controller.dart';
import 'personalization_action_chip.dart';

const _clearFilter = Object();

class PersonalizationFields extends ConsumerStatefulWidget {
  const PersonalizationFields({super.key});

  @override
  ConsumerState<PersonalizationFields> createState() =>
      _PersonalizationFieldsState();
}

class _PersonalizationFieldsState extends ConsumerState<PersonalizationFields> {
  // Constants for text limits
  static const double _minInputHeight = 50.0;
  static const double _maxInputHeight = 300.0;

  final TextEditingController _goalsController = TextEditingController();
  // Add a key for measuring text
  final GlobalKey _textFieldKey = GlobalKey();
  final FocusNode _goalsFocusNode = FocusNode();

  bool get _canSubmit {
    final value = ref.read(aiPicksControllerProvider).value;
    final aiSuggestionRequestInput = value?.aiSuggestionRequestInput;
    final personalizationContext =
        aiSuggestionRequestInput?.personalizationContext;

    if (aiSuggestionRequestInput == null) return false;

    // If data source is "personalizationOnly", only personality, time, guidance or goals are needed.
    if (aiSuggestionRequestInput.dataSourceType ==
        DataSourceType.personalizationOnly) {
      return personalizationContext?.personalityType != null ||
          personalizationContext?.timePreference != null ||
          personalizationContext?.guidanceLevel != null ||
          _goalsController.text != '';
    }

    // If data source is "habitsOnly", personalization fields are not required.
    if (aiSuggestionRequestInput.dataSourceType == DataSourceType.habitsOnly) {
      return true;
    }

    // For "both" or default case, goals are required.
    return _goalsController.text != '';
  }

  @override
  void dispose() {
    _goalsFocusNode.dispose();
    _goalsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final notifier = ref.read(aiPicksControllerProvider.notifier);
    final value = ref.watch(aiPicksControllerProvider).value;

    final goals = value?.aiSuggestionRequestInput?.personalizationContext.goals;
    if (goals != null) {
      _goalsController.text = goals;
    }

    final personalizationContext =
        value?.aiSuggestionRequestInput?.personalizationContext;
    final PersonalityType? personalityType =
        personalizationContext?.personalityType;
    final TimePreference? timePreference =
        personalizationContext?.timePreference;
    final GuidanceLevel? guidanceLevel = personalizationContext?.guidanceLevel;

    final dataSource =
        value?.aiSuggestionRequestInput?.dataSourceType ?? DataSourceType.both;

    // Main card containing the entire interface
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Build Top Action Section
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 12),
                // Personality Chip
                PersonalizationActionChip(
                  icon: Icons.person_outline,
                  label: personalityType?.getLocalizedName(context) ??
                      l10n.personalityLabel,
                  hasDropdown: true,
                  hasCloseIcon: personalityType != null,
                  onTap: () async {
                    final result = await _showPersonalityBottomSheet(
                        context, personalityType, l10n);
                    if (result == _clearFilter) {
                      notifier.updatePersonalization(personalityType: null);
                    } else if (result is PersonalityType) {
                      notifier.updatePersonalization(personalityType: result);
                    }
                  },
                  onClose: personalityType != null
                      ? () =>
                          notifier.updatePersonalization(personalityType: null)
                      : null,
                  isSelected: personalityType != null,
                ),
                const SizedBox(width: 10),

                // Available Time Chip
                PersonalizationActionChip(
                  icon: Icons.access_time,
                  label: timePreference?.getLocalizedName(context) ??
                      l10n.availableTimeLabel,
                  hasDropdown: true,
                  onTap: () async {
                    final result = await _showTimeBottomSheet(
                        context, timePreference, l10n);
                    if (result != null) {
                      notifier.updatePersonalization(timePreference: result);
                    }
                  },
                  isSelected: timePreference != null,
                  hasCloseIcon: timePreference != null,
                  onClose: timePreference != null
                      ? () =>
                          notifier.updatePersonalization(timePreference: null)
                      : null,
                ),
                const SizedBox(width: 10),

                // Guidance Level Chip
                PersonalizationActionChip(
                  icon: Icons.layers_outlined,
                  label: guidanceLevel?.getLocalizedName(context) ??
                      l10n.guidanceLevelLabel,
                  hasDropdown: true,
                  onTap: () async {
                    final result = await _showGuidanceLevelBottomSheet(
                        context, guidanceLevel, l10n);
                    if (result != null) {
                      notifier.updatePersonalization(guidanceLevel: result);
                    }
                  },
                  isSelected: guidanceLevel != null,
                  hasCloseIcon: guidanceLevel != null,
                  onClose: guidanceLevel != null
                      ? () =>
                          notifier.updatePersonalization(guidanceLevel: null)
                      : null,
                ),
                SizedBox(width: 12),
              ],
            ),
          ),
        ),

        /// Build Bottom Input Section
        LayoutBuilder(builder: (context, constraints) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(
              minHeight: _minInputHeight, // Space for bottom action row
              maxHeight: _maxInputHeight, // Space for bottom action row
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withAlpha(20),
                  blurRadius: 30.0,
                  spreadRadius: 2.0,
                ),
                BoxShadow(
                  color: theme.colorScheme.secondary.withAlpha(20),
                  blurRadius: 30.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Use ConstrainedBox instead of Expanded
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: _minInputHeight,
                    maxHeight:
                        _maxInputHeight - 72, // Leave space for action row
                  ),
                  child: TextField(
                      key: _textFieldKey,
                      controller: _goalsController,
                      focusNode: _goalsFocusNode,
                      autofocus: false,
                      maxLines: null, // Allow unlimited lines
                      keyboardType: TextInputType.multiline,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        hintText: l10n.goalsHint,
                        hintStyle: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: theme.colorScheme.scrim),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) => notifier.updatePersonalization(
                          goals: _goalsController.text),
                      onTapOutside: (event) {
                        notifier.updatePersonalization(
                            goals: _goalsController.text);
                        _goalsFocusNode.unfocus();
                      }),
                ),

                // Bottom action row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Data Source Preference
                    PersonalizationActionChip(
                      icon: Icons.settings_input_component_outlined,
                      label: dataSource.getLocalizedName(context),
                      hasDropdown: true,
                      onTap: () => _showDataSourceBottomSheet(context, l10n),
                      isSelected: dataSource != DataSourceType.both,
                      showBorder: false,
                    ),
                    GestureDetector(
                      onTap: _canSubmit
                          ? () {
                              notifier.updatePersonalization(
                                  goals: _goalsController.text);
                              notifier.setSubmitted(true);
                              notifier.refresh();
                            }
                          : null,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _canSubmit
                              ? theme.colorScheme.primary
                              : theme.colorScheme.surfaceContainerHighest,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: _canSubmit
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Future<PersonalityType?> _showPersonalityBottomSheet(BuildContext context,
      PersonalityType? currentType, AppLocalizations l10n) async {
    final options = PersonalityType.values.toList();

    final personality = await _showGenericEnumBottomSheet(
      context: context,
      title: l10n.selectPersonalityTitle,
      options: options,
      currentSelection: currentType,
    );

    if (personality is PersonalityType) {
      return personality;
    }
    return null;
  }

  Future<TimePreference?> _showTimeBottomSheet(BuildContext context,
      TimePreference? currentPreference, AppLocalizations l10n) async {
    final options = TimePreference.values.toList();

    final result = await _showGenericEnumBottomSheet(
      context: context,
      title: l10n.selectAvailableTimeTitle,
      options: options,
      currentSelection: currentPreference,
    );

    if (result is TimePreference) {
      return result;
    }
    return null;
  }

  Future<GuidanceLevel?> _showGuidanceLevelBottomSheet(BuildContext context,
      GuidanceLevel? currentLevel, AppLocalizations l10n) async {
    final options = GuidanceLevel.values.toList();

    final result = await _showGenericEnumBottomSheet(
      context: context,
      title: l10n.selectGuidanceLevelTitle,
      options: options,
      currentSelection: currentLevel,
    );

    if (result is GuidanceLevel) {
      return result;
    }
    return null;
  }

  Future<void> _showDataSourceBottomSheet(
      BuildContext context, AppLocalizations l10n) async {
    final notifier = ref.read(aiPicksControllerProvider.notifier);
    final value = ref.watch(aiPicksControllerProvider).value;
    final currentDataSourceType =
        value?.aiSuggestionRequestInput?.dataSourceType ?? DataSourceType.both;

    final result = await _showGenericEnumBottomSheet<DataSourceType>(
      context: context,
      title: l10n.selectDataSourceTitle,
      options: DataSourceType.values.toList(),
      currentSelection: currentDataSourceType,
      showAllOption: false,
    );

    if (result == _clearFilter) {
      notifier.updatePersonalization(dataSourceType: null);
    } else if (result is DataSourceType) {
      notifier.updatePersonalization(dataSourceType: result);
    }
  }

  // Generic bottom sheet for enum types
  Future<Object?> _showGenericEnumBottomSheet<T extends EnumClass>({
    required BuildContext context,
    required String title,
    required List<T> options,
    T? currentSelection,
    bool showAllOption = true,
  }) async {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return await showModalBottomSheet<Object?>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 54),
                  Text(title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Container(
                    width: 54,
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
              // "All" option
              if (showAllOption)
                ListTile(
                  title: Text(
                    l10n.filterAll,
                    style: theme.textTheme.titleMedium,
                  ),
                  trailing: currentSelection == null
                      ? Icon(Icons.check, color: theme.colorScheme.primary)
                      : null,
                  onTap: () {
                    context.pop(_clearFilter);
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 22.0),
                ),
              // Option list
              ...options.map((option) {
                final isSelected = option == currentSelection;
                String display;
                if (option is GuidanceLevel ||
                    option is TimePreference ||
                    option is PersonalityType ||
                    option is DataSourceType) {
                  display = (option as dynamic).getLocalizedName(context);
                } else {
                  display = option.name;
                }

                return ListTile(
                  title: Text(
                    display,
                    style: theme.textTheme.titleMedium,
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check, color: theme.colorScheme.primary)
                      : null,
                  onTap: () {
                    context.pop(option);
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 22.0),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
