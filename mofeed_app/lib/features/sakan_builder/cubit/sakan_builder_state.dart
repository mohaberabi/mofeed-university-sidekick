import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mofeduserpp/features/sakan_builder/cubit/sakan_builder_status.dart';
import 'package:mofeed_shared/model/app_address.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';
import 'package:sakan/model/sakan_model.dart';
import 'package:sakan/utils/enums/common_enums.dart';
import 'package:sakan/utils/enums/room_enums.dart';

class SakanBuilderState extends Equatable {
  final Sakan? tempSakan;

  final int pageIndex;
  final AppAddress? address;
  final String error;
  final SakanBuilderStatus state;
  final SakanType sakanType;
  final String price;
  final bool privateBathRoom;
  final bool anyUniversity;
  final BillingPeriod billingPeriod;
  final String maxStay;
  final String minStay;
  final RoomRequestType roomRequestType;
  final List<XFile> roomImages;
  final List<RoomAmenity> amenties;
  final String title;
  final String description;
  final DateTime? availableFrom;
  final String phone;
  final bool isSingle;
  final bool inCompound;
  final bool isBillIncluded;
  final int floor;
  final bool showPhoneNumber;
  final double nearestServices;
  final String compound;
  final double meteres;
  final int currentRoomMates;

  final String titleError;
  final String describitonError;

  const SakanBuilderState({
    this.pageIndex = 0,
    this.currentRoomMates = 1,
    this.state = SakanBuilderStatus.initial,
    this.error = '',
    this.meteres = 80,
    this.compound = '',
    this.floor = 1,
    this.nearestServices = 500,
    this.showPhoneNumber = false,
    this.isBillIncluded = true,
    this.isSingle = true,
    this.inCompound = false,
    this.phone = '',
    this.availableFrom,
    this.title = '',
    this.description = '',
    this.amenties = const [],
    this.roomRequestType = RoomRequestType.room,
    this.billingPeriod = BillingPeriod.monthly,
    this.sakanType = SakanType.roomWanted,
    this.anyUniversity = true,
    this.minStay = '0',
    this.maxStay = '0',
    this.privateBathRoom = false,
    this.price = '',
    this.roomImages = const [],
    this.titleError = '',
    this.describitonError = '',
    this.tempSakan,
    this.address,
  });

  @override
  List<Object?> get props => [
        compound,
        meteres,
        error,
        state,
        phone,
        inCompound,
        isSingle,
        isBillIncluded,
        showPhoneNumber,
        nearestServices,
        floor,
        roomImages,
        price,
        privateBathRoom,
        maxStay,
        minStay,
        anyUniversity,
        sakanType,
        billingPeriod,
        roomRequestType,
        amenties,
        description,
        title,
        availableFrom,
        pageIndex,
        currentRoomMates,
        address,
        titleError,
        describitonError,
        tempSakan,
      ];

