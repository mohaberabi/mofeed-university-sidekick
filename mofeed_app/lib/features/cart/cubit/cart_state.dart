import 'package:equatable/equatable.dart';
import 'package:food_court/model/cart_model.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

enum CartStatus {
  initial,
  loading,
  itemsCopiedToReOrder,
  restaurantChanged,
  error,
  addToCart;

  bool get isError => this == CartStatus.error;

  bool get isAddedToCart => this == CartStatus.addToCart;

  bool get isRestaurantChanged => this == CartStatus.restaurantChanged;
}

class CartState extends Equatable {
  final CartModel cart;
  final String error;
  final CartStatus state;

  const CartState({
    this.cart = const CartModel(),
    this.error = '',
    this.state = CartStatus.initial,
  });

  @override
  List<Object?> get props => [
        cart,
        state,
        error,
      ];

  CartState copyWith({
    CartModel? cart,
    CartStatus? state,
    String? error,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      error: error ?? this.error,
      state: state ?? this.state,
    );
  }

  @override
  String toString() => state.name;

  String get restarantId =>
      cart.items.isEmpty ? "" : cart.items.values.first.restaurantId;
}
