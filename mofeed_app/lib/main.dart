import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'app/app.dart';
import 'bootstrap/bootstrap.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  await bootStrap(
    const MofeedApp(),
    firebaseBgHandeler: _firebaseMessagingBackgroundHandler,
  );
}
