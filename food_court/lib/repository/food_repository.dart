import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

import '../model/restaurant_model.dart';
import '../utils/typdefs/typdefs.dart';

abstract class UserFoodRepository {
  FutureEither<List<RestarantModel>> getRestaurants({int limit=10});

  FutureEither<RestaurantDetail> getRestaurantDetail(String id);

  FutureEither<RestarantModel> getRestaurant(String id);

  FutureEither<ItemWithVariants> getItemWithVariants({
    required String id,
    required String restaurantId,
  });
}
