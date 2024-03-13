import 'package:mofeed_shared/model/rating_model.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

abstract class RatingRepository {
  FutureEither<List<RatingModel>> getRatings({
    String? restaurantId,
    String? lastDocId,
    int limit = 10,
  });
}

abstract class UserRatingRepository implements RatingRepository {
  FutureVoid rate({
    required String restaurantId,
    required RatingModel rating,

    required String orderId,
  });
}
