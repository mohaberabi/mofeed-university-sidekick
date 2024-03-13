import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_court/model/restaurant_model.dart';
import 'package:food_court/repository/restaurant_repository.dart';
import 'package:mofeed_owner/features/auth/data/user_storage.dart';
import 'package:mofeed_shared/constants/fireabse_constants.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/error/error_codes.dart';
import 'package:mofeed_shared/error/failure.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class RestaurantRepositoryImpl implements RestaurntRepository {
  final AuthStorage _storage;

  final FirebaseFirestore _firestore;
  final NetWorkInfo _netWorkInfo;

  const RestaurantRepositoryImpl({
    required FirebaseFirestore firestore,
    required AuthStorage storage,
    required NetWorkInfo netWorkInfo,
  })  : _firestore = firestore,
        _netWorkInfo = netWorkInfo,
        _storage = storage;

  @override
  FutureEither<RestarantModel> getRestaurant() async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();
        final rest = await _restaurnats
            .doc(uid)
            .get()
            .then((value) => RestarantModel.fromMap(value.data()!));
        return Right(rest);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }

  @override
  FutureVoid updateResturant(RestarantModel restarant) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();

        await _restaurnats.doc(uid).set(restarant.toMap());
        return const Right(unit);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }

  CollectionReference<MapJson> get _restaurnats =>
      _firestore.collection(FirebaseConst.restaurants);
}
