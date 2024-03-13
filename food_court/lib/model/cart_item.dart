import 'dart:convert';

import 'package:mofeed_shared/utils/enums/langauge_enum.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

import 'package:equatable/equatable.dart';

import 'food_option.dart';

class CartItem extends Equatable with Translatable {
  final double itemPrice;
  final String image;
  final String restaurantId;

  final String id;
  @override
  final MapJson name;

  final int qty;
  final List<FoodOption> options;

  const CartItem({
    required this.itemPrice,
    required this.options,
    required this.name,
    required this.id,
    required this.qty,
    required this.image,
    required this.restaurantId,
  });

  double get totalPrice => (itemPrice + extraPrice) * qty;

  double get extraPrice {
    final optionsPrice = options.fold(0.0, (prev, element) {
      return prev + element.price;
    });

    return optionsPrice;
  }

  CartItem copyWith({
    Map<String, dynamic>? name,
    int? qty,
    double? itemPrice,
    String? id,
    List<FoodOption>? options,
    String? image,
    String? restaurantId,
  }) {
    return CartItem(
      image: this.image,
      itemPrice: itemPrice ?? this.itemPrice,
      options: options ?? this.options,
      name: name ?? this.name,
      id: id ?? this.id,
      qty: qty ?? this.qty,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
        image: map['image'] ?? "",
        restaurantId: map['restaurantId'] ?? "",
        itemPrice: (map['itemPrice'] as num).toDouble(),
        options: (map['options'] as List)
            .map((e) => FoodOption.fromJson(e))
            .toList(),
        name: map['name'],
        id: map['id'],
        qty: map['qty']);
  }

  MapJson toMap() {
    return {
      "name": name,
      "restaurantId": restaurantId,
      "qty": qty,
      "itemPrice": itemPrice,
      "image": image,
      "id": id,
      "options": options.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props =>
      [itemPrice, options, name, id, qty, image, restaurantId,];
}
