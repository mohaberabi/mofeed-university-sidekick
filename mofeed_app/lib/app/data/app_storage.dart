import 'package:mofeed_shared/helper/storage_client.dart';

abstract class AppStorageKeys {
  static const String themeKey = "themeKey";
  static const String langCache = 'langCache';
  static const String onBoarding = 'onBoarding';
}

class AppStorage {
  final StorageClient _storage;

  const AppStorage({
    required StorageClient storage,
  }) : _storage = storage;

  Future<String?> getSavedLang() async {
    return await _storage.read(key: AppStorageKeys.langCache);
  }

  Future<void> saveLanguage(String lang) async {
    await _storage.write(key: AppStorageKeys.langCache, value: lang);
  }

  Future<void> saveOnBoarding() async {
    await _storage.write(key: AppStorageKeys.onBoarding, value: "Saw");
  }

  Future<bool> seenOnBoarding() async {
    return await _storage.read(key: AppStorageKeys.onBoarding) != null;
  }

  Future<void> clear() async => await _storage.clear();

  Future<int?> getSavedTheme() async {
    final cachedString = await _storage.read(key: AppStorageKeys.themeKey);
    if (cachedString != null) {
      return int.parse(cachedString);
    }
    return null;
  }

  Future<void> saveTheme(int themeMode) async {
    await _storage.write(
        key: AppStorageKeys.themeKey, value: themeMode.toString());
  }
}
