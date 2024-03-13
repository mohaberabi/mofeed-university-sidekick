import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

class MofeedState extends Equatable {
  final String legal;
  final String error;
  final int index;

  final CubitState state;

  const MofeedState({
    this.legal = '',
    this.state = CubitState.initial,
    this.error = '',
    this.index = 0,
  });

  @override
  List<Object?> get props => [
        state,
        index,
      ];

  MofeedState copyWith({
    CubitState? state,
    String? error,
    int? index,
  }) =>
      MofeedState(
        state: state ?? this.state,
        error: error ?? this.error,
        index: index ?? this.index,
      );

  @override
  String toString() => state.name;
}
