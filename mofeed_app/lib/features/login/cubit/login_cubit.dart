import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_shared/model/client_user_model.dart';
import 'package:mofeed_shared/utils/mixins/validation_mixin.dart';
import '../../signup/data/mofeed_auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with ValidationMixin {
  LoginCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState());

  final AuthRepository _authRepository;

  void changeVisibillity() =>
      emit(state.copyWith(isPassword: !state.isPassword));

  void login() async {
    emitLoading();

    final res = await _authRepository.signInwithEmailAndPassword(
        state.email, state.password);
    res.fold((l) {
      emitError(l.error);
    }, (user) => _handleWhenLoggedIn(user));
  }

  void _handleWhenLoggedIn(ClientUser client) async {
    try {
      final didVerifyAccount = await _authRepository.checkEmailVerified();

      if (!didVerifyAccount) {
        emit(state.copyWith(state: LoginStatus.authAndNeedVerifiaction));
      } else {
        emit(state.copyWith(
            state: client.completedProfile
                ? LoginStatus.authedAndReady
                : LoginStatus.autheNeedsComplete));
      }
    } catch (e, st) {
      emitError(e.toString(), st: st);
    }
  }

  void sendPasswordResetLink({String? email}) async {
    emitLoading();
    final res = await _authRepository.sendResetPassword(email ?? state.email);
    res.fold((l) => emitError(l.error), (r) {
      emit(state.copyWith(state: LoginStatus.passwordResetSent));
    });
  }

  void formChanged({
    String? email,
    String? password,
  }) {
    emit(state.copyWith(email: email, password: password));
  }

  void signOut() async {
    final res = await _authRepository.signOut();
    res.fold((l) => emitError(l.error), (r) {
      emit(state.copyWith(state: LoginStatus.unAuthed));
    });
  }

  emitLoading() => emit(state.copyWith(state: LoginStatus.loading));

  emitError(String error, {StackTrace? st}) =>
      emit(state.copyWith(state: LoginStatus.error, error: error));

  emitInitial() => emit(state.copyWith(state: LoginStatus.initial));
}
