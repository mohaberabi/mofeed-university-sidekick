import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mofeed_shared/clients/chat_client/chat_client.dart';
import 'package:mofeed_shared/model/chat_model.dart';
import 'package:mofeed_shared/model/message_model.dart';
import 'package:mofeed_shared/model/user_model.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';

import '../../constants/common_params.dart';
import '../../constants/fireabse_constants.dart';
import '../../model/client_user_model.dart';
import '../../utils/typdefs/typedefs.dart';

class FirebaseChatClient implements ChatClient {
  final FirebaseFirestore _firestore;

  const FirebaseChatClient({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Stream<List<MessageModel>> geMessages({
    required String uid,
    required String chatId,
  }) {
    final messages = _messages(uid: uid, chatId: chatId)
        .orderBy(CommonParams.issuedAt, descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => MessageModel.fromMap(e.data())).toList();
    });
    return messages;
  }

  @override
  Stream<List<ChatModel>> getChats(String uid) {
    return _chats(uid).snapshots().asyncMap((event) async {
      final List<ChatModel> chats = [];
      for (final doc in event.docs) {
        final chat = ChatModel.fromMap(doc.data());
        final userData = await _users.doc(chat.recieverId).get();
        final user = ClientUser.fromMap(userData.data()!);
        chats.add(chat.copyWith(image: user.image, username: user.userName));
      }
      return chats;
    });
  }

  @override
  Stream<UserModel> getChatter(String uid) {
    final chatter = _users.doc(uid).snapshots().map((event) =>
        event.data() == null
            ? ClientUser.anonymus
            : ClientUser.fromMap(event.data()!));
    return chatter;
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    try {
      final senderId = message.sender;
      await _startChat(
        recieverId: message.reciever,
        uid: message.sender,
      );
      final atSender = _messages(uid: senderId, chatId: message.reciever)
          .doc(message.id)
          .set(message.copyWith(status: MessageStatusEnum.sent).toMap());
      final atReciever = _messages(uid: message.reciever, chatId: senderId)
          .doc(message.id)
          .set(message.copyWith(status: MessageStatusEnum.sent).toMap());
      final addLastMessageAtBoth = _addLastMessage(
        message: message.copyWith(status: MessageStatusEnum.sent),
        uid: message.sender,
      );
      await Future.wait([
        atSender,
        atReciever,
        addLastMessageAtBoth,
      ]);
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(SendMessageFailure(e.mapCodeToError), st);
    }
  }

  Future<void> _startChat({
    required String recieverId,
    required String uid,
  }) async {
    try {
      final chatDoc = await _chats(uid).doc(recieverId).get();
      if (chatDoc.exists) {
        return;
      }
      final reciever = await _users
          .doc(recieverId)
          .get()
          .then((value) => ClientUser.fromMap(value.data()!));
      final chat = ChatModel(
        recieverId: reciever.uId,
        lastMessage: "",
        image: reciever.image,
        username: reciever.userName,
        sentAt: DateTime.now(),
        lastMessageSender: uid,
      );
      final atSender = _chats(uid).doc(chat.recieverId).set(chat.toMap());
      final atReciever = _chats(recieverId)
          .doc(uid)
          .set(chat.copyWith(recieverId: uid).toMap());
      await Future.wait([atSender, atReciever]);
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<void> updateMessage(MessageModel message) async {
    try {
      final atSender = _messages(uid: message.sender, chatId: message.reciever)
          .doc(message.id)
          .set(message.toMap());
      final atReciever =
          _messages(uid: message.reciever, chatId: message.sender)
              .doc(message.id)
              .set(message.toMap());
      final lastMessagesMap = <String, dynamic>{
        CommonParams.status: message.status.name
      };
      final atSenderLastMessage =
          _chats(message.sender).doc(message.reciever).update(lastMessagesMap);
      final atRecieverLastMessage =
          _chats(message.reciever).doc(message.sender).update(lastMessagesMap);
      await Future.wait(
          [atSender, atReciever, atSenderLastMessage, atRecieverLastMessage]);
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(UpdateMessageFailure(e.mapCodeToError), st);
    }
  }

  Future<void> _addLastMessage({
    required String uid,
    required MessageModel message,
  }) async {
    try {
      final messageMap = {
        CommonParams.lastMessage: message.message,
        CommonParams.sentAt: DateTime.now().millisecondsSinceEpoch,
        CommonParams.status: MessageStatusEnum.sent.name,
        CommonParams.lastMessageSender: uid,
      };
      final atSender =
          _chats(message.sender).doc(message.reciever).update(messageMap);
      final atReciever =
          _chats(message.reciever).doc(message.sender).update(messageMap);
      await Future.wait([atSender, atReciever]);
    } on FirebaseException {
      rethrow;
    }
  }

  CollectionReference<MapJson> _messages({
    required String uid,
    required String chatId,
  }) =>
      _chats(uid).doc(chatId).collection(FirebaseConst.messages);

  CollectionReference<MapJson> get _users =>
      _firestore.collection(FirebaseConst.users);

  CollectionReference<MapJson> _chats(String uid) =>
      _users.doc(uid).collection(FirebaseConst.chats);
}
