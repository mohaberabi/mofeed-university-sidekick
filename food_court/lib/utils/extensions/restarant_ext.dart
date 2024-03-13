import 'package:mofeed_shared/utils/enums/restarant.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

extension OrderStatusConvertor on String {
  OrderStatus get toOrderStatus {
    switch (this) {
      case "sent":
        return OrderStatus.sent;
      case "recieved":
        return OrderStatus.recieved;
      case "out":
        return OrderStatus.out;

      case "done":
        return OrderStatus.done;
      case "canceled":
        return OrderStatus.canceled;
      default:
        return OrderStatus.sent;
    }
  }
}

extension RestarantStateConvertor on String {
  RestarantStateEnum get toRestarantState {
    switch (this) {
      case "closed":
        return RestarantStateEnum.closed;
      case "available":
        return RestarantStateEnum.available;
      default:
        return RestarantStateEnum.busy;
    }
  }
}

extension OwnerStatusBtn on OrderStatus {
  Map<String, String> actionLabel(bool delivery) {
    switch (this) {
      case OrderStatus.sent:
        return {"en": "Accept", "ar": "اقبل"};
      case OrderStatus.recieved:
        return delivery
            ? {"en": "Out", "ar": "خرج"}
            : {"en": "Ready", "ar": "جاهز"};
      default:
        return {"en": "Done", "ar": "خلص"};

      // case OrderStatus.done:
      //   return {"en": "Accept", "ar": "اقبل"};
      // case OrderStatus.canceled:
      //   return {"en": "Accept", "ar": "اقبل"};
    }
  }
}
