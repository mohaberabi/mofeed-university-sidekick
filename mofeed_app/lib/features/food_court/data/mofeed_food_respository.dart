import 'package:dartz/dartz.dart';
import 'package:food_court/model/restaurant_model.dart';
import 'package:food_court/repository/food_repository.dart';
import 'package:food_court/utils/typdefs/typdefs.dart';
import 'package:mofeed_shared/clients/foodcourt_client/food_court_client.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';
import 'package:mofeed_shared/utils/error/failure.dart';
import 'package:mofeed_shared/utils/pair.dart';
import 'package:mofeed_shared/utils/triple.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';
import '../../university/data/university_storage.dart';

class MofeedFoodRepository implements UserFoodRepository {
  final FoodCourtClient _foodCourtClient;

  final NetWorkInfo _netWorkInfo;
  final UniversityStorage _universityStorage;

  const MofeedFoodRepository({
    required FoodCourtClient foodCourtClient,
    required NetWorkInfo netWorkInfo,
    required UniversityStorage universityStorage,
  })  : _universityStorage = universityStorage,
        _netWorkInfo = netWorkInfo,
        _foodCourtClient = foodCourtClient;

  @override
  FutureEither<RestarantModel> getRestaurant(String id) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final rest = await _foodCourtClient.getRestaurant(id);
        return Right(rest);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<RestaurantDetail> getRestaurantDetail(String id) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final rest = await _foodCourtClient.getRestaurant(id);
        final items = await _foodCourtClient.getItems(id);
        final cats = await _foodCourtClient.getCategories(id);
        final RestaurantDetail detail =
            Triple(first: rest, second: items, third: cats);
        return Right(detail);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<List<RestarantModel>> getRestaurants({
    int limit = 10,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uniId = await _universityStorage.getUniId();
        if (uniId == null) {
          return const Left(Failure(ErrorCodes.unKnownError));
        }
        final rests =
            await _foodCourtClient.getRestaurnats(uniId: uniId, limit: limit);
        return Right(rests);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<ItemWithVariants> getItemWithVariants({
    required String id,
    required String restaurantId,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(Failure(ErrorCodes.noNetWork));
      } else {
        final item =
            await _foodCourtClient.getItem(id: id, restId: restaurantId);
        if (!item.isVariable) {
          return Right(Pair(item, []));
        } else {
          final options = await _foodCourtClient.getItemOpions(
              restId: restaurantId, itemId: id);
          return Right(Pair(item, options));
        }
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }
}
