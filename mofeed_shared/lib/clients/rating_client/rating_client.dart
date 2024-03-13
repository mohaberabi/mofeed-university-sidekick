import 'package:equatable/equatable.dart';

import '../../model/rating_model.dart';

abstract class RatingClient {
  Future<void> rate({
    required String restaurantId,
    required RatingModel rating,
    required String orderId,
  });

  Future<List<RatingModel>> geRatings({
    String? restaurantId,
    String? lastDocId,
    int limit = 10,
  });
}

abstract class RatingException with EquatableMixin implements Exception {
  final Object? error;

  const RatingException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => error.toString();
}

class GetRatingsFailure extends RatingException {
  const GetRatingsFailure(super.error);
}

class AddRateFailure extends RatingException {
  const AddRateFailure(super.error);
}
