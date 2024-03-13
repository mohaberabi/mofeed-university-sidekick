import 'dart:io';

import 'package:mofeed_shared/utils/typdefs/typedefs.dart';



import '../model/car_model.dart';
abstract class CarRepository {
  FutureVoid removeCar (String id );
  FutureEither<List<CarModel>> getAllBlockers();
  FutureEither<List<CarModel>> getMyAllCars();
  FutureEither<CarModel?> getCachedFavoriteCar();
  FutureVoid requestCarAddition({
    required File backCarLicense,
    required File frontCarLicense,
    required String ownerId,
  });
}
