import 'package:equatable/equatable.dart';

import '../../model/open_street.dart';

abstract class AutoCompleteClient {
  Future<List<AutoCompleteResponse>> getAddress(String query);
}

abstract class AutoCompleteException with EquatableMixin implements Exception {
  final Object? error;

  const AutoCompleteException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => error.toString();
}

class GetAddressFailure extends AutoCompleteException {
  const GetAddressFailure(super.error);
}