  SakanBuilderState copyWith({
    String? error,
    SakanBuilderStatus? state,
    SakanType? sakanType,
    String? price,
    bool? privateBathRoom,
    bool? anyUniversity,
    BillingPeriod? billingPeriod,
    String? maxStay,
    String? minStay,
    double? budget,
    RoomRequestType? roomRequestType,
    List<XFile>? roomImages,
    List<RoomAmenity>? amenties,
    String? title,
    String? description,
    DateTime? availableFrom,
    String? phone,
    bool? isSingle,
    bool? inCompound,
    bool? isBillIncluded,
    int? floor,
    bool? showPhoneNumber,
    double? nearestServices,
    String? compound,
    double? meteres,
    int? pageIndex,
    int? currentRoomMates,
    String? titleErorr,
    String? describitionError,
    Sakan? tempSakan,
    AppAddress? address,
  }) {
    return SakanBuilderState(
        tempSakan: tempSakan ?? this.tempSakan,
        describitonError: describitionError ?? this.describitonError,
        titleError: titleErorr ?? this.titleError,
        currentRoomMates: currentRoomMates ?? this.currentRoomMates,
        pageIndex: pageIndex ?? this.pageIndex,
        error: error ?? this.error,
        state: state ?? this.state,
        sakanType: sakanType ?? this.sakanType,
        price: price ?? this.price,
        privateBathRoom: privateBathRoom ?? this.privateBathRoom,
        anyUniversity: anyUniversity ?? this.anyUniversity,
        billingPeriod: billingPeriod ?? this.billingPeriod,
        maxStay: maxStay ?? this.maxStay,
        minStay: minStay ?? this.minStay,
        roomRequestType: roomRequestType ?? this.roomRequestType,
        roomImages: roomImages ?? this.roomImages,
        amenties: amenties ?? this.amenties,
        title: title ?? this.title,
        description: description ?? this.description,
        availableFrom: availableFrom ?? this.availableFrom,
        phone: phone ?? this.phone,
        isSingle: isSingle ?? this.isSingle,
        inCompound: inCompound ?? this.inCompound,
        isBillIncluded: isBillIncluded ?? this.isBillIncluded,
        floor: floor ?? this.floor,
        showPhoneNumber: showPhoneNumber ?? this.showPhoneNumber,
        nearestServices: nearestServices ?? this.nearestServices,
        compound: compound ?? this.compound,
        meteres: meteres ?? this.meteres,
        address: address ?? this.address);
  }

  bool get mateWanted => sakanType == SakanType.mateWanted;

  double get progress =>
      sakanType == SakanType.mateWanted ? pageIndex / 4 : pageIndex / 3;

  bool get isLastStep => mateWanted ? pageIndex == 4 : pageIndex == 3;

  bool get stayingPrefValid =>
      price.isNotEmpty &&
      minStay.isNotEmpty &&
      maxStay.isNotEmpty &&
      availableFrom != null;

  bool get flatInfoValid =>
      roomImages.isNotEmpty && nearestServices > 0 && meteres > 0;

  bool get lastPageFormValid =>
      title.trim().isNotEmpty &&
      description.trim().isNotEmpty &&
      (showPhoneNumber ? phone.isNotEmpty : true) &&
      noErrors;

  bool get formValid => switch (pageIndex) {
        2 => stayingPrefValid,
        3 => mateWanted ? flatInfoValid : lastPageFormValid,
        4 =>
          mateWanted ? lastPageFormValid && address != null : lastPageFormValid,
        _ => true,
      };

  bool get noErrors => titleError.isEmpty && describitonError.isEmpty;

  @override
  String toString() => state.name;

  factory SakanBuilderState.fromMap(MapJson map) {
    return SakanBuilderState(
      currentRoomMates: map['currentRoomMates'],
      pageIndex: map['pageIndex'],
      error: map['error'],
      state: SakanBuilderStatus.initial,
      sakanType: map['sakanType'].toString().toSakanType,
      price: map['price'],
      privateBathRoom: map['privateBathRoom'],
      anyUniversity: map['anyUniversity'],
      billingPeriod: map['billingPeriod'].toString().toBillingPeriod,
      maxStay: map['maxStay'],
      minStay: map['minStay'],
      roomRequestType: map['roomRequestType'].toString().toRoomRequestType,
      roomImages:
          (map['roomImages'] as List).map((e) => XFile(e.toString())).toList(),
      amenties: (map['amenties'] as List)
          .map((e) => e.toString().toRoomAmenity)
          .toList(),
      title: map['title'],
      description: map['description'],
      availableFrom: map['availableFrom'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['availableFrom'])
          : null,
      phone: map['phone'],
      isSingle: map['isSingle'],
      inCompound: map['inCompound'],
      isBillIncluded: map['isBillIncluded'],
      floor: map['floor'],
      showPhoneNumber: map['showPhoneNumber'],
      nearestServices: map['nearestServices'].toDouble(),
      compound: map['compound'],
      meteres: map['meteres'].toDouble(),
      address:
          map["address"] != null ? AppAddress.fromMap(map["address"]) : null,
    );
  }
}
