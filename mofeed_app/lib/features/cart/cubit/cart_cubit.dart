import 'package:bloc/bloc.dart';
import 'package:food_court/model/cart_item.dart';
import 'package:food_court/model/cart_model.dart';
import 'package:food_court/model/food_option.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_state.dart';
import '../data/cart_repository.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required CartRepository cartRepository,
  })  : _cartRepository = cartRepository,
        super(const CartState());
  final CartRepository _cartRepository;

  void addToCart({
    required Map<String, dynamic> name,
    required String id,
    required double itemPrice,
    List<FoodOption> options = const [],
    required int qty,
    required String image,
    required String restaurantId,
  }) {
    if (restaurantId != state.restarantId && state.restarantId.isNotEmpty) {
      emit(state.copyWith(state: CartStatus.restaurantChanged));
      return;
    }
    final CartItem toAdd = CartItem(
        restaurantId: restaurantId,
        image: image,
        itemPrice: itemPrice,
        options: options,
        name: name,
        id: id,
        qty: qty);
    if (state.cart.items.containsKey(id)) {
      emit(state.copyWith(
          cart: state.cart.copyWith(
              items: {
        ...state.cart.items
      }..update(id, (value) => value.copyWith(qty: value.qty + qty)))));
    } else {
      emit(state.copyWith(
          cart: state.cart.copyWith(
              items: {...state.cart.items}..putIfAbsent(id, () => toAdd))));
    }
    _save();
    emit(state.copyWith(state: CartStatus.addToCart));
  }

  void reOrder(List<CartItem> current) async {
    try {
      emit(state.copyWith(state: CartStatus.loading));
      final items = await _cartRepository.reOrder(currentItems: current);
      emit(state.copyWith(
          state: CartStatus.itemsCopiedToReOrder,
          cart: CartModel(items: {for (CartItem e in items) e.id: e})));
    } catch (e, st) {
      emit(state.copyWith(error: e.toString(), state: CartStatus.error));
    }
  }

  void init() async {
    try {
      final List<CartItem> items = await _cartRepository.getItems();
      emit(state.copyWith(
          cart: CartModel(items: {for (var e in items) e.id: e})));
    } catch (e, st) {
      addError(e, st);
    }
  }

  void clear() async {
    try {
      await _cartRepository.clear();
      emit(const CartState());
      _save();
    } catch (e, st) {
      addError(e, st);
    }
  }

  void removeItem(String id) {
    emit(state.copyWith(
        cart: state.cart.copyWith(items: {...state.cart.items}..remove(id))));
    _save();
  }

  void incQty(String id) {
    emit(state.copyWith(
        cart: state.cart.copyWith(
            items: {...state.cart.items}
              ..update(id, (value) => value.copyWith(qty: value.qty + 1)))));
    _save();
  }

  void decQty(String id) {
    final item = state.cart.items[id];
    if (item!.qty > 1) {
      emit(state.copyWith(
          cart: state.cart.copyWith(
              items: {...state.cart.items}
                ..update(id, (value) => value.copyWith(qty: value.qty - 1)))));
    } else {
      emit(state.copyWith(
          cart: state.cart.copyWith(items: state.cart.items..remove(id))));
    }
    _save();
  }

  void _save() async {
    try {
      await _cartRepository.saveItems(state.cart.items.values.toList());
    } catch (e, st) {
      addError(e, st);
    }
  }
}
