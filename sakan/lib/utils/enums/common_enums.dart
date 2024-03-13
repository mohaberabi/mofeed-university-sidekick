import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/utils/enums/langauge_enum.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

enum PostState {
  waitingForReview,
  inReview,
  live,
  rejected;
}

enum SakanType with CustomEnum {
  roomWanted("Roommates", "زملاء سكن", AppIcons.mates),
  mateWanted("Rooms", "غرف ", AppIcons.room);

  final String icon;

  @override
  final String ar;
  @override
  final String en;

  const SakanType(this.en,
      this.ar,
      this.icon,);

  MapJson get subtitle {
    switch (this) {
      case SakanType.roomWanted:
        return {
          "en": "Looking for a room to share with colleague ",
          "ar": "بدور على اوضة اشاركها مع زميلي",
        };

      case SakanType.mateWanted:
        return {
          "en": "Looking for a mate to share my room with ",
          "ar": "بدور على زميل اشاركه اوضتي",
        };
    }
  }
}

extension SakanTypeString on String {
  SakanType get toSakanType {
    switch (this) {
      case "roomWanted":
        return SakanType.roomWanted;
      case "mateWanted":
        return SakanType.mateWanted;
      default:
        return SakanType.mateWanted;
    }
  }
}

enum BillingPeriod with CustomEnum {
  monthly("Monthly", "شهري", "Month"),
  weekly("Weekly", "اسبوعي", "Week"),
  semester("Semester", "في الترم", "Semester");

  @override
  final String ar;
  @override
  final String en;
  final String per;

  const BillingPeriod(this.en, this.ar, this.per);
}

extension BillingPeriodString on String {
  BillingPeriod get toBillingPeriod {
    switch (this) {
      case "monthly":
        return BillingPeriod.monthly;
      case "weekly":
        return BillingPeriod.weekly;
      case "semester":
        return BillingPeriod.semester;
      default:
        return BillingPeriod.monthly;
    }
  }
}

enum RoomRequestType {
  room,
  bed,
  roomOrBed;
}

extension RoomRequestTypeString on String {
  RoomRequestType get toRoomRequestType {
    switch (this) {
      case "room":
        return RoomRequestType.room;
      case "bed":
        return RoomRequestType.bed;
      case "roomOrBed":
        return RoomRequestType.roomOrBed;
      default:
        return RoomRequestType.roomOrBed;
    }
  }
}
