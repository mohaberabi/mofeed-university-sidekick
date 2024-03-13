import 'package:mofeduserpp/features/university/data/university_storage.dart';
import 'package:mofeed_shared/clients/univeristy_client/university_client.dart';
import 'package:mofeed_shared/data/network_info.dart';

import 'package:mofeed_shared/model/university_model.dart';
import 'package:mofeed_shared/utils/error/exceptions.dart';

class UniversityRepository {
  final NetWorkInfo _netWorkInfo;

  final UniversityStorage _storage;
  final UniversityClient _univeristyClient;

  const UniversityRepository({
    required UniversityClient univeristyClient,
    required NetWorkInfo netWorkInfo,
    required UniversityStorage storage,
  })  : _univeristyClient = univeristyClient,
        _storage = storage,
        _netWorkInfo = netWorkInfo;

  Future<void> saveUniversity(UniversityModel university) async {
    try {
      await _storage.saveUniversity(university);
      await _storage.saveUniversityId(university.id);
    } catch (e, st) {
      Error.throwWithStackTrace(SaveUniversityFailure(e), st);
    }
  }

  Future<List<UniversityModel>> getAllUniversities() async {
    try {
      if (!await _netWorkInfo.isConnected) {
        throw const NetWorkConnectionFailure();
      } else {
        final universities = await _univeristyClient.getUniversities();
        return universities;
      }
    } catch (e, st) {
      Error.throwWithStackTrace(GetAllUniversitiesFailure(e), st);
    }
  }

  Future<UniversityModel?> getMyUniversity() async {
    try {
      if (!await _netWorkInfo.isConnected) {
        final university = await _storage.getUniversity();
        return university;
      } else {
        final uniId = await _storage.getUniId();
        final myUniversity = await _univeristyClient.getMYUniversity(uniId!);
        await saveUniversity(myUniversity);
        return myUniversity;
      }
    } catch (e, st) {
      Error.throwWithStackTrace(GetMyUniversityFailure(e), st);
    }
  }
}

class SaveUniversityFailure extends AppException {
  const SaveUniversityFailure(super.error);
}

class GetMyUniversityFailure extends AppException {
  const GetMyUniversityFailure(super.error);
}

class GetAllUniversitiesFailure extends AppException {
  const GetAllUniversitiesFailure(super.error);
}
