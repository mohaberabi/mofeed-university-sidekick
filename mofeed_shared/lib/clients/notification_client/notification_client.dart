import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

abstract class RemoteNotificationsClient {
  Future<String> getDeviceToken();

  Future<void> saveUserToken({
    required String uid,
    required String token,
  });

  Stream<RemoteMessage> handleForeground();

  Stream<RemoteMessage> onMessageOpenedApp();

  Future<void> subscribrToTopic(String topic);

  Future<void> unSubscribeFromTopic(String topic);
}

abstract class NotificationsException with EquatableMixin implements Exception {
  final Object? error;

  const NotificationsException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() =>
      kDebugMode ? "${super.toString()}${error.toString()}" : error.toString();
}

class SaveUserTokenFailure extends NotificationsException {
  const SaveUserTokenFailure(super.error);
}

class GetDeviceTokenFailure extends NotificationsException {
  const GetDeviceTokenFailure(super.error);
}

class GetTokenFailure extends NotificationsException {
  const GetTokenFailure(super.error);
}

class SubscribeToTopicFailure extends NotificationsException {
  const SubscribeToTopicFailure(super.error);
}

class UnSubscribeFromTopicFailure extends NotificationsException {
  const UnSubscribeFromTopicFailure(super.error);
}
