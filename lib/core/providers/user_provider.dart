import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/user_service.dart';

// This provider is used to access the UserService instance throughout the app.
final userServiceProvider = Provider((ref) {
  return UserService();
});
