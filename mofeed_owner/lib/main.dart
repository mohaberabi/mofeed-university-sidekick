import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mofeed_owner/app/app.dart';
import 'package:mofeed_owner/shared/sl/service_locator.dart';
import 'package:mofeed_shared/constants/bloc_observer.dart';
import 'package:mofeed_shared/helper/local_notitification_helper.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initSl();
  await FirebaseMessaging.instance
      .requestPermission(alert: true, sound: true, badge: true);
  await LocalNotificationHelper.init();
  runApp(const MofeedAccept());
}
