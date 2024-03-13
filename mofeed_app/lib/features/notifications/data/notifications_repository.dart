import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mofeduserpp/features/notifications/data/notification_storage.dart';
import 'package:mofeduserpp/features/university/data/university_storage.dart';
import 'package:mofeed_shared/clients/api/api_client.dart';
import 'package:mofeed_shared/clients/local_notification_client/local_notifications_client.dart';
import 'package:mofeed_shared/clients/notification_client/notification_client.dart';
import 'package:mofeed_shared/constants/common_params.dart';
import 'package:mofeed_shared/constants/fcm_const.dart';
import 'package:mofeed_shared/model/fcm_noti.dart';

import '../../signup/data/user_storage.dart';

class NotificationsRepository {
  const NotificationsRepository({
    required UserStorage storage,
    required UniversityStorage universityStorage,
    required NotificationStorage notificationStorage,
    required LocalNotificationClient localNotificationClient,
    required ApiClient apiClient,
    required RemoteNotificationsClient remoteNotificationsClient,
  })  : _storage = storage,
        _notificationStorage = notificationStorage,
        _localNotificationClient = localNotificationClient,
        _remoteNotificationsClient = remoteNotificationsClient,
        _apiClient = apiClient,
        _universityStorage = universityStorage;
  final UserStorage _storage;
  final UniversityStorage _universityStorage;
  final RemoteNotificationsClient _remoteNotificationsClient;
  final LocalNotificationClient _localNotificationClient;
  final NotificationStorage _notificationStorage;
  final ApiClient _apiClient;

  Future<void> getAndSaveToken() async {
    try {
      final uid = await _storage.getUid();
      if (uid == null) {
        return;
      }
      final token = await _remoteNotificationsClient.getDeviceToken();

      await _remoteNotificationsClient.saveUserToken(uid: uid, token: token);
    } catch (e, st) {
      Error.throwWithStackTrace(GetAndSaveTokenFailure(e), st);
    }
  }

  Future<void> sendRemotePush({
    required FcmNoti noti,
  }) async {
    try {
      final response =
          await _apiClient.post(FcmConst.legacyApiEndPoint, body: noti.toMap());
    } catch (e, st) {
      Error.throwWithStackTrace(SendRemotePushFailure(e), st);
    }
  }

  Future<void> subscribe() async {
    try {
      final university = await _universityStorage.getUniversity();
      if (university == null) {
        return;
      }
      final user = await _storage.getUser();
      if (user == null) {
        return;
      }
      final topic = user.local == CommonParams.ar
          ? university.topic.ar
          : university.topic.en;
      final messagingFuture =
          _remoteNotificationsClient.subscribrToTopic(topic);
      final storageFuture = _notificationStorage.save(topic);
      await Future.wait([
        messagingFuture,
        storageFuture,
      ]);
    } catch (e, st) {
      Error.throwWithStackTrace(SubscribeToTopicFailure(e), st);
    }
  }

  Future<void> unSubscribe() async {
    try {
      final cachedTopic = await _notificationStorage.getTopic();
      if (cachedTopic == null) {
        return;
      }
      final messagingFuture =
          _remoteNotificationsClient.unSubscribeFromTopic(cachedTopic);
      final storageFuture = _notificationStorage.remove();
      await Future.wait([
        messagingFuture,
        storageFuture,
      ]);
    } catch (e, st) {
      Error.throwWithStackTrace(UnSubscribeFromTopicFailure(e), st);
    }
  }

  Future<bool> isSubscribed() async {
    try {
      final topic = await _notificationStorage.getTopic();
      return topic != null;
    } catch (e, st) {
      Error.throwWithStackTrace(FetchSubscribtionResultFailure(e), st);
    }
  }

  Future<bool> isPermissionEnabeld() async {
    try {
      final enabled = await _localNotificationClient.checkPermissions();
      return enabled;
    } catch (e, st) {
      Error.throwWithStackTrace(FetchPermissionsResultFailure(e), st);
    }
  }

  Stream<RemoteMessage> onForegroundMessageRecieved() =>
      _remoteNotificationsClient.handleForeground();

  Stream<RemoteMessage> whenMessageOpensApp() =>
      _remoteNotificationsClient.onMessageOpenedApp();
}

abstract class NotificationsException with EquatableMixin implements Exception {
  final Object? error;

  const NotificationsException(this.error);

  @override
  List<Object?> get props => [error];
}

class GetAndSaveTokenFailure extends NotificationsException {
  const GetAndSaveTokenFailure(super.error);
}

class FetchSubscribtionResultFailure extends NotificationsException {
  const FetchSubscribtionResultFailure(super.error);
}

class FetchPermissionsResultFailure extends NotificationsException {
  const FetchPermissionsResultFailure(super.error);
}

class SendRemotePushFailure extends NotificationsException {
  const SendRemotePushFailure(super.error);
}
