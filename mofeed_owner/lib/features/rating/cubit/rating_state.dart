import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/model/rating_model.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

class RatingState extends Equatable {
  final String erorr;

  final CubitState state;
  final List<RatingModel> ratings;

  const RatingState({
    this.state = CubitState.initial,
    this.ratings = const [],
    this.erorr = '',
  });

  @override
  List<Object?> get props => [erorr, ratings, state];

  RatingState copyWith({
    String? erorr,
    CubitState? state,
    List<RatingModel>? ratings,
  }) {
    return RatingState(
      erorr: erorr ?? this.erorr,
      state: state ?? this.state,
      ratings: ratings ?? this.ratings,
    );
  }
}
