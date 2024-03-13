import 'package:bloc/bloc.dart';
import 'package:mofeed_shared/data/fcm_repository.dart';
import 'package:mofeed_shared/helper/local_notitification_helper.dart';

import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final FcmRepository _fcmRepository;

  NotificationCubit({
    required FcmRepository fcmRepository,
  })  : _fcmRepository = fcmRepository,
        super(const NotificationState());

  void getAndSaveToken() async {
    try {
      await _fcmRepository.getAndSaveToken();
    } catch (e, st) {
      addError(e, st);
    }
  }

  void onMessageOpenedApp() =>
      _fcmRepository.onMessageOpenedApp().handleError((e, st) {
        addError(e, st);
      }).listen((event) {
        print('MESSSAGE OPEENED APP');
      });

  void onForegroundMessageRecieved() =>
      _fcmRepository.handleForeground().handleError((e, st) {
        addError(e, st);
      }).listen((message) {
        if (message.notification != null) {
          final noti = message.notification!;
          LocalNotificationHelper.show(
              title: noti.title ?? "", body: noti.body ?? "");
        }
      });
}
