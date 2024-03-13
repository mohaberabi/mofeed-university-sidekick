import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_court/model/order_model.dart';
import 'package:food_court/repository/order_repository.dart';
import 'package:mofeed_owner/features/order/cubit/order_state.dart';
import 'package:mofeed_shared/data/fcm_repository.dart';
import 'package:mofeed_shared/model/fcm_noti.dart';
import 'package:mofeed_shared/utils/enums/restarant.dart';

class OrderCubit extends Cubit<OrderState> {
  final OwnerOrderRepository _orderRepository;
  final FcmRepository _fcmRepository;

  OrderCubit({
    required OwnerOrderRepository orderRepository,
    required FcmRepository fcmRepository,
  })  : _orderRepository = orderRepository,
        _fcmRepository = fcmRepository,
        super(const OrderState());

  void emitLoading() => emit(state.copyWith(status: CubitOrderStatus.loading));

  void emitError(String error, [StackTrace? st]) {
    emit(state.copyWith(status: CubitOrderStatus.error, error: error));
    addError(error, st);
  }

  StreamSubscription? _activeOrdersStream;

  @override
  Future<void> close() {
    _activeOrdersStream?.cancel();
    return super.close();
  }

  void updateOrderStatus({
    required OrderModel order,
  }) async {
    emitLoading();
    final res = await _orderRepository.updateOrderStatus(
      status: order.status.next,
      id: order.id,
    );
    res.fold((l) => emitError(l.error, l.stackTrace), (r) async {
      emit(state.copyWith(
          status: CubitOrderStatus.orderUpdated, recentOrder: order));
      await _notifyOnOrderUpdate(order: order);
    });
  }

  Future<void> _notifyOnOrderUpdate({
    required OrderModel order,
  }) async {
    try {
      await _fcmRepository.send(
          noti: FcmNoti.toOrder(
              status: order.status.next,
              lang: order.lang,
              token: order.userToken));
    } catch (e, st) {
      addError(e, st);
    }
  }

  void getActiveOrders() {
    _activeOrdersStream =
        _orderRepository.getActiveOrders().listen((activeOrders) {
      emit(state.copyWith(activeOrders: activeOrders));
    });
  }
}
