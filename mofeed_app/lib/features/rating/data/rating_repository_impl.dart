import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_court/repository/rating_repository.dart';
import 'package:mofeed_shared/clients/rating_client/rating_client.dart';

import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/model/rating_model.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';
import 'package:mofeed_shared/utils/error/failure.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class RatingRepositoryImpl implements UserRatingRepository {
  final RatingClient _ratingClient;
  final NetWorkInfo _netWorkInfo;

  const RatingRepositoryImpl({
    required RatingClient ratingClient,
    required NetWorkInfo netWorkInfo,
  })  : _ratingClient = ratingClient,
        _netWorkInfo = netWorkInfo;

  @override
  FutureEither<List<RatingModel>> getRatings({
    String? restaurantId,
    String? lastDocId,
    int limit = 10,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final ratings = await _ratingClient.geRatings(
          restaurantId: restaurantId,
          lastDocId: lastDocId,
          limit: limit,
        );
        return Right(ratings);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }

  @override
  FutureVoid rate({
    required String restaurantId,
    required RatingModel rating,
    required String orderId,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        await _ratingClient.rate(
            restaurantId: restaurantId, rating: rating, orderId: orderId);
        return const Right(unit);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }
}
