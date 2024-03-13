import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/utils/enums/langauge_enum.dart';

enum RoomAmenity with CustomEnum {
  ac("AC", "مكيف", AppIcons.ac),
  tv("TV", "تليفزيون", AppIcons.tv),
  dishwasher("Dishwasher", "غسالة اطباق", AppIcons.washer),
  microwave("Microwave", "ميكرويف", AppIcons.microphone),
  wifi("Internet", "انترنت", AppIcons.wifi),
  gas("Gas", "غاز", null),
  washingMachine("Washing Machine", "غسالة ملابس", AppIcons.washer),
  airFrier("AirFrier", "مقلاة هوائية", AppIcons.fries);

  @override
  final String ar;
  @override
  final String en;
  @override
  final String? logo;

  const RoomAmenity(this.en, this.ar, this.logo);
}

extension RoomAmenityString on String {
  RoomAmenity get toRoomAmenity {
    switch (this) {
      case "ac":
        return RoomAmenity.ac;
      case "tv":
        return RoomAmenity.tv;
      case "dishwasher":
        return RoomAmenity.dishwasher;
      case "microwave":
        return RoomAmenity.microwave;
      case "wifi":
        return RoomAmenity.wifi;
      case "gas":
        return RoomAmenity.gas;
      case "washingMachine":
        return RoomAmenity.washingMachine;
      case "airFrier":
        return RoomAmenity.airFrier;
      default:
        return RoomAmenity.ac;
    }
  }
}
