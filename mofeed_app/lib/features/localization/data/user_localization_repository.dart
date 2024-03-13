import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mofeed_shared/constants/common_params.dart';
import 'package:mofeed_shared/constants/fireabse_constants.dart';
import 'package:mofeed_shared/localization/data/localization_repository.dart';

import '../../../app/data/app_storage.dart';
import '../../signup/data/user_storage.dart';

class UserLocalizationRepository implements LocalizationRepository {
  final AppStorage _appStorage;
  final FirebaseFirestore _firestore;
  final UserStorage _userStorage;

  const UserLocalizationRepository({
    required FirebaseFirestore firestore,
    required AppStorage appStorage,
    required UserStorage userStorage,
  })  : _userStorage = userStorage,
        _firestore = firestore,
        _appStorage = appStorage;

  @override
  Future<void> changeLanguage(String lang) async {
    try {
      await _appStorage.saveLanguage(lang);
      final uid = await _userStorage.getUid();
      if (uid == null) {
        return;
      }
      await _firestore
          .collection(FirebaseConst.users)
          .doc(uid)
          .update({CommonParams.local: lang});
    } catch (e, st) {
      Error.throwWithStackTrace(ChangeLanguageFailure(e), st);
    }
  }

  @override
  Future<String?> getSavedLang() async {
    try {
      final lang = await _appStorage.getSavedLang();
      return lang;
    } catch (e, st) {
      Error.throwWithStackTrace(GetLanguageFailure(e), st);
    }
  }
}
