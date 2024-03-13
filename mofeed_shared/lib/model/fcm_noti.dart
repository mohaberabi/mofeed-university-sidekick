import 'dart:convert';

import 'package:mofeed_shared/constants/common_params.dart';
import 'package:mofeed_shared/model/message_model.dart';

import '../utils/enums/restarant.dart';
import '../utils/typdefs/typedefs.dart';

enum NotificationPayLoad {
  chat,
  echo,
  order;
}

extension NotificationString on String {
  NotificationPayLoad get toNotificationPayLoad {
    switch (this) {
      case "chat":
        return NotificationPayLoad.chat;
      case "echo":
        return NotificationPayLoad.echo;
      default:
        return NotificationPayLoad.order;
    }
  }
}

class FcmNoti {
  final String to;

  final String title;

  final String body;

  final Map<String, String> data;

  const FcmNoti({
    required this.title,
    required this.body,
    required this.to,
    this.data = const {},
  });

  MapJson toMap() {
    return {
      'to': to,
      'sound': "default",
      'notification': {
        "title": title,
        "body": body,
      },
      "data": data,
      "apns": {
        "payload": {
          "aps": {
            "sound": "default",
          }
        }
      },
    };
  }

  factory FcmNoti.fromMap(MapJson map) {
    return FcmNoti(
      title: map['title'] ?? "",
      body: map['body'] ?? "",
      to: map['to'] ?? "",
      data: map['data'],
    );
  }

  factory FcmNoti.toChat({
    required String lang,
    required String token,
    required MessageModel message,
    String image = '',
    String username = 'Mofeed User',
  }) {
    final String title = lang == CommonParams.en
        ? "You have got a new message"
        : "جاتلك رسالة جديدة";
    final String body = lang == "en" ? "Tap and respond " : "دوس ورد";
    final data = {
      CommonParams.type: NotificationPayLoad.chat.name,
      CommonParams.data: jsonEncode(message.toMap()),
      CommonParams.image: image,
      CommonParams.username: username,
    };
    return FcmNoti(
      title: title,
      body: body,
      to: token,
      data: data,
    );
  }

  factory FcmNoti.toOrder({
    required OrderStatus status,
    required String lang,
    required String token,
  }) {
    final String title = status.tr(lang);
    final String body = status.subtitle[lang]!;
    return FcmNoti(title: title, body: body, to: token);
  }

  factory FcmNoti.toEcho({
    required String lang,
    required String topic,
  }) {
    final echoTitle = {
      "ar": "زميلك ساب ايكو جديد",
      "en": "A new colleague left an echo"
    };
    final echoSubtitle = {
      "ar": "شوف يمكن تقدر تساعده",
      "en": "See if you can offer any help"
    };
    return FcmNoti(
      title: echoTitle[lang]!,
      body: echoSubtitle[lang]!,
      to: '/topics/$topic',
    );
  }

  factory FcmNoti.toEchoReply({
    required String lang,
    required String token,
    required String body,
    required String username,
  }) {
    final title = {
      "en": "$username replied to your echo",
      "ar": "$username رد علي الأيكو بتاعك"
    };
    final data = {
      CommonParams.type: NotificationPayLoad.echo.name,
      CommonParams.username: username,
    };
    return FcmNoti(
      title: title[lang]!,
      body: body,
      to: token,
      data: data,
    );
  }
}
