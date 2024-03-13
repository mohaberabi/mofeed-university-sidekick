import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mofeed_shared/clients/sakan_client/sakan_client.dart';
import 'package:mofeed_shared/data/network_info.dart';

import 'package:mofeed_shared/utils/error/error_codes.dart';
import 'package:mofeed_shared/utils/error/failure.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';
import 'package:sakan/model/sakan_model.dart';
import 'package:sakan/utils/enums/common_enums.dart';

import '../../signup/data/user_storage.dart';

class SakanRepository {
  final SakanClient _sakanClient;
  final NetWorkInfo _netWorkInfo;

  const SakanRepository({
    required SakanClient sakanClient,
    required NetWorkInfo netWorkInfo,
    required UserStorage storage,
  })  : _netWorkInfo = netWorkInfo,
        _sakanClient = sakanClient;

  FutureVoid addSakan(Sakan sakan) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        await _sakanClient.addSakan(sakan);
        return const Right(unit);
      }
    } on FirebaseException catch (e) {
      return Left(Failure(e.mapCodeToError));
    }
  }

  FutureVoid deleteSakan(String id) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        await _sakanClient.deleteSakan(id);
        return const Right(unit);
      }
    } on FirebaseException catch (e) {
      return Left(Failure(e.mapCodeToError));
    }
  }

  FutureEither<List<Sakan>> getSakans({
    SakanType type = SakanType.roomWanted,
    int limit = 10,
    String? lastDocId,
    bool? privateBathRoom,
    List<String>? amenities,
    String? billingPeriod,
    bool? billIncluded,
    bool? isSingle,
    int? minStay,
    int? maxStay,
    int? availableFrom,
    int? floor,
    int? currentMates,
    double? nearestServices,
    String? uid,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final sakans = await _sakanClient.getSakans(
          type: type,
          limit: limit,
          lastDocId: lastDocId,
          privateBathRoom: privateBathRoom,
          amenities: amenities,
          billingPeriod: billingPeriod,
          billIncluded: billIncluded,
          isSingle: isSingle,
          minStay: minStay,
          maxStay: maxStay,
          availableFrom: availableFrom,
          floor: floor,
          currentMates: currentMates,
          nearestServices: nearestServices,
          uid: uid,
        );
        return Right(sakans);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }
}
