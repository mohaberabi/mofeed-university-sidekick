import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ErrorCodes {
  static const String noNetWork = "noNetWork";
  static const String unKnownError = "unKnownError";
  static const String emailInUse = "emailInUse";
  static const String wrongPass = "wrongPass";
  static const String tooManyReq = "tooManyReq";
  static const String inputVeryShort50 = "Please Be More precised";

  static const String invalidEmail = "invalidEmail";
  static const String weakPassword = "weakPassword";
  static const String emailReq = "emailReq";
  static const String canceled = "canceled";
  static const String notSameRestaurantId = "notSameRestaurantId";
  static const String timeOut = "timeOut";
  static const String invalidArgs = "invalidArgs";
  static const String permissionDenied = "permissionDenied";
  static const String unavailable = "unavailable";
  static const String notFound = "notFound";
  static const String invalidTextFromat = "invalidTextFromat";

  static const String noDomainNeededEmail =
      "Wrong email address please enter your email without @ or the domain ";
  static const String required = "required";
  static const String sixCharPass = "mustBeAtLeast6Char";
  static const String wrongPhone = "wrongPhone";

  /// /// // /// / /

  static const String errorOrderTitle =
      "There is an issue while placing your order";
}

extension ErrorMapper on FirebaseException {
  String get mapCodeToError {
    switch (code) {
      case 'unknown':
        return ErrorCodes.unKnownError;
      case 'unavailable':
        return ErrorCodes.unavailable;
      case 'permission-denied':
        return ErrorCodes.permissionDenied;
      case 'invalid-argument':
        return ErrorCodes.invalidArgs;
      case 'not-found':
        return ErrorCodes.notFound;
      case 'timeout':
        return ErrorCodes.timeOut;
      case 'cancelled':
        return ErrorCodes.canceled;
      case 'too-many-requests':
        return ErrorCodes.tooManyReq;
      default:
        return ErrorCodes.unKnownError;
    }
  }
}

extension AuthErrorMapper on FirebaseAuthException {
  String get mapCodeToError {
    switch (code) {
      case "email-already-in-use":
        return ErrorCodes.emailInUse;
      case "wrong-password":
        return ErrorCodes.wrongPass;
      case "too-many-requests":
        return ErrorCodes.tooManyReq;
      case 'invalid-email':
        return ErrorCodes.invalidEmail;
      case 'missing-email':
        return ErrorCodes.emailReq;
      case 'weak-password':
        return ErrorCodes.weakPassword;
      case 'user-not-found':
        return ErrorCodes.notFound;
      default:
        return ErrorCodes.unKnownError;
    }
  }
}
