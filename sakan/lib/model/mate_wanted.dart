import 'package:mofeed_shared/constants/app_constants.dart';
import 'package:mofeed_shared/model/app_address.dart';
import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/utils/enums/user_prefs.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';
import 'package:sakan/model/sakan_model.dart';

import '../utils/enums/common_enums.dart';
import '../utils/enums/room_enums.dart';

class MateWanted extends Sakan {
  final bool isBillIncluded;
  final bool isSingle;
  final List<String> roomImages;
  final int currentMates;
  final double nearestServices;
  final double metres;
  final int floor;
  final AppAddress address;

  const MateWanted({
    String bio = '',
    SakanType type = SakanType.mateWanted,
    PostState state = PostState.inReview,
    String phone = '',
    bool showPhoneNo = false,
    required double price,
    required String title,
    required String description,
    required List<RoomAmenity> amenties,
    required DateTime createdAt,
    required this.isBillIncluded,
    required this.isSingle,
    required this.currentMates,
    required this.nearestServices,
    required this.metres,
    required this.floor,
    required bool privateBathRoom,
    required bool anyUniversity,
    required BillingPeriod billingPeriod,
    required int minStay,
    required int maxStay,
    required this.roomImages,
    required DateTime availableFrom,
    required String id,
    required String uniId,
    required String uid,
    required Pet pet,
    required Religion religion,
    required Gender gender,
    required String username,
    required String profilePic,
    required Smoking smoking,
    required this.address,
    required MapJson universityName,
    required String universityLogo,
    required double uniLat,
    required double uniLng,
  }) : super(
          bio: bio,
          uniLat: uniLat,
          uniLng: uniLng,
          univeristyLogo: universityLogo,
          username: username,
          smoking: smoking,
          pet: pet,
          gender: gender,
          religion: religion,
          profilePic: profilePic,
          price: price,
          maxStay: maxStay,
          minStay: minStay,
          id: id,
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
          availableFrom: availableFrom,
          phone: phone,
          showPhoneNo: showPhoneNo,
          universityName: universityName,
        );

  factory MateWanted.fromMap(MapJson map) {
    return MateWanted(
      uniLat: map['uniLat'] != null ? map['uniLat'].toDouble() : 0.0,
      uniLng: map['uniLng'] != null ? map['uniLng'].toDouble() : 0.0,
      universityLogo: map['universityLogo'] ?? "",
      universityName: map['universityName'] ?? const {"ar": "", "en": ""},
      address: map['address'] != null
          ? AppAddress.fromMap(map['address'])
          : tempAddress,
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
      privateBathRoom: map["privateBathRoom"] ?? false,
      type: SakanType.mateWanted,
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
      minStay: map["minStay"].toInt(),
      maxStay: map["maxStay"].toInt(),
      isBillIncluded: map['isBillIncluded'],
      isSingle: map['isSingle'] ?? true,
      nearestServices: map['nearestServices'].toDouble(),
      phone: map['phone'] ?? "",
      currentMates: map['currentMates'].toInt(),
      showPhoneNo: map['showPhoneNo'] ?? false,
      metres: map['metres'].toDouble(),
      floor: map['floor'].toInt(),
      price: map['price'].toDouble(),
      roomImages: map['roomImages'] != null
          ? (map['roomImages'] as List).map((e) => e.toString()).toList()
          : [],
    );
  }

  @override
  MapJson toMap() {
    final map = super.toMap();
    map['floor'] = floor;
    map['metres'] = metres;
    map['nearestServices'] = nearestServices;
    map['showPhoneNo'] = showPhoneNo;
    map['phone'] = phone;
    map['currentMates'] = currentMates;
    map['roomImages'] = roomImages;
    map['isSingle'] = isSingle;
    map['isBillIncluded'] = isBillIncluded;
    map['type'] = type.name;
    map['address'] = address.toMap();

    return map;
  }

  @override
  List<Object?> get props => [
        ...super.props,
        isBillIncluded,
        isSingle,
        roomImages,
        currentMates,
        nearestServices,
        metres,
        floor,
        address
      ];

  @override
  MateWanted copyWith({
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
    List? intersets,
    List<RoomAmenity>? amenties,
    BillingPeriod? billingPeriod,
    String? userName,
    String? profilePic,
    bool? anyUniversity,
    int? minStay,
    int? maxStay,
    bool? isBillIncluded,
    bool? isSingle,
    double? price,
    List<String>? roomImages,
    int? currentMates,
    double? nearestServices,
    double? metres,
    int? floor,
    String? phone,
    bool? showPhoneNo,
    String? username,
    Smoking? smoking,
    Pet? pet,
    Religion? religion,
    Gender? gender,
    String? bio,
    AppAddress? address,
    MapJson? universityName,
    String? univeristyLogo,
  }) {
    return MateWanted(
        universityLogo: univeristyLogo ?? this.univeristyLogo,
        universityName: universityName ?? this.universityName,
        address: address ?? this.address,
        bio: bio ?? this.bio,
        gender: gender ?? this.gender,
        smoking: smoking ?? this.smoking,
        profilePic: profilePic ?? this.profilePic,
        username: username ?? this.username,
        religion: religion ?? this.religion,
        pet: pet ?? this.pet,
        phone: phone ?? this.phone,
        showPhoneNo: showPhoneNo ?? this.showPhoneNo,
        isBillIncluded: isBillIncluded ?? this.isBillIncluded,
        isSingle: isSingle ?? this.isSingle,
        price: price ?? this.price,
        roomImages: roomImages ?? this.roomImages,
        currentMates: currentMates ?? this.currentMates,
        nearestServices: nearestServices ?? this.nearestServices,
        metres: metres ?? this.metres,
        floor: floor ?? this.floor,
        id: id ?? this.id,
        privateBathRoom: privateBathRoom ?? this.privateBathRoom,
        type: type ?? this.type,
        state: state ?? this.state,
        uniId: uniId ?? this.uniId,
        uid: uid ?? this.uid,
        createdAt: createdAt ?? this.createdAt,
        availableFrom: availableFrom ?? this.availableFrom,
        title: title ?? this.title,
        description: description ?? this.description,
        amenties: amenties ?? this.amenties,
        billingPeriod: billingPeriod ?? this.billingPeriod,
        anyUniversity: anyUniversity ?? this.anyUniversity,
        minStay: minStay ?? this.minStay,
        uniLng: uniLng,
        uniLat: uniLat,
        maxStay: maxStay ?? this.maxStay);
  }

  @override
  String get cover => roomImages.first;

  @override
  FavoriteType get favoriteType => FavoriteType.mateWanted;
}
