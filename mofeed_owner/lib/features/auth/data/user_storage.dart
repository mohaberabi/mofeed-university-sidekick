import 'dart:convert';

import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:mofeed_shared/model/client_user_model.dart';

abstract final class AuthStorageKeys {
  static const String uid = 'uidCache';
}

class AuthStorage {
  final StorageClient storage;

  const AuthStorage({required this.storage});

  Future<String?> getUid() async {
    return storage.read(key: AuthStorageKeys.uid);
  }

  Future<void> saveUid(String uid) async {
    await storage.write(key: AuthStorageKeys.uid, value: uid);
  }

  Future<void> clear() async => await storage.clear();


}
