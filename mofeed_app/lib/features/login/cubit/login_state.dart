import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum LoginStatus {
  initial,
  loading,
  error,
  authedAndReady,
  autheNeedsComplete,
  authAndNeedVerifiaction,
  passwordResetSent,
  unAuthed;

  bool get isAuthedAndNeedVerification =>
      this == LoginStatus.authAndNeedVerifiaction;

  bool get isLoading => this == LoginStatus.loading;

  bool get isError => this == LoginStatus.error;

  bool get isAuthedAndReady => this == LoginStatus.authedAndReady;

  bool get isAuthAndNeedComplete => this == LoginStatus.autheNeedsComplete;

  bool get isPassWordResetSent => this == LoginStatus.passwordResetSent;

  bool get isUnAthed => this == LoginStatus.unAuthed;
}

class LoginState extends Equatable {
  final String error;
  final LoginStatus state;
  final String email;
  final String password;

  final bool isPassword;

  const LoginState({
    this.error = '',
    this.state = LoginStatus.initial,
    this.email = '',
    this.password = '',
    this.isPassword = true,
  });

  LoginState copyWith({
    String? error,
    LoginStatus? state,
    String? email,
    String? password,
    bool? isPassword,
  }) =>
      LoginState(
        isPassword: isPassword ?? this.isPassword,
        password: password ?? this.password,
        email: email ?? this.email,
        error: error ?? this.error,
        state: state ?? this.state,
      );

  @override
  String toString() => state.name;

  @override
  List<Object?> get props => [
        error,
        state,
        email,
        password,
        isPassword,
      ];

  factory LoginState.initial() => const LoginState();

  IconData get passWordIcon =>
      isPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash;

  bool get canLogin => email.trim().isNotEmpty && password.trim().isNotEmpty;
}
