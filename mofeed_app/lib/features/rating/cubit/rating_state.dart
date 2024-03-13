import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/model/rating_model.dart';

enum RatingStatus {
  initial,
  loading,
  error,
  rated,
  populated,
}

class RatingState extends Equatable {
  final RatingStatus status;
  final List<RatingModel> ratings;
  final String error;

  final int value;

  final String rate;

  const RatingState({
    this.status = RatingStatus.initial,
    this.value = -1,
    this.error = '',
    this.rate = '',
    this.ratings = const [],
  });

  @override
  List<Object?> get props => [status, value, error, rate, ratings];

  RatingState copyWith({
    RatingStatus? status,
    String? error,
    int? value,
    String? rate,
    List<RatingModel>? ratings,
  }) {
    return RatingState(
      ratings: ratings ?? this.ratings,
      status: status ?? this.status,
      error: error ?? this.error,
      value: value ?? this.value,
      rate: rate ?? this.rate,
    );
  }

  @override
  String toString() => status.name;
}
