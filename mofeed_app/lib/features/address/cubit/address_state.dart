import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/model/open_street.dart';

enum AddressStatus {
  initial,
  loading,
  error,
  populated;
}

class AddressState extends Equatable {
  final String error;
  final String query;
  final AddressStatus state;

  final List<AutoCompleteResponse> addresses;

  const AddressState({
    this.error = '',
    this.state = AddressStatus.initial,
    this.addresses = const [],
    this.query = '',
  });

  @override
  List<Object?> get props => [
        error,
        state,
        addresses,
        query,
      ];

  AddressState copyWith({
    String? error,
    AddressStatus? state,
    List<AutoCompleteResponse>? addresses,
    String? query,
  }) {
    return AddressState(
      error: error ?? this.error,
      state: state ?? this.state,
      addresses: addresses ?? this.addresses,
      query: query ?? this.query,
    );
  }

  @override
  String toString() => state.name;
}
