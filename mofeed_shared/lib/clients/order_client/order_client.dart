import 'package:equatable/equatable.dart';
import 'package:food_court/model/order_model.dart';

import '../../utils/enums/restarant.dart';

abstract class OrderClient {
  Future<String> createOrder({required OrderModel order});

  Stream<OrderModel> trackOrder({required String id});

  Stream<List<OrderModel>> getActiveOrders({required String restaurantId});

  Future<void> updateOrderStatus({
    required OrderStatus status,
    required String id,
  });

  Future<List<OrderModel>> getOrders({String? uid});

  Future<void> cancelOrder({required String orderId});
}

abstract class OrderException with EquatableMixin implements Exception {
  final Object? error;

  const OrderException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => error.toString();
}

class CancelOrderFailure extends OrderException {
  const CancelOrderFailure(super.error);
}

class GetOrdersFailure extends OrderException {
  const GetOrdersFailure(super.error);
}

class UpdateOrderFailure extends OrderException {
  const UpdateOrderFailure(super.error);
}

class CreateOrderFailure extends OrderException {
  const CreateOrderFailure(super.error);
}
