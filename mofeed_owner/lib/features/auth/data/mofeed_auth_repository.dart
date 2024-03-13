import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mofeed_owner/features/auth/data/user_storage.dart';
import 'package:mofeed_shared/data/auth_repository.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/error/error_codes.dart';
import 'package:mofeed_shared/error/failure.dart';

import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final AuthStorage _authStorage;

  const AuthRepositoryImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required AuthStorage userStorage,
    required NetWorkInfo netWorkInfo,
  })  : _authStorage = userStorage,
        _auth = auth;

  @override
  FutureVoid deleteAccount() async {
    throw UnimplementedError();
  }

  @override
  FutureVoid sendResetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.mapCodeToError));
    }
  }

  @override
  FutureEither<String> signInwithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final uid = cred.user!.uid;
      await _authStorage.saveUid(uid);
      return Right(uid);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.mapCodeToError));
    }
  }

  @override
  FutureVoid signOut() async {
    try {
      await _auth.signOut();
      await _authStorage.clear();
      return const Right(unit);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
