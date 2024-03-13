import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_court/model/order_model.dart';
import 'package:mofeed_shared/clients/order_client/order_client.dart';
import 'package:mofeed_shared/utils/enums/restarant.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';

import '../../constants/common_params.dart';
import '../../constants/fireabse_constants.dart';

class FirebaseOrderClient implements OrderClient {
  final FirebaseFirestore _firestore;

  const FirebaseOrderClient({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<void> cancelOrder({
    required String orderId,
  }) async {
    try {
      await _firestore
          .collection(FirebaseConst.orders)
          .doc(orderId)
          .update({CommonParams.status: OrderStatus.canceled.name.toString()});
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(CancelOrderFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<String> createOrder({
    required OrderModel order,
  }) async {
    try {
      await _firestore
          .collection(FirebaseConst.orders)
          .doc(order.id)
          .set(order.toMap());
      return order.id;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(CreateOrderFailure(e.mapCodeToError), st);
    }
  }

  @override
  Stream<List<OrderModel>> getActiveOrders({
    required String restaurantId,
  }) {
    // TODO: implement getActiveOrders
    throw UnimplementedError();
  }

  @override
  Future<List<OrderModel>> getOrders({
    String? uid,
  }) async {
    try {
      final orders = await _firestore
          .collection(FirebaseConst.orders)
          .where(CommonParams.userId, isEqualTo: uid)
          .get()
          .then((value) =>
              value.docs.map((e) => OrderModel.fromMap(e.data())).toList());
      return orders;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetOrdersFailure(e.mapCodeToError), st);
    }
  }

  @override
  Stream<OrderModel> trackOrder({
    required String id,
  }) {
    return _firestore
        .collection(FirebaseConst.orders)
        .doc(id)
        .snapshots()
        .map((order) => OrderModel.fromMap(order.data()!));
  }

  @override
  Future<void> updateOrderStatus({
    required OrderStatus status,
    required String id,
  }) {
    // TODO: implement updateOrderStatus
    throw UnimplementedError();
  }
}
