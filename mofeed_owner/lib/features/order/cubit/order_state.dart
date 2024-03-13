import 'package:equatable/equatable.dart';
import 'package:food_court/model/order_model.dart';

enum CubitOrderStatus {
  initial,
  loading,
  error,
  orderUpdated,
  newOrder;
}

class OrderState extends Equatable {
  final String error;
  final CubitOrderStatus status;
  final List<OrderModel> activeOrders;
  final OrderModel? recentOrder;

  const OrderState({
    this.error = '',
    this.activeOrders = const [],
    this.status = CubitOrderStatus.initial,
    this.recentOrder,
  });

  OrderState copyWith({
    String? error,
    CubitOrderStatus? status,
    List<OrderModel>? activeOrders,
    OrderModel? recentOrder,
  }) {
    return OrderState(
      recentOrder: recentOrder ?? this.recentOrder,
      error: error ?? this.error,
      status: status ?? this.status,
      activeOrders: activeOrders ?? this.activeOrders,
    );
  }

  @override
  List<Object?> get props => [error, status, activeOrders, recentOrder];
}
