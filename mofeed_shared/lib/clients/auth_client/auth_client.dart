import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mofeed_shared/model/user_model.dart';

abstract class AuthClient {
  Future<void> signOut();

  Future<void> updateUser(UserModel user);

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> sendEmailVerification();

  Future<bool> checkEmailVerified();

  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? univeristyId,
    required String name,
    required String lastName,
    required String phone,
  });

  Stream<UserModel> listenToUser();

  Future<void> sendPasswordRestLink(String email);
}

abstract class AuthException with EquatableMixin implements Exception {
  final Object? error;

  const AuthException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => error.toString();
}

class SignOutFailure extends AuthException {
  const SignOutFailure(super.error);
}

class UpdateUserFailure extends AuthException {
  const UpdateUserFailure(super.error);
}

class SignInWithEmailAndPasswordFailure extends AuthException {
  const SignInWithEmailAndPasswordFailure(super.error);
}

class CreateUserWithEmailAndPassowrdFailure extends AuthException {
  const CreateUserWithEmailAndPassowrdFailure(super.error);
}

class SendPasswrodRestFailure extends AuthException {
  const SendPasswrodRestFailure(super.error);
}

class SendEmailVerificationFailure extends AuthException {
  const SendEmailVerificationFailure(super.error);
}

class CheckEmailVerificationFailure extends AuthException {
  const CheckEmailVerificationFailure(super.error);
}
