import 'package:mofeduserpp/features/sakan_builder/cubit/sakan_builder_state.dart';
import 'package:mofeed_shared/localization/app_local.dart';

extension StateHydrate on SakanBuilderState {
  String amenitiesTitle(AppLocalizations local) =>
      mateWanted ? local.aminityTtlMateWanted : local.aminityTtlRoomWanted;

  String bathRoomTitle(AppLocalizations local) => mateWanted
      ? local.bathRoomTitleMateWanted
      : local.bathRoomTitleRoomWanted;

  String priceTitle(AppLocalizations local) =>
      mateWanted ? local.priceTitleMateWanted : local.priceTitleRoomWanted;

  String paymentTitle(AppLocalizations local) =>
      mateWanted ? local.paymentTitleMateWanted : local.paymentTitleRoomWanted;

  String stayingTitle(AppLocalizations local) =>
      mateWanted ? local.stayingTitleMateWanted : local.stayingTitleRoomWanted;

  String useCaseTitle(AppLocalizations local) =>
      mateWanted ? local.userCaseMateWanted : local.useCaseRoomWanted;

  String roomReadyTitle(AppLocalizations local) => mateWanted
      ? local.roomReadyTitleMateWanted
      : local.roomReadyTitleRoomWanted;

  Map<String, dynamic> toMap() {
    return {
      'pageIndex': pageIndex,
      'error': error,
      'state': state.name,
      'sakanType': sakanType.name,
      'price': price,
      'privateBathRoom': privateBathRoom,
      'anyUniversity': anyUniversity,
      'billingPeriod': billingPeriod.name,
      'maxStay': maxStay,
      'minStay': minStay,
      'roomRequestType': roomRequestType.name,
      'roomImages': roomImages.map((e) => e.path).toList(),
      'amenties': amenties.map((map) => map.name).toList(),
      'title': title,
      'description': description,
      'availableFrom': availableFrom?.millisecondsSinceEpoch,
      'phone': phone,
      'isSingle': isSingle,
      'inCompound': inCompound,
      'isBillIncluded': isBillIncluded,
      'floor': floor,
      'showPhoneNumber': showPhoneNumber,
      'nearestServices': nearestServices,
      'compound': compound,
      'meteres': meteres,
      'currentRoomMates': currentRoomMates,
      'address': address?.toMap(),
    };
  }
}
