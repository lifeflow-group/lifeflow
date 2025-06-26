import 'package:flutter_riverpod/flutter_riverpod.dart';

import './remote_habit_plan_repository.dart';
import './remote_suggestion_repository.dart';

/// Provider to access all remote repositories
final remoteRepositoriesProvider = Provider<RemoteRepositories>((ref) {
  return RemoteRepositories(
    habitPlans: ref.read(remoteHabitPlanRepositoryProvider),
    suggestions: ref.read(remoteSuggestionRepositoryProvider),
  );
});

/// Container for all remote repositories
class RemoteRepositories {
  /// Repository to access habit plans from remote API
  final RemoteHabitPlanRepository habitPlans;

  /// Repository to access suggestions from remote API
  final RemoteSuggestionRepository suggestions;

  const RemoteRepositories({
    required this.habitPlans,
    required this.suggestions,
  });
}
