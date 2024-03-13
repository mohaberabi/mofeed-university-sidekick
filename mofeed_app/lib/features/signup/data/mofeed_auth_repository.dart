import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mofeduserpp/features/signup/data/user_storage.dart';
import 'package:mofeduserpp/features/university/data/university_storage.dart';
import 'package:mofeed_shared/clients/auth_client/auth_client.dart';
import 'package:mofeed_shared/clients/univeristy_client/university_client.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/model/client_user_model.dart';
import 'package:mofeed_shared/model/user_model.dart';
import 'package:mofeed_shared/utils/error/failure.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class AuthRepository {
  final UserStorage _userStorage;
  final UniversityClient _universityClient;
  final AuthClient _authClient;
  final NetWorkInfo _netWorkInfo;
  final UniversityStorage _universityStorage;

  const AuthRepository({
    required AuthClient authClient,
    required UserStorage userStorage,
    required NetWorkInfo netWorkInfo,
    required UniversityStorage universityStorage,
    required UniversityClient universityClient,
  })  : _netWorkInfo = netWorkInfo,
        _authClient = authClient,
        _userStorage = userStorage,
        _universityClient = universityClient,
        _universityStorage = universityStorage;

  FutureEither<ClientUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String uniId,
    required String name,
    required String lastName,
    required String phone,
  }) async {
    try {
      final user = await _authClient.createUserWithEmailAndPassword(
          email: email,
          password: password,
          univeristyId: uniId,
          name: name,
          phone: phone,
          lastName: lastName);
      await _userStorage.saveUid(user.uId);
      await _userStorage.saveUser(user as ClientUser);
      final university = await _universityClient.getMYUniversity(user.uniId);
      await _universityStorage.saveUniversity(university);
      await _universityStorage.saveUniversityId(university.id);
      return Right(user);
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  Stream<ClientUser> get user =>
      _authClient.listenToUser().map((event) => event as ClientUser);

  FutureVoid sendResetPassword(String email) async {
    try {
      await _authClient.sendPasswordRestLink(email);
      return const Right(unit);
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  Future<bool> checkEmailVerified() async {
    try {
      return await _authClient.checkEmailVerified();
    } catch (e, st) {
      Error.throwWithStackTrace(e, st);
    }
  }

  FutureEither<ClientUser> signInwithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _authClient.signInWithEmailAndPassword(
          email: email, password: password);
      final university = await _universityClient.getMYUniversity(user.uniId);
      await _universityStorage.saveUniversity(university);
      await _universityStorage.saveUniversityId(university.id);
      await _userStorage.saveUser(user as ClientUser);
      await _userStorage.saveUid(user.uId);
      return Right(user);
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  FutureVoid sendEmailVerfication() async {
    try {
      await _authClient.sendEmailVerification();
      return const Right(unit);
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  FutureVoid signOut() async {
    try {
      await _authClient.signOut();

      return const Right(unit);
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  FutureVoid updateUser(UserModel user) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        await _authClient.updateUser(user);
        await _userStorage.saveUser(user as ClientUser);
        return const Right(unit);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }
}
