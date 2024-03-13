import 'package:equatable/equatable.dart';

abstract class LocalNotificationClient {
  Future<void> show({String title = ' ', String body = ' '});

  Future<void> init();

  Future<bool> checkPermissions();
}

abstract final class LocalNotificationFailure
    with EquatableMixin
    implements Exception {
  final Object? error;

  const LocalNotificationFailure(this.error);

  @override
  List<Object?> get props => [error];
}

final class InitLocalNotificationFailure extends LocalNotificationFailure {
  const InitLocalNotificationFailure(super.error);
}

final class ShowLocalNotiticationFailure extends LocalNotificationFailure {
  const ShowLocalNotiticationFailure(super.error);
}

final class PeriodicallyShowFailure extends LocalNotificationFailure {
  const PeriodicallyShowFailure(super.error);
}

final class SchadueleShowFailure extends LocalNotificationFailure {
  const SchadueleShowFailure(super.error);
}

final class CancelAllFailure extends LocalNotificationFailure {
  const CancelAllFailure(super.error);
}

final class CancelNotificationFailure extends LocalNotificationFailure {
  const CancelNotificationFailure(super.error);
}
