import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mofeduserpp/app/data/app_storage.dart';
import 'package:mofeduserpp/features/theme_changer/cubit/theme_changer_cubit.dart';
import 'package:mofeed_shared/helper/storage_client.dart';

class MockStorage extends Mock implements StorageClient {}

void main() {
  group("Theme Change Cubit Test", () {
    late StorageClient storage;

    setUp(() {
      storage = MockStorage();
    });
    test('initial state is ThemeMode.system', () {
      expect(ThemeChangerCubit(appStorage: AppStorage(storage: storage)).state,
          ThemeMode.system);
    });

    blocTest<ThemeChangerCubit, ThemeMode>(
      'on ThemeModeChanged sets the ThemeMode',
      build: () => ThemeChangerCubit(appStorage: AppStorage(storage: storage)),
      act: (cubit) => cubit.changeTheme(ThemeMode.light),
      expect: () => [ThemeMode.light],
    );
    blocTest<ThemeChangerCubit, ThemeMode>(
      'on ThemeModeChanged sets the ThemeMode',
      build: () => ThemeChangerCubit(appStorage: AppStorage(storage: storage)),
      act: (cubit) => cubit.changeTheme(ThemeMode.dark),
      expect: () => [ThemeMode.dark],
    );
  });
}
