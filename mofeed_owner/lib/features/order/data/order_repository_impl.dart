import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_court/model/order_model.dart';
import 'package:food_court/repository/order_repository.dart';
import 'package:mofeed_shared/constants/fireabse_constants.dart';
import 'package:mofeed_shared/error/error_codes.dart';
import 'package:mofeed_shared/error/failure.dart';
import 'package:mofeed_shared/utils/enums/restarant.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class OrderRepositoryImpl implements OwnerOrderRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  const OrderRepositoryImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  @override
  Stream<OrderModel> trackOrder(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<OrderModel>> getActiveOrders() {
    final uid = _auth.currentUser!.uid;
    return _orders
        .where('restaurantId', isEqualTo: uid)
        .orderBy("orderTime", descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => OrderModel.fromMap(e.data())).toList());
  }

  @override
  FutureVoid updateOrderStatus({
    required OrderStatus status,
    required String id,
  }) async {
    try {
      await _orders.doc(id).update({"status": status.name.toString()});
      return const Right(unit);
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }

  CollectionReference<MapJson> get _orders =>
      _firestore.collection(FirebaseConst.orders);

  @override
  FutureEither<List<OrderModel>> getOrders() {
    // TODO: implement getOrders
    throw UnimplementedError();
  }
}
