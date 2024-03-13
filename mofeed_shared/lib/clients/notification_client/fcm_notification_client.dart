import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';

import '../../constants/common_params.dart';
import '../../constants/fireabse_constants.dart';
import 'notification_client.dart';

class FcmNotificationClient implements RemoteNotificationsClient {
  final FirebaseMessaging _messaging;
  final FirebaseFirestore _firestore;

  const FcmNotificationClient({
    required FirebaseMessaging messaging,
    required FirebaseFirestore firestore,
  })  : _messaging = messaging,
        _firestore = firestore;

  @override
  Future<String> getDeviceToken() async {
    try {
      final token = await _messaging.getToken();
      if (token == null) {
        throw const GetDeviceTokenFailure("Unable to fetch token");
      }
      return token;
    } catch (e, st) {
      Error.throwWithStackTrace(GetDeviceTokenFailure(e), st);
    }
  }

  @override
  Future<void> saveUserToken({
    required String uid,
    required String token,
  }) async {
    try {
      await _firestore
          .collection(FirebaseConst.users)
          .doc(uid)
          .update({CommonParams.token: token});
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetDeviceTokenFailure(e.mapCodeToError), st);
    }
  }

  @override
  Stream<RemoteMessage> handleForeground() => FirebaseMessaging.onMessage;

  @override
  Stream<RemoteMessage> onMessageOpenedApp() =>
      FirebaseMessaging.onMessageOpenedApp;

  @override
  Future<void> subscribrToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
    } catch (e, st) {
      Error.throwWithStackTrace(SubscribeToTopicFailure(e), st);
    }
  }

  @override
  Future<void> unSubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
    } catch (e, st) {
      Error.throwWithStackTrace(UnSubscribeFromTopicFailure(e), st);
    }
  }
}
