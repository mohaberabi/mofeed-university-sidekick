import '../utils/error/error_codes.dart';

class StorageException implements Exception {
  const StorageException(this.error);

  final Object error;

  @override
  String toString() {
    return ErrorCodes.unKnownError;
  }
}

abstract class StorageClient {
  Future<String?> read({
    required String key,
  });

  Future<void> write({
    required String key,
    required String value,
  });

  Future<void> delete({
    required String key,
  });

  Future<void> clear();
}
