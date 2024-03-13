import 'package:dartz/dartz.dart';
import 'package:food_court/model/order_model.dart';
import 'package:food_court/repository/order_repository.dart';
import 'package:mofeed_shared/clients/order_client/order_client.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';
import 'package:mofeed_shared/utils/error/failure.dart';

import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

import '../../signup/data/user_storage.dart';

class MofeedOrderRepository implements UserOrderRepository {
  final OrderClient _orderClient;
  final NetWorkInfo _netWorkInfo;

  final UserStorage _userStorage;

  const MofeedOrderRepository({
    required NetWorkInfo netWorkInfo,
    required OrderClient orderClient,
    required UserStorage userStorage,
  })  : _userStorage = userStorage,
        _orderClient = orderClient,
        _netWorkInfo = netWorkInfo;

  @override
  FutureVoid cancelOrder({required String orderId}) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(Failure(ErrorCodes.noNetWork));
      } else {
        await _orderClient.cancelOrder(orderId: orderId);
        return const Right(unit);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<String> createOrder({required OrderModel order}) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(Failure(ErrorCodes.noNetWork));
      } else {
        await _orderClient.createOrder(order: order);
        return Right(order.id);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<List<OrderModel>> getOrders() async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(Failure(ErrorCodes.noNetWork));
      } else {
        final uid = await _userStorage.getUid();
        if (uid == null) {
          return const Right([]);
        }
        final orders = await _orderClient.getOrders(uid: uid);
        return Right(orders);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  Stream<OrderModel> trackOrder(String id) {
    return _orderClient.trackOrder(id: id);
  }
}
