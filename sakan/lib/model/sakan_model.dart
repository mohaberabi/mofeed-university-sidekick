import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/utils/enums/user_prefs.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';
import 'package:sakan/model/mate_wanted.dart';
import 'package:sakan/model/room_wanted.dart';
import '../utils/enums/common_enums.dart';
import '../utils/enums/room_enums.dart';

abstract class Sakan with EquatableMixin implements Favorite {
  final String id;
  final bool privateBathRoom;
  final SakanType type;
  final PostState state;
  final String uniId;
  final String uid;
  final DateTime createdAt;
  final DateTime availableFrom;
  final String title;
  final String description;
  final List<RoomAmenity> amenties;
  final BillingPeriod billingPeriod;
  final bool anyUniversity;
  final int minStay;
  final int maxStay;
  final double price;
  final String phone;
  final bool showPhoneNo;
  final String username;
  final String bio;
  final Smoking smoking;
  final Pet pet;
  final Religion religion;
  final String profilePic;
  final Gender gender;
  final MapJson universityName;
  final String univeristyLogo;
  final double uniLat;

  final double uniLng;

  @override
  List<Object?> get props => [
        uniLat,
        uniLng,
        univeristyLogo,
        universityName,
        gender,
        profilePic,
        religion,
        pet,
        smoking,
        bio,
        username,
        showPhoneNo,
        phone,
        price,
        maxStay,
        minStay,
        id,
        privateBathRoom,
        type,
        state,
        uniId,
        uid,
        createdAt,
        availableFrom,
        title,
        description,
        amenties,
        billingPeriod,
        anyUniversity
      ];

  const Sakan({
    required this.id,
    required this.privateBathRoom,
    required this.type,
    required this.state,
    required this.uniId,
    required this.uid,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.amenties,
    required this.billingPeriod,
    required this.anyUniversity,
    required this.maxStay,
    required this.minStay,
    required this.availableFrom,
    required this.price,
    required this.phone,
    required this.showPhoneNo,
    required this.gender,
    required this.religion,
    required this.pet,
    required this.smoking,
    required this.username,
    required this.profilePic,
    required this.bio,
    required this.universityName,
    required this.univeristyLogo,
    required this.uniLng,
    required this.uniLat,
  });

  factory Sakan.fromMap(MapJson map) {
    final type = map['type'].toString().toSakanType;
    if (type == SakanType.roomWanted) {
      return RoomWanted.fromMap(map);
    } else {
      return MateWanted.fromMap(map);
    }
  }

  Sakan copyWith({
    String? id,
    bool? privateBathRoom,
    SakanType? type,
    PostState? state,
    String? uniId,
    String? uid,
    DateTime? createdAt,
    DateTime? availableFrom,
    String? title,
    String? description,
    List<RoomAmenity>? amenties,
    BillingPeriod? billingPeriod,
    bool? anyUniversity,
    int? minStay,
    int? maxStay,
    String? phone,
    bool? showPhoneNo,
    String? username,
    Smoking? smoking,
    Pet? pet,
    Religion? religion,
    String? profilePic,
    Gender? gender,
    String? bio,
    MapJson? universityName,
    String? univeristyLogo,
  });

  Map<String, dynamic> toMap() {
    return {
      "uniLat": uniLat,
      "uniLng": uniLng,
      "univeristyLogo": univeristyLogo,
      "id": id,
      "bio": bio,
      "privateBathRoom": privateBathRoom,
      "type": type.name,
      "state": state.name,
      "uniId": uniId,
      "uid": uid,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "availableFrom": availableFrom.millisecondsSinceEpoch,
      "title": title,
      "description": description,
      "amenties": amenties.map((e) => e.name).toList(),
      "billingPeriod": billingPeriod.name,
      "anyUniversity": anyUniversity,
      "minStay": minStay,
      "maxStay": maxStay,
      "price": price,
      "phone": phone,
      "showPhoneNo": showPhoneNo,
      "username": username,
      "smoking": smoking.name,
      "pet": pet.name,
      "religion": religion.name,
      "profilePic": profilePic,
      "gender": gender.name,
      "universityName": universityName
    };
  }

  String get cover;
}
