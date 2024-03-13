import 'package:mofeed_shared/utils/enums/restarant.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';
import '../model/order_model.dart';

abstract class UserOrderRepository implements OrderRepository {
  FutureEither<String> createOrder({required OrderModel order});

  FutureVoid cancelOrder({required String orderId});
}

abstract class OrderRepository {
  Stream<OrderModel> trackOrder(String id);

  FutureEither<List<OrderModel>> getOrders();
}

abstract class OwnerOrderRepository implements OrderRepository {
  Stream<List<OrderModel>> getActiveOrders();

  FutureVoid updateOrderStatus({
    required OrderStatus status,
    required String id,
  });
}
