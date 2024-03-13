import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_court/model/option_group.dart';
import 'package:food_court/repository/food_option_repository.dart';
import 'package:mofeed_owner/features/auth/data/user_storage.dart';
import 'package:mofeed_shared/constants/fireabse_constants.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/error/error_codes.dart';
import 'package:mofeed_shared/error/failure.dart';
import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class FoodOptionRepositoryImpl implements FoodOptionRepository {
  final FirebaseFirestore _firestore;
  final NetWorkInfo _netWorkInfo;
  final AuthStorage _authStorage;

  const FoodOptionRepositoryImpl({
    required FirebaseFirestore firestore,
    required NetWorkInfo netWorkInfo,
    required AuthStorage storage,
  })  : _authStorage = storage,
        _netWorkInfo = netWorkInfo,
        _firestore = firestore;

  @override
  FutureVoid addOption(OptionGroup optionGroup) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _authStorage.getUid();
        await _restaurants
            .doc(uid)
            .collection(FirebaseConst.variants)
            .doc(optionGroup.id)
            .set(optionGroup.toMap());
        return const Right(unit);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    } on StorageException catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  FutureVoid deleteOption(String id) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _authStorage.getUid();
        await _restaurants
            .doc(uid)
            .collection(FirebaseConst.variants)
            .doc(id)
            .delete();
        return const Right(unit);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    } on StorageException catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<List<OptionGroup>> getOptions() async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _authStorage.getUid();
        final options = await _restaurants
            .doc(uid)
            .collection(FirebaseConst.variants)
            .get()
            .then((value) =>
                value.docs.map((e) => OptionGroup.fromJson(e.data())).toList());
        return Right(options);
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
