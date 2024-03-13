import 'package:mofeed_shared/clients/chat_client/chat_client.dart';
import 'package:mofeed_shared/model/chat_model.dart';
import 'package:mofeed_shared/model/client_user_model.dart';
import 'package:mofeed_shared/model/message_model.dart';

import '../../signup/data/user_storage.dart';

class ChatRepository {
  final UserStorage _userStorage;

  final ChatClient _chatClient;

  const ChatRepository({
    required ChatClient chatClient,
    required UserStorage userStorage,
  })  : _chatClient = chatClient,
        _userStorage = userStorage;

  Stream<List<ChatModel>> getChats() {
    return Stream.fromFuture(_userStorage.getUid()).asyncExpand((uid) {
      return uid == null ? Stream.value([]) : _chatClient.getChats(uid);
    });
  }

  Stream<ClientUser> getChatter(String uid) {
    return _chatClient.getChatter(uid).map((event) => event as ClientUser);
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return Stream.fromFuture(_userStorage.getUid()).asyncExpand((uid) {
      return uid == null
          ? Stream.value([])
          : _chatClient.geMessages(uid: uid, chatId: chatId);
    });
  }

  Future<void> sendMessage(MessageModel message) async {
    try {
      await _chatClient.sendMessage(message);
    } catch (e, st) {
      Error.throwWithStackTrace(e.toString(), st);
    }
  }

  Future<void> updateMessage({
    required MessageModel message,
  }) async {
    try {
      await _chatClient.updateMessage(message);
    } catch (e, st) {
      Error.throwWithStackTrace(e.toString(), st);
    }
  }
}
