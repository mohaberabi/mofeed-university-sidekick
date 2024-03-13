import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_court/model/cart_item.dart';
import 'package:food_court/model/item_model.dart';
import 'package:mofeduserpp/features/cart/data/cart_storage.dart';
import 'package:mofeed_shared/constants/fireabse_constants.dart';
import 'package:mofeed_shared/utils/error/exceptions.dart';

class CartRepository {
  final CartStorage _storage;

  final FirebaseFirestore _firestore;

  const CartRepository({
    required FirebaseFirestore firestore,
    required CartStorage storage,
  })  : _storage = storage,
        _firestore = firestore;

  Future<List<CartItem>> getItems() async {
    try {
      return _storage.getItems();
    } catch (e, st) {
      Error.throwWithStackTrace(GetItemsFailure(e), st);
    }
  }

  Future<void> saveItems(List<CartItem> items) async {
    try {
      await _storage.saveItems(items);
    } catch (e, st) {
      Error.throwWithStackTrace(SaveItemsFailure(e), st);
    }
  }

  Future<String> getTemporaryRestaurantId() async {
    try {
      final items = await _storage.getItems();
      if (items.isEmpty) {
        return '';
      } else {
        return items.first.restaurantId;
      }
    } catch (e, st) {
      Error.throwWithStackTrace(SaveItemsFailure(e), st);
    }
  }

  Future<void> clear() async {
    try {
      await _storage.clearCartStorage();
    } catch (e, st) {
      Error.throwWithStackTrace(ClearCartFailure(e), st);
    }
  }

  Future<List<CartItem>> reOrder({required List<CartItem> currentItems}) async {
    try {
      final restaurantId = currentItems.first.restaurantId;
      final List<CartItem> items = [];
      final restaurantDoc =
          _firestore.collection(FirebaseConst.restaurants).doc(restaurantId);
      for (final item in currentItems) {
        final itemMap = await restaurantDoc
            .collection(FirebaseConst.items)
            .doc(item.id)
            .get()
            .then((value) => value.data());
        if (itemMap == null) {
          continue;
        } else {
          final newItem = ItemModel.fromJson(itemMap);
          items.add(item.copyWith(itemPrice: newItem.price));
        }
      }
      return items;
    } catch (e, st) {
      Error.throwWithStackTrace(ReOrderFailure(e), st);
    }
  }
}

class GetRestIdFailure extends AppException {
  const GetRestIdFailure(super.error);
}

class ReOrderFailure extends AppException {
  const ReOrderFailure(super.error);
}

class SaveItemsFailure extends AppException {
  const SaveItemsFailure(super.error);
}

class GetItemsFailure extends AppException {
  const GetItemsFailure(super.error);
}

class ClearCartFailure extends AppException {
  const ClearCartFailure(super.error);
}
