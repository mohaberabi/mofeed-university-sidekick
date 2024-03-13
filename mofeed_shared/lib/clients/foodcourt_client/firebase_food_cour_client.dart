import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_court/model/category_model.dart';
import 'package:food_court/model/item_model.dart';
import 'package:food_court/model/option_group.dart';
import 'package:food_court/model/restaurant_model.dart';
import 'package:mofeed_shared/clients/foodcourt_client/food_court_client.dart';
import 'package:mofeed_shared/constants/common_params.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';

import '../../constants/fireabse_constants.dart';
import '../../utils/typdefs/typedefs.dart';

class FirebaseFoodCourtClient implements FoodCourtClient {
  final FirebaseFirestore _firestore;

  const FirebaseFoodCourtClient({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<List<CategoryModel>> getCategories(String restId) async {
    try {
      final cats = await _restaurants
          .doc(restId)
          .collection(FirebaseConst.categories)
          .get()
          .then((value) =>
              value.docs.map((e) => CategoryModel.fromJson(e.data())).toList());
      return cats;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetCategoriesFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<List<OptionGroup>> getItemOpions({
    required restId,
    required itemId,
  }) async {
    try {
      final options = await _restaurants
          .doc(restId)
          .collection(FirebaseConst.items)
          .doc(itemId)
          .get()
          .then((value) async {
        final options = <OptionGroup>[];
        if (value.data() == null) {
          throw const GetOneItemFailure("Item Not Exists");
        } else {
          final item = ItemModel.fromJson(value.data()!);
          if (!item.isVariable) {
            return options;
          } else {
            for (final varId in item.variationsIds) {
              final group = await _restaurants
                  .doc(restId)
                  .collection(FirebaseConst.variants)
                  .doc(varId)
                  .get();
              if (group.exists) {
                options.add(OptionGroup.fromJson(group.data()!));
              } else {
                continue;
              }
            }
            return options;
          }
        }
      });

      return options;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetItemOptionsFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<List<ItemModel>> getItems(String restId) async {
    try {
      final items = await _restaurants
          .doc(restId)
          .collection(FirebaseConst.items)
          .get()
          .then((value) =>
              value.docs.map((e) => ItemModel.fromJson(e.data())).toList());
      return items;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetItemsFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<RestarantModel> getRestaurant(String restId) async {
    try {
      final rest = await _restaurants
          .doc(restId)
          .get()
          .then((value) => RestarantModel.fromMap(value.data()!));
      return rest;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetRestaruantFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<List<RestarantModel>> getRestaurnats({
    int limit = 10,
    required String uniId,
  }) async {
    try {
      final rests = await _restaurants
          .where(CommonParams.uniId, isEqualTo: uniId)
          .limit(limit)
          .get()
          .then((value) =>
              value.docs.map((e) => RestarantModel.fromMap(e.data())).toList());
      return rests;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetRestaurantsFailure(e.mapCodeToError), st);
    }
  }

  CollectionReference<MapJson> get _restaurants =>
      _firestore.collection(FirebaseConst.restaurants);

  @override
  Future<ItemModel> getItem({
    required String id,
    required String restId,
  }) async {
    try {
      final item = await _restaurants
          .doc(restId)
          .collection(FirebaseConst.items)
          .doc(id)
          .get()
          .then((value) {
        if (value.data() == null) {
          throw const GetOneItemFailure("Item Not Exists");
        } else {
          return ItemModel.fromJson(value.data()!);
        }
      });
      return item;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetOneItemFailure(e.mapCodeToError), st);
    }
  }
}
