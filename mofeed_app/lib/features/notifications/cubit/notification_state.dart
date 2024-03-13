import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

enum NotificationStatus {
  initial,
  messageOpenedApp,
  forground;
}

class NotificationState extends Equatable {
  final String notificationRoute;
  final String error;
  final bool isSubscribed;
  final CubitState state;
  final NotificationStatus status;
  final String title;

  final String image;
  final String body;

  final String payload;

  @override
  List<Object?> get props => [
        notificationRoute,
        error,
        payload,
        isSubscribed,
        state,
        status,
        title,
        body,
        image,
      ];

  const NotificationState({
    this.notificationRoute = '',
    this.error = '',
    this.payload = '',
    this.isSubscribed = false,
    this.state = CubitState.initial,
    this.status = NotificationStatus.initial,
    this.title = '',
    this.image = '',
    this.body = '',
  });

  NotificationState copyWith({
    String? notificationRoute,
    String? error,
    String? payload,
    bool? isSubscribed,
    CubitState? state,
    NotificationStatus? status,
    String? title,
    String? body,
    String? image,
  }) {
    return NotificationState(
      status: status ?? this.status,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      notificationRoute: notificationRoute ?? this.notificationRoute,
      error: error ?? this.error,
      payload: payload ?? this.payload,
      state: state ?? this.state,
      title: title ?? this.title,
      body: body ?? this.body,
      image: image ?? this.image,
    );
  }
}
