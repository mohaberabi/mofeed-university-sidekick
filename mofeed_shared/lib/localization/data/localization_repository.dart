import 'package:equatable/equatable.dart';

abstract class LocalizationRepositoryFailure
    with EquatableMixin
    implements Exception {
  final Object? error;

  const LocalizationRepositoryFailure(this.error);

  @override
  List<Object?> get props => [error];
}

abstract class LocalizationRepository {
  const LocalizationRepository();

  Future<void> changeLanguage(String lang);

  Future<String?> getSavedLang();
}

class ChangeLanguageFailure extends LocalizationRepositoryFailure {
  const ChangeLanguageFailure(super.error);
}

class GetLanguageFailure extends LocalizationRepositoryFailure {
  const GetLanguageFailure(super.error);
}
