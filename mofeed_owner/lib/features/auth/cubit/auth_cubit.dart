import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_shared/data/auth_repository.dart';
import 'package:mofeed_shared/error/error_codes.dart';
import 'package:mofeed_shared/model/client_user_model.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';
import 'package:mofeed_shared/utils/mixins/cubitEmitter.dart';
import 'package:mofeed_shared/utils/mixins/validation_mixin.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> with ValidationMixin, CubitEmiiter {
  AuthCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthStates());
  final AuthRepository _authRepository;

  void copyUniversityData({required String domain, required String id}) =>
      emit(state.copyWith(universityDomain: domain, universityId: id));

  void changeVisibillity() =>
      emit(state.copyWith(isPassword: !state.isPassword));

  void login() async {
    emitLoading();
    final res = await _authRepository.signInwithEmailAndPassword(
        state.universityEmail, state.password);
    res.fold((l) => emitError(l.error), (uid) => emitDone());
  }

  void sendPasswordResetLink({String? email}) async {
    emitLoading();
    final res =
        await _authRepository.sendResetPassword(email ?? state.universityEmail);
    res.fold((l) => emitError(l.error), (r) {
      emit(state.copyWith(state: CubitState.done));
    });
  }

  void emailChanged(String email) {
    final error = validateEmail(email);
    emit(state.copyWith(
      email: email,
      emailError: error,
      state: CubitState.initial,
    ));
  }

  void passWordChanged(String password) =>
      emit(state.copyWith(password: password, state: CubitState.initial));

  @override
  emitLoading() => emit(state.copyWith(state: CubitState.loading));

  @override
  emitDone() => emit(state.copyWith(state: CubitState.done));

  @override
  emitError(String error, {StackTrace? st}) =>
      emit(state.copyWith(state: CubitState.error, error: error));

  @override
  emitInitial() => emit(state.copyWith(state: CubitState.initial));
}
