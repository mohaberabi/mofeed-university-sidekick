import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mofeed_shared/clients/echo_client/echo_client.dart';
import 'package:mofeed_shared/model/echo_model.dart';
import 'package:mofeed_shared/model/user_model.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';
import 'package:mofeed_shared/utils/extensions/firestore_ext.dart';

import '../../constants/common_params.dart';
import '../../constants/fireabse_constants.dart';
import '../../model/client_user_model.dart';
import '../../constants/const_methods.dart';
import '../../utils/typdefs/typedefs.dart';

class FirebaseEchoClient implements EchoClient {
  final FirebaseFirestore _firestore;

  const FirebaseEchoClient({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<void> addEcho(EchoModel echo) async {
    try {
      await _echos.doc(echo.id).set(echo.toMap());
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(AddEchoFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<void> deleteEcho({
    required String id,
    String? parentId,
  }) async {
    try {
      late DocumentReference<MapJson> doc;
      if (parentId != null) {
        doc = _echos.doc(parentId).collection(FirebaseConst.replies).doc(id);
        await doc.delete();
        await _echos
            .doc(parentId)
            .update({CommonParams.replies: FieldValue.increment(-1)});
      } else {
        doc = _echos.doc(id);
        await doc.delete();
      }
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(DeleteEchoFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<void> deleteReply({
    required String echoId,
    required String replyId,
  }) async {
    try {
      await _echos
          .doc(echoId)
          .collection(FirebaseConst.replies)
          .doc(replyId)
          .delete();
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(DeleteEchoreplyFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<List<EchoModel>> getEchos({
    int limit = 10,
    String? lastDocId,
    String? uid,
    required String universityId,
  }) async {
    try {
      final echoQuery = _echos
          .where(CommonParams.uniId, isEqualTo: universityId)
          .where(CommonParams.uid, isEqualTo: uid)
          .orderBy(CommonParams.createdAt, descending: true)
          .limit(limit);
      final echos = await _firestore.paginate<EchoModel>(
          lastDocId: lastDocId,
          query: echoQuery,
          mapList: (echosMap) async {
            final data = <EchoModel>[];
            for (final map in echosMap) {
              final echo = EchoModel.fromJson(map);
              final uid = echo.uid;
              final userMap =
                  await _users.doc(uid).get().then((value) => value.data());
              late ClientUser user;
              user = userMap == null
                  ? ClientUser.anonymus
                  : ClientUser.fromMap(userMap);
              data.add(echo.copyWith(
                  username: user.userName, userImage: user.image));
            }
            return data;
          },
          lastDocColl: _echos);
      return echos;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetEchosFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<List<EchoModel>> getReplies({
    int limit = 10,
    String? lastDocId,
    required String echoId,
  }) async {
    try {
      final query = _echos
          .doc(echoId)
          .collection(FirebaseConst.replies)
          .orderBy(CommonParams.createdAt, descending: true)
          .limit(limit);
      final echoReplies = await _firestore.paginate<EchoModel>(
        lastDocId: lastDocId,
        query: query,
        lastDocColl: _echos.doc(echoId).collection(FirebaseConst.replies),
        mapList: (mapList) async {
          final replies = <EchoModel>[];
          for (final map in mapList) {
            final reply = EchoModel.fromJson(map);
            final uid = reply.uid;
            final user = await _users.doc(uid).get().then((value) =>
                value.data() == null
                    ? ClientUser.anonymus
                    : ClientUser.fromMap(value.data()!));
            replies.add(reply.copyWith(
              userImage: user.image,
              username: user.userName,
            ));
          }

          return replies;
        },
      );

      return echoReplies;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetRepliesFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<UserModel> reply({
    required String echoId,
    required EchoModel reply,
  }) async {
    try {
      await _echos
          .doc(echoId)
          .update({CommonParams.replies: FieldValue.increment(1)});
      await _echos
          .doc(echoId)
          .collection(FirebaseConst.replies)
          .doc(reply.id)
          .set(reply.toMap());
      final echo = await _echos
          .doc(echoId)
          .get()
          .then((value) => EchoModel.fromJson(value.data()!));
      final user = await _users
          .doc(echo.uid)
          .get()
          .then((value) => ClientUser.fromMap(value.data()!));
      return user;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(ReplyEchoFailure(e.mapCodeToError), st);
    }
  }

  CollectionReference<MapJson> get _echos =>
      _firestore.collection(FirebaseConst.echos);

  CollectionReference<MapJson> get _users =>
      _firestore.collection(FirebaseConst.users);
}
