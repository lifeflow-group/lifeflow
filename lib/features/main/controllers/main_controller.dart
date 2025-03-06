import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexTabProvider = StateProvider<int>((ref) => 0);

final mainControllerProvider = Provider((ref) => MainController(ref));

class MainController {
  final Ref ref;

  MainController(this.ref);

  void setTab(int index) {
    ref.read(indexTabProvider.notifier).state = index;
  }
}
