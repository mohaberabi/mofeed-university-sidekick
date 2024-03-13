import 'package:mofeduserpp/app/data/app_storage.dart';
import 'package:mofeduserpp/features/signup/data/user_storage.dart';
import 'package:mofeed_shared/clients/auth_client/auth_client.dart';
import 'package:mofeed_shared/utils/error/exceptions.dart';

class StartupRepository {
  final UserStorage _userStorage;

  final AppStorage _appStorage;

  final AuthClient _authClient;

  const StartupRepository({
    required AppStorage appStorage,
    required AuthClient authClient,
    required UserStorage userStorage,
  })  : _authClient = authClient,
        _appStorage = appStorage,
        _userStorage = userStorage;

  Future<bool> didSeeOnBoarding() async {
    try {
      return await _appStorage.seenOnBoarding();
    } catch (e, st) {
      Error.throwWithStackTrace(GetOnBoardingAtStartupFailure(e), st);
    }
  }

  Future<void> clearAppFiles() async {
    try {
      await _appStorage.clear();
    } catch (e, st) {
      Error.throwWithStackTrace(ClearAppFilesAtStarupFailure(e), st);
    }
  }

  Future<bool> verifiedAccount() async {
    try {
      return await _authClient.checkEmailVerified();
    } catch (e, st) {
      Error.throwWithStackTrace(GetEmailVerificationAtStartUpFailure(e), st);
    }
  }

  Future<bool> didCreateAccount() async {
    try {
      return await _userStorage.getUser() != null;
    } catch (e, st) {
      Error.throwWithStackTrace(GetCreateAccountAtStartupFailure(e), st);
    }
  }

  Future<bool> didCompleteProfile() async {
    try {
      final user = await _userStorage.getUser();
      return user!.completedProfile;
    } catch (e, st) {
      Error.throwWithStackTrace(GetCompleteProfileAtStarupFailure(e), st);
    }
  }
}

class GetEmailVerificationAtStartUpFailure extends AppException {
  const GetEmailVerificationAtStartUpFailure(super.error);
}

class GetCompleteProfileAtStarupFailure extends AppException {
  const GetCompleteProfileAtStarupFailure(super.error);
}

class GetCreateAccountAtStartupFailure extends AppException {
  const GetCreateAccountAtStartupFailure(super.error);
}

class GetOnBoardingAtStartupFailure extends AppException {
  const GetOnBoardingAtStartupFailure(super.error);
}

class ClearAppFilesAtStarupFailure extends AppException {
  const ClearAppFilesAtStarupFailure(super.error);
}
