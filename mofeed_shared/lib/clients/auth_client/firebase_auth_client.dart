import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mofeed_shared/clients/auth_client/auth_client.dart';
import 'package:mofeed_shared/model/client_user_model.dart';
import 'package:mofeed_shared/model/user_model.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';

import '../../constants/fireabse_constants.dart';
import '../../utils/typdefs/typedefs.dart';

class FirebaseAuthClient implements AuthClient {
  final FirebaseFirestore _firestore;

  final FirebaseAuth _auth;

  const FirebaseAuthClient({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _auth = auth,
        _firestore = firestore;

  @override
  Stream<UserModel> listenToUser() {
    return _auth.authStateChanges().asyncExpand((user) {
      return user == null
          ? Stream.value(ClientUser.anonymus)
          : _users.doc(user.uid).snapshots().map((event) => event.data() == null
              ? ClientUser.anonymus
              : UserModel.fromMap(event.data()!));
    });
  }

  @override
  Future<void> sendPasswordRestLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e, st) {
      Error.throwWithStackTrace(SendPasswrodRestFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final uid = cred.user!.uid;
      final user = await _users
          .doc(uid)
          .get()
          .then((value) => UserModel.fromMap(value.data()!));
      return user;
    } on FirebaseAuthException catch (e, st) {
      Error.throwWithStackTrace(
          SignInWithEmailAndPasswordFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e, st) {
      Error.throwWithStackTrace(SignOutFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    try {
      await _users.doc(user.uId).set(user.toMap());
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(UpdateUserFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? univeristyId,
    required String name,
    required String lastName,
    required String phone,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final uid = cred.user!.uid;
      await _users.doc(uid).set(ClientUser.anonymus
          .copyWith(
              uniId: univeristyId,
              email: email,
              name: name,
              uId: uid,
              lastname: lastName,
              phone: phone)
          .toMap());
      final user = await _users
          .doc(uid)
          .get()
          .then((value) => UserModel.fromMap(value.data()!));
      return user;
    } on FirebaseAuthException catch (e, st) {
      Error.throwWithStackTrace(
          CreateUserWithEmailAndPassowrdFailure(e.mapCodeToError), st);
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(
          CreateUserWithEmailAndPassowrdFailure(e.mapCodeToError), st);
    }
  }

  CollectionReference<MapJson> get _users =>
      _firestore.collection(FirebaseConst.users);

  @override
  Stream<ClientUser?> userStateChanged() =>
      _auth.userChanges().map((e) => e?.toClientUser());

  @override
  Future<void> sendEmailVerification() async {
    try {
      if (_auth.currentUser == null) {
        throw const SendEmailVerificationFailure(ErrorCodes.unavailable);
      } else {
        await _auth.currentUser!.sendEmailVerification();
      }
    } catch (e, st) {
      Error.throwWithStackTrace(SendEmailVerificationFailure(e), st);
    }
  }

  @override
  Future<bool> checkEmailVerified() async {
    try {
      if (_auth.currentUser == null) {
        throw const CheckEmailVerificationFailure(ErrorCodes.unavailable);
      }
      await _auth.currentUser!.reload();
      return _auth.currentUser!.emailVerified;
    } catch (e, st) {
      Error.throwWithStackTrace(CheckEmailVerificationFailure(e), st);
    }
  }
}

extension FbUserToAppUser on User {
  ClientUser toClientUser() => ClientUser(
        name: displayName ?? "",
        phone: phoneNumber ?? "",
        uId: uid,
        lastname: displayName ?? "",
        token: "",
        uniId: "",
        email: email ?? "",
        verified: emailVerified,
      );
}
