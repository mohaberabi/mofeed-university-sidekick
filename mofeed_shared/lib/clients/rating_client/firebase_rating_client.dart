import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mofeed_shared/clients/rating_client/rating_client.dart';
import 'package:mofeed_shared/model/rating_model.dart';
import 'package:mofeed_shared/utils/extensions/firestore_ext.dart';

import '../../constants/common_params.dart';
import '../../constants/fireabse_constants.dart';
import '../../constants/const_methods.dart';
import '../../utils/typdefs/typedefs.dart';

class FirebaseRatingClient implements RatingClient {
  final FirebaseFirestore _firestore;

  const FirebaseRatingClient({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<List<RatingModel>> geRatings({
    String? restaurantId,
    String? lastDocId,
    int limit = 10,
  }) async {
    try {
      final query = _restaurants
          .doc(restaurantId)
          .collection(FirebaseConst.ratings)
          .orderBy(CommonParams.createdAt, descending: true)
          .limit(limit);
      final ratings = await _firestore.paginate<RatingModel>(
          query: query,
          lastDocId: lastDocId,
          lastDocColl:
              _restaurants.doc(restaurantId).collection(FirebaseConst.ratings),
          mapList: (list) async {
            return list.map((e) => RatingModel.fromMap(e)).toList();
          });

      return ratings;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetRatingsFailure(e.toString()), st);
    }
  }

  @override
  Future<void> rate({
    required String restaurantId,
    required RatingModel rating,
    required String orderId,
  }) async {
    try {
      await _orders.doc(orderId).update({
        CommonParams.rated: true,
      });
      await _restaurants
          .doc(restaurantId)
          .collection(FirebaseConst.ratings)
          .doc(rating.id)
          .set(rating.toMap());
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(AddRateFailure(e.toString()), st);
    }
  }

  CollectionReference<MapJson> get _orders =>
      _firestore.collection(FirebaseConst.orders);

  CollectionReference<MapJson> get _restaurants =>
      _firestore.collection(FirebaseConst.restaurants);
}
