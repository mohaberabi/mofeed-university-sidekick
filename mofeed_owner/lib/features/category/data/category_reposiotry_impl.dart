import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_court/model/category_model.dart';
import 'package:food_court/repository/category_repository.dart';
import 'package:mofeed_owner/features/auth/data/user_storage.dart';
import 'package:mofeed_shared/constants/fireabse_constants.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/error/error_codes.dart';
import 'package:mofeed_shared/error/failure.dart';
import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final AuthStorage _storage;

  final FirebaseFirestore _firestore;
  final NetWorkInfo _netWorkInfo;

  const CategoryRepositoryImpl({
    required AuthStorage storage,
    required FirebaseFirestore firestore,
    required NetWorkInfo netWorkInfo,
  })  : _firestore = firestore,
        _netWorkInfo = netWorkInfo,
        _storage = storage;

  @override
  FutureVoid addCategory(CategoryModel category) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();
        await _restaurants
            .doc(uid)
            .collection(FirebaseConst.categories)
            .doc(category.id)
            .set(category.toMap());
        return const Right(unit);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    } on StorageException catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  FutureVoid deleteCategory(String id) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();
        await _restaurants
            .doc(uid)
            .collection(FirebaseConst.categories)
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
  FutureEither<List<CategoryModel>> getCategories() async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();
        final cat = await _restaurants
            .doc(uid)
            .collection(FirebaseConst.categories)
            .get()
            .then((value) => value.docs
                .map((e) => CategoryModel.fromJson(e.data()))
                .toList());
        return Right(cat);
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
