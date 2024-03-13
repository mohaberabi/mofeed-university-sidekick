import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/model/chat_model.dart';
import 'package:mofeed_shared/model/client_user_model.dart';
import 'package:mofeed_shared/model/message_model.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

class ChatStates extends Equatable {
  final String error;
  final CubitState state;
  final ClientUser? chatter;
  final List<ChatModel> chats;
  final List<MessageModel> messages;
  final String messageText;

  const ChatStates({
    this.error = '',
    this.chatter,
    this.messages = const [],
    this.chats = const [],
    this.state = CubitState.initial,
    this.messageText = '',
  });

  @override
  List<Object?> get props => [
        error,
        state,
        chatter,
        chats,
        messages,
        messageText,
      ];

  ChatStates copyWith({
    String? error,
    CubitState? state,
    ClientUser? chatter,
    List<ChatModel>? chats,
    List<MessageModel>? messages,
    String? messageText,
  }) {
    return ChatStates(
      messageText: messageText ?? this.messageText,
      error: error ?? this.error,
      state: state ?? this.state,
      chats: chats ?? this.chats,
      messages: messages ?? this.messages,
      chatter: chatter ?? this.chatter,
    );
  }

  @override
  String toString() => state.name;

  bool get canSend => messageText.trim().isNotEmpty;

  bool get hasUnread => chats.any((element) => !element.read);
}
