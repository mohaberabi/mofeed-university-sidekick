import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_court/repository/rating_repository.dart';
import 'package:mofeed_owner/features/auth/data/user_storage.dart';
import 'package:mofeed_shared/constants/fireabse_constants.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/error/error_codes.dart';
import 'package:mofeed_shared/error/failure.dart';
import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:mofeed_shared/model/rating_model.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class RatingRepositoryImpl implements RatingRepository {
  final FirebaseFirestore _firestore;

  final AuthStorage _storage;

  final NetWorkInfo _netWorkInfo;

  const RatingRepositoryImpl({
    required FirebaseFirestore firestore,
    required AuthStorage storage,
    required NetWorkInfo netWorkInfo,
  })  : _firestore = firestore,
        _storage = storage,
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
        final uid = await _storage.getUid();
        final query = _restaurants
            .doc(uid)
            .collection(FirebaseConst.ratings)
            .orderBy("createdAt", descending: true)
            .limit(limit);
        final ratings = await firestorePagination<RatingModel>(
            query: query,
            lastDocColl:
                _restaurants.doc(uid).collection(FirebaseConst.ratings),
            mapList: (list) async {
              return list.map((e) => RatingModel.fromMap(e)).toList();
            });
        return Right(ratings);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    } on StorageException catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  CollectionReference<MapJson> get _restaurants =>
      _firestore.collection(FirebaseConst.restaurants);
}
