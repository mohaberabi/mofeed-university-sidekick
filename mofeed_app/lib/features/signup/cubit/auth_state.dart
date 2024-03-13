import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mofeed_shared/model/university_model.dart';

enum SignUpStatus {
  initial,
  loading,
  error,
  emailVerificationSent,
  emailNotVerified,
  emailVerified;

  bool get isEmailVerified => this == SignUpStatus.emailVerified;

  bool get isLoading => this == SignUpStatus.loading;

  bool get isError => this == SignUpStatus.error;

  bool get isEmailSent => this == SignUpStatus.emailVerificationSent;

  bool get isEmailNotVerified => this == SignUpStatus.emailNotVerified;
}

class SignUpState extends Equatable {
  final String error;
  final SignUpStatus state;
  final String email;
  final String password;
  final UniversityModel choosedUniversity;
  final String name;

  final String lastName;
  final bool isPassword;

  const SignUpState({
    this.error = '',
    this.state = SignUpStatus.initial,
    this.email = '',
    this.password = '',
    this.isPassword = true,
    this.choosedUniversity = UniversityModel.empty,
    this.lastName = '',
    this.name = '',
  });

  SignUpState copyWith({
    String? error,
    SignUpStatus? state,
    String? email,
    String? password,
    bool? isPassword,
    String? name,
    String? lastName,
    UniversityModel? choosedUniversity,
  }) =>
      SignUpState(
        choosedUniversity: choosedUniversity ?? this.choosedUniversity,
        isPassword: isPassword ?? this.isPassword,
        password: password ?? this.password,
        email: email ?? this.email,
        error: error ?? this.error,
        state: state ?? this.state,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
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
        choosedUniversity,
        name,
        lastName
      ];

  factory SignUpState.initial() => const SignUpState();

  bool get buttonEnabled {
    return !choosedUniversity.isEmpty && isEmailValid && password.isNotEmpty;
  }

  bool get choosedUni => !choosedUniversity.isEmpty;

  IconData get passWordIcon =>
      isPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash;

  bool get isEmailValid => email.isNotEmpty;

  String get uniEmail => "$email${choosedUniversity.domain}";
}
