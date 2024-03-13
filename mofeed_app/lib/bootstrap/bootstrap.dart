import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:mofeed_shared/constants/bloc_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/service_lcoator.dart';
import 'firebase_development_options.dart';

Future<void> bootStrap(
  Widget app, {
  required Future<void> Function(RemoteMessage) firebaseBgHandeler,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseDevelopmentOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseBgHandeler);
  final prefs = await SharedPreferences.getInstance();
  ServiceLocator.init(prefs: prefs);
  await FirebaseMessaging.instance
      .requestPermission(alert: true, badge: true, sound: true);
  Bloc.observer = MyBlocObserver();
  runApp(app);
}
