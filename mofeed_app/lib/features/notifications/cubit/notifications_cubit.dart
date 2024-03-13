import 'package:app_settings/app_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mofeduserpp/features/notifications/cubit/notification_state.dart';
import 'package:mofeed_shared/constants/common_params.dart';
import 'package:mofeed_shared/model/fcm_noti.dart';
import 'package:mofeed_shared/model/message_model.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';
import 'package:mofeed_shared/utils/mixins/cubitEmitter.dart';

import '../../chat/repository /chat_repository_impl.dart';
import '../data/notifications_repository.dart';

class NotificationCubit extends Cubit<NotificationState> with CubitEmiiter {
  final NotificationsRepository _notificationsRepository;
  final ChatRepository _chatRepository;

  NotificationCubit({
    required NotificationsRepository notificationsRepository,
    required ChatRepository chatRepository,
  })  : _notificationsRepository = notificationsRepository,
        _chatRepository = chatRepository,
        super(const NotificationState()) {
    _onForegroundMessageRecieved();
    _onMessageOpenedApp();
  }

  void getSubscribedTopic() async {
    try {
      emitLoading();
      final isEnabled = await _notificationsRepository.isPermissionEnabeld();
      if (!isEnabled) {
        await _notificationsRepository.unSubscribe();
      }
      final isSubscribed = await _notificationsRepository.isSubscribed();
      emit(state.copyWith(
          isSubscribed: isSubscribed,
          state: CubitState.done,
          status: NotificationStatus.initial,
          image: '',
          title: '',
          body: ''));
    } catch (e, st) {
      emitError(e.toString(), st: st);
    }
  }

  void subscribe() async {
    try {
      final isEnabled = await _notificationsRepository.isPermissionEnabeld();
      if (!isEnabled) {
        await AppSettings.openAppSettings();
        return;
      } else {
        if (state.isSubscribed) {
          await _notificationsRepository.unSubscribe();
        } else {
          await _notificationsRepository.subscribe();
        }
        getSubscribedTopic();
      }
    } catch (e, st) {
      emitError(e.toString(), st: st);
    }
  }

  void openAppSettings() async {
    try {
      await AppSettings.openAppSettings();
    } catch (e, st) {
      emitError(e.toString(), st: st);
    }
  }

  void getAndSaveToken() async {
    try {
      await _notificationsRepository.getAndSaveToken();
    } catch (e, st) {
      addError(e, st);
    }
  }

  void _onMessageOpenedApp() =>
      _notificationsRepository.whenMessageOpensApp().handleError((e, st) {
        addError(e, st);
      }).listen(_mapMessageToRoute);

  void _onForegroundMessageRecieved() => _notificationsRepository
          .onForegroundMessageRecieved()
          .handleError((e, st) {
        addError(e, st);
      }).listen((message) {
        if (message.notification != null) {
          _mapMessageToState(message);
          emit(state.copyWith(status: NotificationStatus.forground));
        }
      });

  void _mapMessageToState(RemoteMessage? remoteMessage) async {
    try {
      if (remoteMessage == null) {
        return;
      }
      final type = remoteMessage.data[CommonParams.type];
      if (type == null) {
        return;
      }
      final payLoad = type.toString().toNotificationPayLoad;
      switch (payLoad) {
        case NotificationPayLoad.chat:
          final message =
              MessageModel.fromJson(remoteMessage.data[CommonParams.data]);
          emit(
            state.copyWith(
                payload: message.sender,
                title: remoteMessage.data[CommonParams.username],
                image: remoteMessage.data[CommonParams.image],
                body: message.message,
                notificationRoute: AppRoutes.chatScreen),
          );
          await _chatRepository.updateMessage(
              message: message.copyWith(status: MessageStatusEnum.recieved));
        default:
          return;
      }
    } catch (e, st) {
      addError(e, st);
    }
  }

  void _mapMessageToRoute(RemoteMessage? message) {
    if (message == null) {
      return;
    }
    final payLoad = message.data[CommonParams.type] as String?;
    if (payLoad == null) {
      return;
    }
    emit(state.copyWith(status: NotificationStatus.messageOpenedApp));
    switch (payLoad.toNotificationPayLoad) {
      case NotificationPayLoad.chat:
        final chatMessage =
            MessageModel.fromJson(message.data[CommonParams.data]);
        emit(
          state.copyWith(
            notificationRoute: AppRoutes.chatScreen,
            payload: chatMessage.sender,
          ),
        );

      default:
        break;
    }
    emit(state.copyWith(status: NotificationStatus.initial));
  }

  @override
  void emitInitial() => emit(state.copyWith(state: CubitState.initial));

  @override
  void emitDone() => emit(state.copyWith(state: CubitState.done));

  @override
  void emitLoading() => emit(state.copyWith(state: CubitState.loading));

  @override
  void emitError(String error, {StackTrace? st}) {
    emit(state.copyWith(state: CubitState.error, error: error));
    addError(error, st);
  }
}
