import 'package:food_court/utils/extensions/restarant_ext.dart';
import 'package:mofeed_shared/model/university_model.dart';
import 'package:mofeed_shared/utils/enums/restarant.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

import 'cart_item.dart';

class OrderModel {
  final String id;
  final String restaurantId;
  final String universityId;
  final String userId;
  final List<CartItem> items;
  final OrderStatus status;
  final String username;
  final String phone;
  final DateTime orderTime;
  final DateTime pickupTime;
  final bool isDelivery;
  final FacultyModel? faculty;
  final double cartTotal;
  final String? promoCode;
  final double discount;
  final String lang;
  final String userToken;
  final String restaurantToken;
  final String room;
  final bool rated;
  final String floor;

  final MapJson restaurantName;

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      restaurantName: map['restaurantName'],
      rated: map['rated'] ?? false,
      restaurantToken: map['restaurantToken'],
      lang: map['lang'],
      floor: map['floor'] ?? "",
      room: map['room'] ?? "",
      username: map['username'],
      discount: map['discount'],
      restaurantId: map['restaurantId'],
      status: (map['status'] as String).toOrderStatus,
      items: (map['items'] as List).map((e) => CartItem.fromMap(e)).toList(),
      isDelivery: map['isDelivery'],
      id: map['id'],
      universityId: map['universityId'],
      orderTime: DateTime.fromMillisecondsSinceEpoch(map['orderTime']),
      pickupTime: DateTime.fromMillisecondsSinceEpoch(map['pickupTime']),
      faculty:
          map['faculty'] != null ? FacultyModel.fromMap(map['faculty']) : null,
      userId: map['userId'],
      phone: map['phone'],
      cartTotal: map['cartTotal'],
      userToken: map['userToken'],
    );
  }


  bool get canRate =>!rated&&status!=OrderStatus.canceled&& status==OrderStatus.done;
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "restaurantId": restaurantId,
      "universityId": universityId,
      "userId": userId,
      "items": items.map((e) => e.toMap()).toList(),
      "status": status.name,
      "username": username,
      "phone": phone,
      "orderTime": orderTime.microsecondsSinceEpoch,
      "pickupTime": pickupTime.millisecondsSinceEpoch,
      "isDelivery": isDelivery,
      "faculty": faculty?.toMap(),
      "cartTotal": cartTotal,
      "promoCode": promoCode,
      "discount": discount,
      "lang": lang,
      "userToken": userToken,
      "restaurantToken": restaurantToken,
      "restaurantName": restaurantName,
      "floor": floor,
      "room": room,
      "rated": rated,
    };
  }

  const OrderModel({
    required this.id,
    required this.restaurantId,
    required this.universityId,
    required this.userId,
    required this.items,
    required this.status,
    required this.username,
    required this.phone,
    required this.orderTime,
    required this.pickupTime,
    required this.cartTotal,
    required this.discount,
    required this.lang,
    required this.userToken,
    required this.restaurantToken,
    required this.restaurantName,
    this.floor = '',
    this.room = '',
    this.promoCode,
    this.isDelivery = false,
    this.faculty,
    this.rated = false,
  });
}
