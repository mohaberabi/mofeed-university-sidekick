import 'package:equatable/equatable.dart';
import 'package:food_court/model/cart_item.dart';

abstract class CartClient {
  Future<List<CartItem>> reOrder({
    required List<CartItem> currentItems,
  });
}

abstract class CartException with EquatableMixin implements Exception {
  final Object? error;

  const CartException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => error.toString();
}

class ReOrderFailure extends CartException {
  const ReOrderFailure(super.error);
}
