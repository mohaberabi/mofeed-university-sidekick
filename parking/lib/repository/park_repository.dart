import 'dart:async';

import 'package:mofeed_shared/model/user_model.dart';

import 'package:mofeed_shared/utils/typdefs/typedefs.dart';


import '../model/park_model.dart';
abstract class ParkRepository {
  Stream<ParkModel?> findBestMatch(DateTime parkingTime);
  FutureVoid leaveParkingEmpty(String parkId);
  FutureVoid leaveReservation(String parkId);
  FutureVoid parkMyCar(ParkModel park);
FutureVoid reserveParking(
      {required String parkId, required UserModel reserver});

Stream<ParkModel>getMyPark();
Stream<ParkModel?>getMyReservation ();
}
