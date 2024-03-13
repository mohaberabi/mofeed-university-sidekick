import 'package:mofeed_shared/model/user_model.dart';

import 'car_model.dart';

class ParkModel {
  const ParkModel({
    required this.car,
    required this.user,
    required this.createdat,
    required this.leaveAt,
    required this.uid,
    required this.reserved,
    required this.uniId,
     this.reservedBy,
    required this.reservedById,
  });

  final CarModel car;
  final UserModel user;
  final DateTime createdat;
  final DateTime leaveAt;
  final String uid;
  final bool reserved;
  final String? uniId;
  final UserModel ?reservedBy;
  final String reservedById;

  factory ParkModel.fromJson(Map<String, dynamic> json) {
    return ParkModel(
        car: CarModel.fromJson(json['car']),
        user: UserModel.fromMap(json['user']),
        uniId: json['uniId'],
        createdat: json['createdat'],
        leaveAt: json['leaveAt'],
        uid: json['uid'],
        reserved: json['reserved'],
        reservedBy: UserModel.fromMap(json['reservedBy']),
        reservedById: json['reservedById']);
  }

  Map<String, dynamic> toMap() {
    return {
      'reserved': reserved,
      'user': user.toMap(),
      'car': car.toMap(),
      'location': "location",
      'createdat': createdat,
      'leaveAt': leaveAt,
      'uid': uid,
      'uniId': uniId,
      'reservedById': reservedById,
      'reservedBy': reservedBy?.toMap()
    };
  }
}
