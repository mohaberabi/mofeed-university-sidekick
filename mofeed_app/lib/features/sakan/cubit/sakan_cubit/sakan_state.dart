import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/model/university_model.dart';
import 'package:sakan/model/sakan_model.dart';
import 'package:sakan/utils/enums/common_enums.dart';
import 'package:sakan/utils/enums/room_enums.dart';

enum SakanStatus {
  initial,
  loading,
  added,
  error,
  deleted,
  populated;
}

class SakanState extends Equatable {
  final String error;
  final SakanStatus state;
  final Map<String, Sakan> sakans;
  final SakanType sakanType;
  final BillingPeriod? period;
  final bool? privateBathRoom;
  final bool? isSingle;
  final int? floor;
  final int? currentMates;
  final bool? billIncluded;
  final UniversityModel myUniversity;

  final List<RoomAmenity>? amenities;

  @override
  List<Object?> get props => [
        state,
        error,
        sakans,
        sakanType,
        amenities,
        billIncluded,
        currentMates,
        floor,
        isSingle,
        privateBathRoom,
        period,
        myUniversity,
      ];

  const SakanState({
    this.sakans = const {},
    this.state = SakanStatus.initial,
    this.error = '',
    this.sakanType = SakanType.roomWanted,
    this.privateBathRoom,
    this.floor,
    this.currentMates,
    this.billIncluded,
    this.amenities,
    this.period,
    this.isSingle,
    this.myUniversity = UniversityModel.empty,
  });

  SakanState copyWith({
    String? error,
    SakanStatus? state,
    Map<String, Sakan>? sakans,
    SakanType? sakanType,
    BillingPeriod? period,
    bool? privateBathRoom,
    bool? isSingle,
    int? floor,
    int? currentMates,
    bool? billIncluded,
    List<RoomAmenity>? amenities,
    UniversityModel? myUniversity,
  }) {
    return SakanState(
      amenities: amenities ?? this.amenities,
      isSingle: isSingle ?? this.isSingle,
      billIncluded: billIncluded ?? this.billIncluded,
      currentMates: currentMates ?? this.currentMates,
      floor: floor ?? this.floor,
      privateBathRoom: privateBathRoom ?? this.privateBathRoom,
      period: period ?? this.period,
      sakanType: sakanType ?? this.sakanType,
      error: error ?? this.error,
      state: state ?? this.state,
      sakans: sakans ?? this.sakans,
      myUniversity: myUniversity ?? this.myUniversity,
    );
  }

  @override
  String toString() => state.name;

  bool get hasFilters =>
      amenities != null ||
      period != null ||
      privateBathRoom != null ||
      floor != null ||
      billIncluded != null ||
      isSingle != null;
}
