import 'package:mocktail/mocktail.dart';
import 'package:mofeduserpp/app/data/app_storage.dart';
import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:test/test.dart';

import '../../theme_changer/cubit/theme_changer_cubit_test.dart';

void main() {
  group('appStorage', () {
    late StorageClient storage;

    setUp(() {
      storage = MockStorage();
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
    });

    group('saveTheme', () {
      test('saves user chooses themeMode ', () async {
        await AppStorage(storage: storage).saveTheme(0);
        verify(
          () => storage.write(
            key: AppStorageKeys.themeKey,
            value: 0.toString(),
          ),
        ).called(1);
      });
    });

    group('saveLanguage', () {
      test('saves user chooses language ', () async {
        await AppStorage(storage: storage).saveLanguage("ar");
        verify(
          () => storage.write(
            key: AppStorageKeys.langCache,
            value: "ar",
          ),
        ).called(1);
      });
    });

    group('fetchThemeMode', () {
      test('returns the value from Storage', () async {
        when(
          () => storage.read(key: AppStorageKeys.themeKey),
        ).thenAnswer((_) async => 0.toString());
        final result = await AppStorage(storage: storage).getSavedTheme();
        verify(
          () => storage.read(
            key: AppStorageKeys.themeKey,
          ),
        ).called(1);

        expect(result, 0);
      });

      test('returns 0 when no value exists in UserStorage', () async {
        when(
          () => storage.read(key: AppStorageKeys.themeKey),
        ).thenAnswer((_) async => null);
        final result = await AppStorage(storage: storage).getSavedTheme();
        verify(
          () => storage.read(
            key: AppStorageKeys.themeKey,
          ),
        ).called(1);
        expect(result, 0);
      });
    });

    group('fetchLanguage', () {
      test('returns the value from Storage', () async {
        when(
          () => storage.read(key: AppStorageKeys.langCache),
        ).thenAnswer((_) async => "ar");

        final result = await AppStorage(storage: storage).getSavedLang();

        verify(
          () => storage.read(
            key: AppStorageKeys.langCache,
          ),
        ).called(1);

        expect(result, "ar");
      });

      test('returns null when no value exists in storage', () async {
        when(
          () => storage.read(key: AppStorageKeys.langCache),
        ).thenAnswer((_) async => null);
        final result = await AppStorage(storage: storage).getSavedLang();
        verify(
          () => storage.read(
            key: AppStorageKeys.langCache,
          ),
        ).called(1);
        expect(result, null);
      });
    });
  });
}
