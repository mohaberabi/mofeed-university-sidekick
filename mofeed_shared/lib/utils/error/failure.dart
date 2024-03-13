import 'error_codes.dart';

class Failure {
  final String error;
  final StackTrace? stackTrace;

  const Failure(this.error, [this.stackTrace]);
}

const netWorkFailure = Failure(ErrorCodes.noNetWork);
