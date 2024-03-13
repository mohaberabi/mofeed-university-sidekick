import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mofeed_shared/constants/fireabse_constants.dart';
import 'package:mofeed_shared/data/fcm_repository.dart';
import '../../auth/data/user_storage.dart';

class OwnerFcmRecpositoryImpl extends FcmRepository {
  OwnerFcmRecpositoryImpl({
    required AuthStorage storage,
    required super.client,
    required FirebaseMessaging messaging,
    required FirebaseFirestore firestore,
  })  : _storage = storage,
        _messaging = messaging,
        _firestore = firestore,
        super(firestore: firestore, messaging: messaging);
  final FirebaseFirestore _firestore;
  final FirebaseMessaging _messaging;
  final AuthStorage _storage;

  @override
  Future<void> getAndSaveToken() async {
    try {
      final uid = await _storage.getUid();
      if (uid == null) {
        return;
      }
      final token = await _messaging.getToken();
      if (token == null) {
        return;
      }
      await _firestore
          .collection(FirebaseConst.restaurants)
          .doc(uid)
          .update({"token": token});
    } catch (e, st) {
      Error.throwWithStackTrace(GetFcmTokenFailure(e), st);
    }
  }
}
