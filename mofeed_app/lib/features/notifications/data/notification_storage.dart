import 'package:mofeed_shared/helper/storage_client.dart';

class NotificationStorage {
  final StorageClient _storage;

  const NotificationStorage({
    required StorageClient storage,
  }) : _storage = storage;
  static const String _key = "topicKey";

  Future<void> save(String topic) async =>
      await _storage.write(key: _key, value: topic);

  Future<void> remove() async => await _storage.delete(key: _key);

  Future<String?> getTopic() async {
    final topic = await _storage.read(key: _key);
    return topic;
  }
}
