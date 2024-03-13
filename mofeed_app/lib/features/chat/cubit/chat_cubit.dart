import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_shared/model/chat_model.dart';
import 'package:mofeed_shared/model/fcm_noti.dart';
import 'package:mofeed_shared/model/message_model.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';
import 'package:uuid/uuid.dart';
import '../../notifications/data/notifications_repository.dart';
import '../../signup/data/mofeed_auth_repository.dart';
import '../repository /chat_repository_impl.dart';
import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  final ChatRepository _chatRepository;
  final AuthRepository _authRepository;
  final NotificationsRepository _fcmRepository;

  ChatCubit({
    required ChatRepository chatRepository,
    required AuthRepository authRepository,
    required NotificationsRepository fcmRepository,
  })  : _chatRepository = chatRepository,
        _fcmRepository = fcmRepository,
        _authRepository = authRepository,
        super(const ChatStates()) {
    _chatsSubscribtion = _chatRepository.getChats().handleError((e, st) {
      addError(e, st);
    }).listen((chats) {
      emit(state.copyWith(chats: chats));
    });
  }

  late StreamSubscription _chaterSubscibtion;
  late StreamSubscription _messagesSubscribition;
  late StreamSubscription<List<ChatModel>> _chatsSubscribtion;

  Future<void> _sendPushOnMessage({
    required String lang,
    required String token,
    required MessageModel message,
    required String usrename,
    required String image,
  }) async {
    try {
      await _fcmRepository.sendRemotePush(
          noti: FcmNoti.toChat(
              username: usrename,
              lang: lang,
              token: token,
              message: message,
              image: image));
    } catch (e, st) {
      addError(e, st);
    }
  }

  void sendMessage({
    required String reciever,
    required String recieverLangCode,
    required String token,
  }) async {
    try {
      final user = await _authRepository.user.first;
      var id = const Uuid().v1();
      final MessageModel message = MessageModel(
        id: id,
        message: state.messageText,
        sender: user!.uId,
        issuedAt: DateTime.now(),
        reciever: reciever,
      );

      emit(state.copyWith(messages: [message, ...state.messages]));
      messageTextChanged('');
      await _chatRepository.sendMessage(message);
      if (token.isEmpty) {
        return;
      }
      await _sendPushOnMessage(
        lang: recieverLangCode,
        token: token,
        message: message,
        usrename: user.name,
        image: user.image,
      );
    } catch (e, st) {
      messageTextChanged('');
      addError(e, st);
    }
  }

  @override
  Future<void> close() async {
    _chaterSubscibtion.cancel();
    _messagesSubscribition.cancel();
    _chatsSubscribtion.cancel();
    super.close();
  }

  void getChatter(String uid) {
    _chaterSubscibtion = _chatRepository.getChatter(uid).handleError((e) {
      emit(state.copyWith(state: CubitState.error));
    }).listen((event) {
      emit(state.copyWith(chatter: event, state: CubitState.done));
    });
  }

  void messageTextChanged(String m) => emit(state.copyWith(messageText: m));

  void markMessagesSeen(MessageModel message) async {
    try {
      await _chatRepository.updateMessage(message: message);
    } catch (e, st) {
      addError(e, st);
    }
  }

  void getMessages(String uid) {
    _messagesSubscribition =
        _chatRepository.getMessages(uid).listen((messages) {
      emit(state.copyWith(messages: messages));
    });
  }
}
