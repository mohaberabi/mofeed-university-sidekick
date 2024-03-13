import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract final class LocalNotificaionConst {
  static const defaultDarwinDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );
  static const defaultAppDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: defaultDarwinDetails,
  );

  static const androidNotificationDetails = AndroidNotificationDetails(
      androidChannelId, androidChannelId,
      importance: Importance.high,
      playSound: true,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
      icon: '@mipmap/ic_launcher');

  static const String androidChannelId = 'Mofeed';

  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    onDidReceiveLocalNotification: onDidRecieveNoti,
  );

  static void onDidRecieveNoti(
      int? id, String? title, String? body, String? payload) {}

  static const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
}
