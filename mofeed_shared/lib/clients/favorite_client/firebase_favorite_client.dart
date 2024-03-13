import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_court/model/restaurant_model.dart';
import 'package:mofeed_shared/clients/favorite_client/favorite_client.dart';
import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';
import 'package:sakan/model/sakan_model.dart';

import '../../constants/common_params.dart';
import '../../constants/fireabse_constants.dart';
import '../../model/favorite_data_model.dart';
import '../../utils/typdefs/typedefs.dart';

class FirebaseFavoriteClient implements FavoriteClient {
  final FirebaseFirestore _firestore;

  const FirebaseFavoriteClient({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<void> addToFavorite({
    required String id,
    required FavoriteType type,
    required String uid,
  }) async {
    try {
      final favColl = _users.doc(uid).collection(FirebaseConst.favorites);
      final favData = await favColl.doc(type.name).get();
      if (favData.exists == false) {
        await favColl.doc(type.name).set({
          CommonParams.type: type.name,
          CommonParams.ids: [id]
        });
      } else {
        final favorite = FavoriteData.fromMap(favData.data()!);
        final doc = favColl.doc(type.name);
        if (favorite.ids.contains(id)) {
          await doc.update({
            CommonParams.ids: FieldValue.arrayRemove([id]),
          });
        } else {
          await doc.update({
            CommonParams.ids: FieldValue.arrayUnion([id]),
          });
        }
      }
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(AddToFavoriteFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<FoldFavorite> getFavoriteData({
    required FoldFavorite foldFavorite,
    required String uid,
  }) async {
    try {
      if (foldFavorite.isEmpty) {
        final favColl = _users.doc(uid).collection(FirebaseConst.favorites);
        final favDataList = await favColl.get().then((value) =>
            value.docs.map((e) => FavoriteData.fromMap(e.data())).toList());
        final FoldFavorite foldedMap = {};
        for (final data in favDataList) {
          foldedMap[data.type.name]
              ?.addAll(data.ids.map((e) => e.toString()).toList());
        }
        return foldedMap;
      } else {
        return <String, Set<String>>{};
      }
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetFavoriteDataFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<List<RestarantModel>> getFavoriteRestaurants({
    required List<String> ids,
  }) async {
    try {
      final rests = await _firestore
          .collection(FirebaseConst.restaurants)
          .where(CommonParams.id, whereIn: ids)
          .get()
          .then((value) =>
              value.docs.map((e) => RestarantModel.fromMap(e.data())).toList());
      return rests;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(
          GetFavoriteRestaurantsFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<List<Sakan>> getFavoriteSakans({
    required List<String> ids,
  }) async {
    try {
      final sakans = await _firestore
          .collection(FirebaseConst.sakan)
          .where(CommonParams.id, whereIn: ids)
          .get()
          .then((value) =>
              value.docs.map((e) => Sakan.fromMap(e.data())).toList());
      return sakans;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetFavoriteSakansFailure(e.mapCodeToError), st);
    }
  }

  CollectionReference<MapJson> get _users =>
      _firestore.collection(FirebaseConst.users);
}
