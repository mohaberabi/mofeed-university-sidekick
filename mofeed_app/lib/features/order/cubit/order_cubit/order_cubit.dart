import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_court/repository/order_repository.dart';
import 'package:mofeduserpp/features/order/cubit/order_cubit/order_state.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';
import 'package:mofeed_shared/utils/mixins/cubitEmitter.dart';

class OrderCubit extends Cubit<OrderState> with CubitEmiiter {
  final UserOrderRepository _orderRepository;

  OrderCubit({
    required UserOrderRepository orderRepository,
  })  : _orderRepository = orderRepository,
        super(const OrderState());

  void getOrders() async {
    emitLoading();
    final res = await _orderRepository.getOrders();
    res.fold(
      (l) => emitError(l.error),
      (orders) => emit(
        state.copyWith(
          state: CubitState.done,
          orders: orders,
        ),
      ),
    );
  }

  StreamSubscription? _orderStreamSub;

  void trackOrder(String id) {
    _orderStreamSub = _orderRepository.trackOrder(id).listen((order) {
      emit(state.copyWith(order: order));
    });
  }

  @override
  Future<void> close() {
    closeStream();
    return super.close();
  }

  void closeStream() => _orderStreamSub?.cancel();

  @override
  void emitDone() => emit(state.copyWith(state: CubitState.done));

  @override
  void emitError(String error, {StackTrace? st}) =>
      emit(state.copyWith(state: CubitState.done, error: error));

  @override
  void emitInitial() => emit(state.copyWith(state: CubitState.initial));

  @override
  void emitLoading() => emit(state.copyWith(state: CubitState.loading));
}
