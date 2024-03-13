import 'package:food_court/model/cart_item.dart';
import 'package:mofeed_shared/helper/serialize.dart';
import 'package:mofeed_shared/helper/storage_client.dart';

abstract final class CartStorageKeys {
  static const String cachedSpecialInstructions = 'cachedRestName';
  static const String cachedItems = 'cachedItems';
}

class CartStorage {
  final StorageClient storage;

  const CartStorage({required this.storage});

  Future<void> clearCartStorage() async {
    await Future.wait([
      storage.delete(key: CartStorageKeys.cachedSpecialInstructions),
      storage.delete(key: CartStorageKeys.cachedItems),
    ]);
  }

  Future<void> saveItems(
    List<CartItem> items,
  ) async {
    final encoded = StorageHelper.stringFromList(
        list: items, toJson: (item) => item.toJson());
    await storage.write(key: CartStorageKeys.cachedItems, value: encoded);
  }

  Future<List<CartItem>> getItems() async {
    final encode = await storage.read(key: CartStorageKeys.cachedItems);
    final list = StorageHelper.listFromString(
        fromJson: CartItem.fromMap, encodedList: encode);
    return list;
  }
}
