import 'package:food_court/model/restaurant_model.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

abstract class RestaurntRepository {
  FutureEither<RestarantModel> getRestaurant();

  FutureVoid updateResturant(RestarantModel restarant);
}
