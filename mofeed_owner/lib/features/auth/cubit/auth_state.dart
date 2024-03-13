import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

class AuthStates extends Equatable {
  final String error;
  final CubitState state;
  final String email;
  final String universityId;
  final String universityDomain;
  final String password;
  final String? emailError;
  final bool isPassword;

  const AuthStates({
    this.error = '',
    this.state = CubitState.initial,
    this.universityId = '',
    this.email = '',
    this.password = '',
    this.universityDomain = '',
    this.emailError,
    this.isPassword = true,
  });

  AuthStates copyWith({
    String? error,
    CubitState? state,
    String? email,
    String? universityId,
    String? universityDomain,
    String? password,
    String? emailError,
    bool? isPassword,
  }) =>
      AuthStates(
        isPassword: isPassword ?? this.isPassword,
        password: password ?? this.password,
        email: email ?? this.email,
        universityDomain: universityDomain ?? this.universityDomain,
        universityId: universityId ?? this.universityId,
        error: error ?? this.error,
        state: state ?? this.state,
        emailError: emailError ?? (emailError == null ? null : this.emailError),
      );

  @override
  List<Object?> get props => [
        error,
        state,
        universityDomain,
        universityId,
        email,
        password,
        emailError,
        isPassword,
      ];

  String get universityEmail => '$email$universityDomain';

  IconData get passWordIcon =>
      isPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash;

  bool get isEmailValid => emailError == null && email.isNotEmpty;
}
