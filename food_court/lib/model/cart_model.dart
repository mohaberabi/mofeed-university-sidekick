import 'cart_item.dart';

class CartModel {
  final Map<String, CartItem> items;

  double get cartTotal => items.values.toList().fold(
        0.0,
        (previousValue, element) => element.totalPrice + previousValue,
      );

  const CartModel({
    this.items = const {},
  });

  CartModel copyWith({
    Map<String, CartItem>? items,
  }) {
    return CartModel(
      items: items ?? this.items,
    );
  }
}
