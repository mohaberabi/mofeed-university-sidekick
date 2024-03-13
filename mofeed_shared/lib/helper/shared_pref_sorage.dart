import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStorage implements StorageClient {
  final SharedPreferences prefs;

  const SharedPrefStorage({
    required this.prefs,
  });

  @override
  Future<void> clear() async {
    try {
      await prefs.clear();
    } catch (e, st) {
      Error.throwWithStackTrace(StorageException(e), st);
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await prefs.remove(key);
    } catch (e, st) {
      Error.throwWithStackTrace(StorageException(e), st);
    }
  }

  @override
  Future<String?> read({
    required String key,
  }) async {
    try {
      return prefs.getString(key);
    } catch (e, st) {
      Error.throwWithStackTrace(StorageException(e), st);
    }
  }

  @override
  Future<void> write({
    required String key,
    required String value,
  }) async {
    try {
      await prefs.setString(key, value);
    } catch (e, st) {
      Error.throwWithStackTrace(StorageException(e), st);
    }
  }
}
