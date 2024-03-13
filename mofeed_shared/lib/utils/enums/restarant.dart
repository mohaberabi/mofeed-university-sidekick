import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/utils/enums/langauge_enum.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

import '../../ui/colors/app_colors.dart';

enum OrderStatus with CustomEnum {
  sent("Order is sent", "الطلب اتبعت"),
  recieved("Order is being prepared", "الطلب بيجهز"),
  out("Order Out", "الطلب خرج"),
  done("Order Done", 'الطلب منتهي'),
  canceled("Order Canceled", "الطلب ملغي");

  const OrderStatus(this.en, this.ar);

  bool get isPreparing => isSent || isRecieved || isOut;

  bool get isSent => this == OrderStatus.sent;

  bool get isRecieved => this == OrderStatus.recieved;

  bool get isOut => this == OrderStatus.out;

  bool get isCanceled => this == OrderStatus.canceled;

  bool get isDone => this == OrderStatus.done;

  String image(bool isDark) {
    switch (this) {
      case OrderStatus.sent:
        return isDark ? AppIcons.doneDark : AppIcons.done;
      case OrderStatus.recieved:
        return isDark ? AppIcons.doneDark : AppIcons.done;
      case OrderStatus.out:
        return isDark ? AppIcons.doneDark : AppIcons.done;
      case OrderStatus.done:
        return isDark ? AppIcons.doneDark : AppIcons.done;
      case OrderStatus.canceled:
        return isDark ? AppIcons.doneDark : AppIcons.done;
    }
  }

  MapJson get subtitle {
    switch (this) {
      case OrderStatus.sent:
        return {
          "en":
              "Your order has been sent to restaurant wait until it's accepted ",
          "ar": "طلبك اتقبل من المطعم استني لحد ما يتقبل",
        };
      case OrderStatus.recieved:
        return {
          "en":
              "Your order is accepted , it's being prepared will be ready on time ",
          "ar": "",
        };
      case OrderStatus.out:
        return {
          "en": "Your order is out for handover , happy meal",
          "ar": "طلبك جايلك ف الطريق , وجبة سعيدة",
        };

      case OrderStatus.done:
        return {
          "en": "Your order was successfully completed",
          "ar": "طلبك انتهي بنجاح",
        };
      case OrderStatus.canceled:
        return {
          "en": "Your order was canceled ",
          "ar": "طلبك اتغلي ",
        };
    }
  }

  OrderStatus get next {
    switch (this) {
      case OrderStatus.sent:
        return OrderStatus.recieved;
      case OrderStatus.recieved:
        return OrderStatus.out;
      case OrderStatus.out:
        return OrderStatus.done;
      case OrderStatus.canceled:
        return OrderStatus.canceled;
      default:
        return this;
    }
  }

  @override
  final String ar;

  @override
  final String en;
}

enum RestarantStateEnum with CustomEnum {
  available("مفتوح", "Accpeting Orders"),
  busy("مشغول", "Busy"),
  closed("مقفول", "Closed");

  bool get isClosed => this == RestarantStateEnum.closed;

  bool get isBusy => this == RestarantStateEnum.busy;

  bool get isAvailable => this == RestarantStateEnum.available;

  const RestarantStateEnum(this.ar, this.en);

  Color get color {
    switch (this) {
      case RestarantStateEnum.closed:
        return Colors.red;
      case RestarantStateEnum.busy:
        return Colors.orange;
      default:
        return AppColors.primColor;
    }
  }

  @override
  final String ar;
  @override
  final String en;
}
