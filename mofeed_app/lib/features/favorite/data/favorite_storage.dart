import 'dart:convert';
import 'package:mofeed_shared/clients/favorite_client/favorite_client.dart';
import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:mofeed_shared/model/favorite_model.dart';

abstract class FavoriteStorageKeys {
  static const String favrotiesKey = "favoriteKey";
}

class FavoriteStorage {
  final StorageClient _storage;

  const FavoriteStorage({required StorageClient storage}) : _storage = storage;

  Future<Set<String>> getFavoriteIds({
    required FavoriteType type,
  }) async {
    final favoritesEncoded =
        await _storage.read(key: FavoriteStorageKeys.favrotiesKey);
    if (favoritesEncoded == null) {
      return {};
    }
    final favoriteData = _decodeFavorites(favoritesEncoded);
    return favoriteData[type.name] ?? {};
  }

  Future<void> saveFavorite({
    required FavoriteType type,
    required String id,
  }) async {
    final encodedString =
        await _storage.read(key: FavoriteStorageKeys.favrotiesKey);

    final Map<String, Set<String>> decoded = encodedString == null
        ? <String, Set<String>>{}
        : _decodeFavorites(encodedString);
    if (decoded[type.name] == null) {
      decoded[type.name] = {id};
    } else {
      if (decoded[type.name]!.contains(id)) {
        decoded[type.name]!.remove(id);
      } else {
        decoded[type.name]!.add(id);
      }
    }
    final encodedValue = _encodeFavorites(decoded);
    await _storage.write(
        key: FavoriteStorageKeys.favrotiesKey, value: encodedValue);
  }

  Map<String, Set<String>> _decodeFavorites(String encodedString) {
    return (jsonDecode(encodedString) as Map<String, dynamic>).map(
        (key, value) =>
            MapEntry(key, (value as List).map((e) => e.toString()).toSet()));
  }

  String _encodeFavorites(Map<String, Set<String>> favorites) {
    return jsonEncode(
        favorites.map((key, value) => MapEntry(key, value.toList())));
  }

  Future<FoldFavorite> getFavoriteData() async {
    final encoded = await _storage.read(key: FavoriteStorageKeys.favrotiesKey);

    if (encoded == null) {
      return {};
    } else {
      final decoded = jsonDecode(encoded);
      return (decoded as Map).map((key, value) =>
          MapEntry(key, (value as List).map((e) => e.toString()).toSet()));
    }
  }

  Future<void> setFavorites(FoldFavorite favrotiesMap) async {
    await _storage.write(
        key: FavoriteStorageKeys.favrotiesKey, value: jsonEncode(favrotiesMap));
  }

  Future<void> clear() async =>
      await _storage.delete(key: FavoriteStorageKeys.favrotiesKey);
}
