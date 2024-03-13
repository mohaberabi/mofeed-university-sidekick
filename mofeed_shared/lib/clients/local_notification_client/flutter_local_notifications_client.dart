import 'dart:io';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../constants/local_notificaiton_const.dart';
import 'local_notifications_client.dart';

class FlutterLocalNotificationClient implements LocalNotificationClient {
  final FlutterLocalNotificationsPlugin _noti;

  const FlutterLocalNotificationClient({
    required FlutterLocalNotificationsPlugin noti,
  }) : _noti = noti;

  @override
  Future<bool> checkPermissions() async {
    try {
      late bool? isEnabled;
      if (Platform.isIOS) {
        isEnabled = await _noti
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true);
      } else if (Platform.isAndroid) {
        isEnabled = await _noti
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      } else {
        isEnabled = false;
      }
      if (isEnabled == null) {
        return false;
      } else {
        return isEnabled;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> init() async {
    try {
      await _noti.initialize(LocalNotificaionConst.initializationSettings);
      final resolveAndroid = _noti.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      if (resolveAndroid != null) {
        await resolveAndroid.createNotificationChannel(
          const AndroidNotificationChannel(
              LocalNotificaionConst.androidChannelId,
              LocalNotificaionConst.androidChannelId),
        );
      }
    } catch (e, st) {
      Error.throwWithStackTrace(InitLocalNotificationFailure(e), st);
    }
  }

  @override
  Future<void> show({
    String title = ' ',
    String body = ' ',
    bool attached = false,
  }) async {
    try {
      final id = Random().nextInt(1000);
      await _noti.show(
          id, title, body, LocalNotificaionConst.defaultAppDetails);
    } catch (e, st) {
      Error.throwWithStackTrace(ShowLocalNotiticationFailure(e), st);
    }
  }
}
