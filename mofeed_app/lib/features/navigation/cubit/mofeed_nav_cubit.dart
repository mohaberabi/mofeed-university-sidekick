import 'package:bloc/bloc.dart';
import 'package:mofeed_shared/cubit/navigation_cubit/navigation_cubit.dart';

import '../data/startup_repository.dart';
import 'mofeed_nav_state.dart';

class NavigationCubit extends Cubit<NavState> {
  final StartupRepository _startupRepository;

  NavigationCubit({
    required StartupRepository startupRepository,
  })  : _startupRepository = startupRepository,
        super(const NavInitState());

  void navigateOnStartUp() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final onBoarding = await _startupRepository.didSeeOnBoarding();

      if (!onBoarding) {
        await _startupRepository.clearAppFiles();
        goOnBoarding();
        return;
      }

      final createdAccount = await _startupRepository.didCreateAccount();

      if (!createdAccount) {
        goToChooseUniversity();
        return;
      }

      final verified = await _startupRepository.verifiedAccount();
      if (!verified) {
        goVerifyAccount();
        return;
      }

      final completedProfile = await _startupRepository.didCompleteProfile();

      if (!completedProfile) {
        goToCompleteProfile();
        return;
      }

      goToHome();
    } catch (e, st) {
      goOnBoarding();
      addError(e, st);
    }
  }

  void goOnBoarding() => emit(const GoOnBoarding());

  void goVerifyAccount() => emit(const GoVerifyAccount());

  void goToChooseUniversity() => emit(const GoChooseUniversity());

  void goToHome() => emit(const GoHomeScreen());

  void goToCompleteProfile() => emit(const GoCompleteProfile());
}
