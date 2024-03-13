import 'package:equatable/equatable.dart';
import 'package:food_court/model/restaurant_model.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

class RestarantState extends Equatable {
  final String error;
  final RestarantModel restarant;
  final CubitState state;

  const RestarantState({
    this.restarant = RestarantModel.empty,
    this.error = '',
    this.state = CubitState.initial,
  });

  RestarantState copyWith({
    String? error,
    RestarantModel? restarant,
    CubitState? state,
  }) {
    return RestarantState(
      error: error ?? this.error,
      restarant: restarant ?? this.restarant,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [
        error,
        restarant,
        state,
      ];

  bool get readyUpdate =>
      restarant.cuisines.isNotEmpty && restarant.name.isNotEmpty;
}
