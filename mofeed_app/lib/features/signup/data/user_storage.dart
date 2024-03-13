import 'dart:convert';

import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:mofeed_shared/model/client_user_model.dart';

abstract final class UserStorageKeys {
  static const String uid = 'uidCache';
  static const String user = 'userCache';
}

class UserStorage {
  final StorageClient _storage;

  const UserStorage({required StorageClient storage}) : _storage = storage;

  Future<String?> getUid() async {
    return _storage.read(key: UserStorageKeys.uid);
  }

  Future<void> saveUid(String uid) async {
    await _storage.write(key: UserStorageKeys.uid, value: uid);
  }

  Future<ClientUser?> getUser() async {
    final encoded = await _storage.read(key: UserStorageKeys.user);
    if (encoded == null) {
      return null;
    }
    return ClientUser.fromMap(jsonDecode(encoded));
  }

  Future<void> clear() async => await _storage.clear();

  Future<void> saveUser(ClientUser user) async {
    await _storage.write(key: UserStorageKeys.user, value: user.toJson());
  }
}
