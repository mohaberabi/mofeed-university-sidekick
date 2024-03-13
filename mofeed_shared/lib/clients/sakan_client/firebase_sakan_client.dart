import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mofeed_shared/clients/sakan_client/sakan_client.dart';
import 'package:mofeed_shared/constants/app_constants.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';
import 'package:mofeed_shared/utils/extensions/firestore_ext.dart';
import 'package:sakan/model/sakan_model.dart';
import 'package:sakan/utils/enums/common_enums.dart';

import '../../constants/common_params.dart';
import '../../constants/fireabse_constants.dart';
import '../../constants/const_methods.dart';
import '../../utils/typdefs/typedefs.dart';

class FirebaseSakanCleint implements SakanClient {
  final FirebaseFirestore _firestore;

  const FirebaseSakanCleint({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<void> addSakan(Sakan sakan) async {
    try {
      await _sakan.doc(sakan.id).set(sakan.toMap());
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(AddSakanFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<void> deleteSakan(String id) async {
    try {
      await _sakan.doc(id).delete();
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(DeleteSakanFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<List<Sakan>> getSakans({
    SakanType type = SakanType.roomWanted,
    int limit = 10,
    String? lastDocId,
    bool? privateBathRoom,
    List<String>? amenities,
    int? minStay,
    int? maxStay,
    String? billingPeriod,
    int? availableFrom,
    bool? billIncluded,
    bool? isSingle,
    int? floor,
    int? currentMates,
    double? nearestServices,
    String? uid,
  }) async {
    try {
      final query = _sakan
          .orderBy(CommonParams.createdAt, descending: true)
          .where(CommonParams.uid, isEqualTo: uid)
          .where(CommonParams.type, isEqualTo: type.name)
          .where(CommonParams.billingPeriod, isEqualTo: billingPeriod)
          .where(CommonParams.privateBathRoom, isEqualTo: privateBathRoom)
          .where(CommonParams.billIncluded, isEqualTo: billIncluded)
          .where(CommonParams.amenities, arrayContainsAny: amenities)
          .where(CommonParams.isSingle, isEqualTo: isSingle)
          .where(CommonParams.floor, isLessThanOrEqualTo: floor)
          .where(CommonParams.currentMates, isLessThanOrEqualTo: currentMates)
          .where(CommonParams.minStay, isGreaterThanOrEqualTo: minStay)
          .where(CommonParams.maxStay, isLessThanOrEqualTo: maxStay)
          .limit(limit);

      final sakans = await _firestore.paginate<Sakan>(
          lastDocId: lastDocId,
          query: query,
          lastDocColl: _sakan,
          mapList: (values) async {
            final data = <Sakan>[];
            for (final value in values) {
              data.add(Sakan.fromMap(value));
            }
            return data;
          });
      return sakans;
    } on FirebaseException catch (e, st) {
      testPrint(e, st);
      Error.throwWithStackTrace(GetSakansFailure(e.mapCodeToError), st);
    }
  }

  CollectionReference<MapJson> get _sakan =>
      _firestore.collection(FirebaseConst.sakan);
}
