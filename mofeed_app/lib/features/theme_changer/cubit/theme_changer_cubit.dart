import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../app/data/app_storage.dart';

class ThemeChangerCubit extends Cubit<ThemeMode> {
  final AppStorage _appStorage;

  ThemeChangerCubit({
    required AppStorage appStorage,
  })  : _appStorage = appStorage,
        super(ThemeMode.system);

  void changeTheme(ThemeMode mode) {
    emit(mode);
    saveFavoriteTheme();
  }

  void saveFavoriteTheme() async {
    try {
      await _appStorage.saveTheme(state.index);
    } catch (e, st) {
      addError(e, st);
    }
  }

  void getFavoriteTheme() async {
    try {
      final index = await _appStorage.getSavedTheme();
      emit(ThemeMode.values[index ?? ThemeMode.system.index]);
    } catch (e, st) {
      addError(e, st);
    }
  }
}

extension CustomThemeMode on ThemeMode {
  String get ar {
    switch (this) {
      case ThemeMode.system:
        return "النظام";
      case ThemeMode.dark:
        return "داكن";
      case ThemeMode.light:
        return "فاتح";
    }
  }

  String get en {
    switch (this) {
      case ThemeMode.system:
        return "System";
      case ThemeMode.dark:
        return "Dark";
      case ThemeMode.light:
        return "Light";
    }
  }

  String tr(String langCode) => langCode == 'ar' ? ar : en;
}
