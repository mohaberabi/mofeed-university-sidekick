import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/utils/enums/user_prefs.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';
import 'package:sakan/model/mate_wanted.dart';
import 'package:sakan/model/sakan_model.dart';

import '../utils/enums/common_enums.dart';
import '../utils/enums/room_enums.dart';

class RoomWanted extends Sakan {
  final RoomRequestType roomRequestType;

  const RoomWanted({
    String bio = '',
    SakanType type = SakanType.roomWanted,
    required DateTime availableFrom,
    required double price,
    required this.roomRequestType,
    required int minStay,
    required int maxStay,
    required bool privateBathRoom,
    required PostState state,
    required bool anyUniversity,
    required BillingPeriod billingPeriod,
    required String id,
    required String uniId,
    required String uid,
    required DateTime createdAt,
    required String title,
    required String description,
    required List<RoomAmenity> amenties,
    String phone = '',
    bool showPhoneNo = false,
    required Pet pet,
    required Religion religion,
    required Gender gender,
    required String username,
    required String profilePic,
    required Smoking smoking,
    required MapJson universityName,
    required String universityLogo,
    required double uniLat,
    required double uniLng,
  }) : super(
          uniLat: uniLat,
          uniLng: uniLng,
          bio: bio,
          universityName: universityName,
          univeristyLogo: universityLogo,
          username: username,
          smoking: smoking,
          pet: pet,
          gender: gender,
          religion: religion,
          profilePic: profilePic,
          phone: phone,
          showPhoneNo: showPhoneNo,
          price: price,
          availableFrom: availableFrom,
          id: id,
          minStay: minStay,
          maxStay: maxStay,
          privateBathRoom: privateBathRoom,
          type: type,
          state: state,
          uniId: uniId,
          uid: uid,
          createdAt: createdAt,
          title: title,
          description: description,
          amenties: amenties,
          billingPeriod: billingPeriod,
          anyUniversity: anyUniversity,
        );

  factory RoomWanted.fromMap(MapJson map) {
    return RoomWanted(
      uniLat: map['uniLat'] != null ? map['uniLat'].toDouble() : 0.0,
      uniLng: map['uniLng'] != null ? map['uniLng'].toDouble() : 0.0,
      universityLogo: map["universityLogo"] ?? "",
      universityName: map['universityName'] ?? const {"ar": "", "en": ""},
      bio: map['bio'] ?? "",
      username: map["username"] ?? "",
      profilePic: map["profilePic"] ?? '',
      pet: map["pet"] != null ? (map["pet"].toString()).toPet : Pet.na,
      id: map["id"],
      smoking: map["smoking"] != null
          ? (map["smoking"].toString()).toSmoking
          : Smoking.nonSmokerButOkay,
      religion: map["religion"] != null
          ? (map["religion"].toString()).toReligion
          : Religion.na,
      gender: map["gender"] != null
          ? (map["gender"].toString()).toGender
          : Gender.na,
      price: map["price"],
      privateBathRoom: map["privateBathRoom"] ?? false,
      type: SakanType.roomWanted,
      state: PostState.inReview,
      uniId: map["uniId"] ?? "",
      uid: map["uid"] ?? "",
      createdAt: DateTime.fromMillisecondsSinceEpoch(map["createdAt"]),
      availableFrom: DateTime.fromMillisecondsSinceEpoch(map["availableFrom"]),
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      amenties: map["amenties"] != null
          ? (map["amenties"] as List)
              .map((aminity) => aminity.toString().toRoomAmenity)
              .toList()
          : [],
      billingPeriod: map["billingPeriod"].toString().toBillingPeriod,
      anyUniversity: map["anyUniversity"] ?? true,
      minStay: map["minStay"],
      maxStay: map["maxStay"],
      roomRequestType: map['roomRequestType'].toString().toRoomRequestType,
    );
  }

  @override
  String get cover => profilePic;

  @override
  List<Object?> get props => [...super.props, roomRequestType];

  @override
  Sakan copyWith({
    String? id,
    String? username,
    Smoking? smoking,
    Pet? pet,
    Religion? religion,
    String? profilePic,
    Gender? gender,
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
    String? cover,
    double? price,
    RoomRequestType? roomRequestType,
    String? phone,
    bool? showPhoneNo,
    String? bio,
    MapJson? universityName,
    String? univeristyLogo,
  }) {
    return RoomWanted(
      uniLng: uniLng,
      uniLat: uniLat,
      universityLogo: univeristyLogo ?? this.univeristyLogo,
      universityName: universityName ?? this.universityName,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      smoking: smoking ?? this.smoking,
      profilePic: profilePic ?? this.profilePic,
      username: username ?? this.username,
      religion: religion ?? this.religion,
      pet: pet ?? this.pet,
      phone: phone ?? this.phone,
      showPhoneNo: showPhoneNo ?? this.showPhoneNo,
      price: price ?? this.price,
      billingPeriod: billingPeriod ?? this.billingPeriod,
      minStay: minStay ?? this.minStay,
      maxStay: maxStay ?? this.minStay,
      anyUniversity: anyUniversity ?? this.anyUniversity,
      privateBathRoom: privateBathRoom ?? this.privateBathRoom,
      state: state ?? this.state,
      roomRequestType: roomRequestType ?? this.roomRequestType,
      id: id ?? this.id,
      uniId: uniId ?? this.uniId,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      description: description ?? this.description,
      amenties: amenties ?? this.amenties,
      availableFrom: availableFrom ?? this.availableFrom,
    );
  }

  @override
  MapJson toMap() {
    final map = super.toMap();
    map['cover'] = cover;
    map['roomRequestType'] = roomRequestType.name;
    return map;
  }

  factory RoomWanted.fromMateWanted(
    MateWanted mateWanted, {
    required RoomRequestType requestType,
    required String cover,
  }) {
    return RoomWanted(
      uniLat: mateWanted.uniLat,
      uniLng: mateWanted.uniLng,
      universityLogo: mateWanted.univeristyLogo,
      universityName: mateWanted.universityName,
      bio: mateWanted.bio,
      pet: mateWanted.pet,
      religion: mateWanted.religion,
      smoking: mateWanted.smoking,
      showPhoneNo: mateWanted.showPhoneNo,
      profilePic: mateWanted.profilePic,
      phone: mateWanted.phone,
      gender: mateWanted.gender,
      price: mateWanted.price,
      availableFrom: mateWanted.availableFrom,
      roomRequestType: requestType,
      minStay: mateWanted.minStay,
      maxStay: mateWanted.maxStay,
      privateBathRoom: mateWanted.privateBathRoom,
      state: mateWanted.state,
      anyUniversity: mateWanted.anyUniversity,
      billingPeriod: mateWanted.billingPeriod,
      id: mateWanted.id,
      uniId: mateWanted.uniId,
      uid: mateWanted.uid,
      createdAt: mateWanted.createdAt,
      title: mateWanted.title,
      description: mateWanted.description,
      amenties: mateWanted.amenties,
      username: mateWanted.username,
    );
  }

  @override
  FavoriteType get favoriteType => FavoriteType.roomWanted;
}
