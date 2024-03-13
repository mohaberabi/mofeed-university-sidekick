import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/model/chat_model.dart';
import 'package:mofeed_shared/model/message_model.dart';
import 'package:mofeed_shared/model/user_model.dart';

abstract class ChatClient {
  Future<void> sendMessage(MessageModel message);

  Stream<List<MessageModel>> geMessages({
    required String uid,
    required String chatId,
  });

  Future<void> updateMessage(MessageModel message);

  Stream<UserModel> getChatter(String uid);

  Stream<List<ChatModel>> getChats(String uid);
}

class SendMessageFailure extends ChatException {
  const SendMessageFailure(super.error);
}

class UpdateMessageFailure extends ChatException {
  const UpdateMessageFailure(super.error);
}

abstract class ChatException with EquatableMixin implements Exception {
  final Object? error;

  const ChatException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => error.toString();
}
