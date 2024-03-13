import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'error_codes.dart';

abstract class AppException with EquatableMixin implements Exception {
  final Object? error;
  final bool isDebug;

  const AppException(this.error, {this.isDebug = kDebugMode});

  @override
  List<Object?> get props => [error, isDebug];

  @override
  String toString() {
    if (isDebug) {
      return super.toString();
    } else {
      return error.toString();
    }
  }
}

class NetWorkConnectionFailure extends AppException {
  const NetWorkConnectionFailure() : super(ErrorCodes.noNetWork);
}
