import 'package:firebase_auth/firebase_auth.dart';
import 'package:mofeed_shared/cubit/navigation_cubit/navigation_cubit.dart';

import '../../auth/data/user_storage.dart';

class AcceptNavCubit extends NavigationCubit {
  final FirebaseAuth _auth;
  final AuthStorage _storage;

  AcceptNavCubit({
    required FirebaseAuth auth,
    required AuthStorage storage,
  })  : _auth = auth,
        _storage = storage;

  @override
  void clearAndRestart() {}

  @override
  void goToChooseLanguage() {}

  @override
  void navigateOnStartUp() async {
    try {
      await Future.microtask(() => null);
      final user = _auth.currentUser;
      if (user == null) {
        goAuth();
        return;
      }
      final uid = await _storage.getUid();
      if (uid == null) {
        goAuth();
        return;
      }
      goHome();
    } catch (e, st) {
      goAuth();
    }
  }

  void goHome() => emit(const GoHomeScreen());

  void goAuth() => emit(GoToAuth());

  @override
  void pop() {}
}
