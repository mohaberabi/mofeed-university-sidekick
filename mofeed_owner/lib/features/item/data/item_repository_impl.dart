import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_court/model/category_model.dart';
import 'package:food_court/model/item_model.dart';
import 'package:food_court/model/option_group.dart';
import 'package:food_court/repository/item_repository.dart';
import 'package:mofeed_owner/features/auth/data/user_storage.dart';
import 'package:mofeed_shared/constants/fireabse_constants.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/error/error_codes.dart';
import 'package:mofeed_shared/error/failure.dart';
import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class ItemRepositoryImpl implements ItemRepository {
  final FirebaseFirestore _firestore;

  final AuthStorage _storage;

  final NetWorkInfo _netWorkInfo;

  const ItemRepositoryImpl({
    required FirebaseFirestore firestore,
    required NetWorkInfo netWorkInfo,
    required AuthStorage storage,
  })  : _storage = storage,
        _netWorkInfo = netWorkInfo,
        _firestore = firestore;

  @override
  FutureVoid addItem(ItemModel item) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();
        await _restaurants
            .doc(uid)
            .collection(FirebaseConst.items)
            .doc(item.id)
            .set(item.toMap());
        return const Right(unit);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    } on StorageException catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  FutureVoid deleteItem(String id) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();
        await _restaurants
            .doc(uid)
            .collection(FirebaseConst.items)
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
  FutureEither<List<ItemModel>> getItems({
    String? restarantId,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();
        final items = await _restaurants
            .doc(uid)
            .collection(FirebaseConst.items)
            .get()
            .then((value) =>
                value.docs.map((e) => ItemModel.fromJson(e.data())).toList());
        return Right(items);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    } on StorageException catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  CollectionReference<MapJson> get _restaurants =>
      _firestore.collection(FirebaseConst.restaurants);

  @override
  FutureEither<List<OptionGroup>> getItemVariants({
    required List<String> ids,
  }) async {
    try {
      if (ids.isEmpty) {
        return const Right([]);
      }
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();
        final variants = <OptionGroup>[];
        final coll = _restaurants.doc(uid).collection(FirebaseConst.variants);
        for (final docId in ids) {
          final doc = await coll.doc(docId).get();
          if (!doc.exists) {
            continue;
          }
          final optionGroup = OptionGroup.fromJson(doc.data()!);
          variants.add(optionGroup);
        }
        return Right(variants);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    } on StorageException catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<CategoryModel> getItemCategory(String id) async {
    try {
      if (id.isEmpty) {
        return const Right(CategoryModel.empty);
      }
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();
        final cat = await _restaurants
            .doc(uid)
            .collection(FirebaseConst.categories)
            .doc(id)
            .get()
            .then((value) => value.data() == null
                ? CategoryModel.empty
                : CategoryModel.fromJson(value.data()!));

        return Right(cat);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    } on StorageException catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }
}
