import 'package:equatable/equatable.dart';
import 'package:food_court/model/order_model.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

class OrderState extends Equatable {
  final String error;

  final CubitState state;

  final OrderModel? order;

  OrderState copyWith({
    String? error,
    CubitState? state,
    OrderModel? order,
    List<OrderModel>? orders,
  }) {
    return OrderState(
      error: error ?? this.error,
      state: state ?? this.state,
      order: order ?? this.order,
      orders: orders ?? this.orders,
    );
  }

  final List<OrderModel> orders;

  const OrderState({
    this.error = '',
    this.state = CubitState.initial,
    this.orders = const [],
    this.order,
  });

  @override
  List<Object?> get props => [
        error,
        state,
        orders,
        order,
      ];

  @override
  String toString() => state.name;
}
