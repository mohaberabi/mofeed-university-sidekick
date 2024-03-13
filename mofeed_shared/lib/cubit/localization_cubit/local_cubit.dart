import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../localization/data/localization_repository.dart';
import 'local_states.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final LocalizationRepository _localizationRepository;

  LocalizationCubit({
    required LocalizationRepository localizationRepository,
  })  : _localizationRepository = localizationRepository,
        super(const LocalInitState());

  void getSavedLanguage() async {
    final String deviceLanguage =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    final cachedLanguageCode = await _localizationRepository.getSavedLang();
    if (cachedLanguageCode != null) {
      emit(ChangeLocalState(locale: Locale(cachedLanguageCode)));
    } else if (deviceLanguage == 'ar') {
      emit(const ChangeLocalState(locale: Locale('ar')));
      changeLanguage('ar');
    } else if (deviceLanguage == 'en') {
      emit(const ChangeLocalState(locale: Locale('en')));
      changeLanguage('en');
    } else {
      emit(const ChangeLocalState(locale: Locale('ar')));
      changeLanguage('ar');
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    final currentLanguage = (state as ChangeLocalState).locale.languageCode;
    if (currentLanguage == languageCode) {
      return;
    } else {
      emit(ChangeLocalState(locale: Locale(languageCode)));
      await _localizationRepository.changeLanguage(languageCode);
    }
  }
}
