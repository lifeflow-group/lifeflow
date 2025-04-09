import 'package:flutter_riverpod/flutter_riverpod.dart';

final obscureTextProvider = StateProvider<bool>((ref) => true);

// Provider containing functions to update data
final loginControllerProvider = Provider((ref) {
  return LoginController(ref);
});

class LoginController {
  LoginController(this.ref);
  final Ref ref;

  void toggleObscureText() {
    final current = ref.read(obscureTextProvider);
    ref.read(obscureTextProvider.notifier).state = !current;
  }
}
