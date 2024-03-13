import 'dart:convert';
import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:mofeed_shared/model/university_model.dart';

abstract class UniversityStorageKeys {
  static const String uniIdCache = 'uniIdCache';
  static const String uniCache = 'uniCache';
}

class UniversityStorage {
  final StorageClient storage;

  const UniversityStorage({
    required this.storage,
  });

  Future<void> saveUniversityId(String uniId) async {
    await storage.write(
      key: UniversityStorageKeys.uniIdCache,
      value: uniId,
    );
  }

  Future<String?> getUniId() async {
    return await storage.read(key: UniversityStorageKeys.uniIdCache);
  }

  Future<void> saveUniversity(UniversityModel university) async {
    await storage.write(
      key: UniversityStorageKeys.uniCache,
      value: university.toJson(),
    );
  }

  Future<UniversityModel?> getUniversity() async {
    final encoeded = await storage.read(key: UniversityStorageKeys.uniCache);
    if (encoeded == null) {
      return null;
    } else {
      return UniversityModel.fromMap(jsonDecode(encoeded));
    }
  }
}
