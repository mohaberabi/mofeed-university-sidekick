import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_shared/data/storage_repository.dart';
import 'package:mofeed_shared/model/echo_model.dart';
import 'package:mofeed_shared/model/fcm_noti.dart';
import 'package:uuid/uuid.dart';
import '../../notifications/data/notifications_repository.dart';
import '../../signup/data/mofeed_auth_repository.dart';
import '../data/repository/echo_repository.dart';
import 'echo_states.dart';

class EchoCubit extends Cubit<EchoState> {
  EchoCubit({
    required EchoRepository echoRepository,
    required StorageRepository storageRepository,
    required NotificationsRepository fcmRepository,
    required AuthRepository authRepository,
  })  : _echoRepository = echoRepository,
        _fcmRepository = fcmRepository,
        _authRepository = authRepository,
        super(const EchoState());
  final NotificationsRepository _fcmRepository;
  final EchoRepository _echoRepository;
  final AuthRepository _authRepository;

  void clearReplies() => emit(state.copyWith(replies: {}));

  void getReplies({
    required String echoId,
  }) async {
    if (state.replies.isEmpty) {
      emitLoading();
    }
    final lastDocId =
        state.replies.isEmpty ? null : state.replies.values.last.id;
    final res =
        await _echoRepository.getReplies(echoId: echoId, lastDocId: lastDocId);
    res.fold(
      (l) => emitError(l.error, l.stackTrace),
      (r) => emit(
        state.copyWith(
          replies: {...state.replies, for (final repl in r) repl.id: repl},
          state: EchoStatus.populated,
        ),
      ),
    );
  }

  void _sendPushOnReply({
    required String lang,
    required String token,
    required String body,
    required String username,
  }) async {
    try {
      final noti = FcmNoti.toEchoReply(
          lang: lang, token: token, body: body, username: username);
      await _fcmRepository.sendRemotePush(noti: noti);
    } catch (e, st) {
      addError(e, st);
    }
  }

  void leaveReply({
    required String echoId,
  }) async {
    emitLoading();
    var id = const Uuid().v1();
    final user = await _authRepository.user.first;
    final reply = EchoModel(
      createdAt: DateTime.now(),
      uniId: user.uniId,
      isReply: true,
      id: id,
      echo: state.echo,
      allowChat: state.allowChats,
      username: user.userName,
      uid: user.uId,
      userImage: user.image,
    );
    final res = await _echoRepository.reply(echoId: echoId, reply: reply);
    res.fold((l) => emitError(l.error, l.stackTrace), (issuer) {
      emit(
        state.copyWith(
          echos: state.echos
            ..update(
                echoId, (value) => value.copyWith(replies: value.replies + 1)),
          state: EchoStatus.replied,
          replies: {reply.id: reply, ...state.replies},
          echo: '',
        ),
      );
      _sendPushOnReply(
        lang: issuer.local,
        token: issuer.token,
        body: reply.echo,
        username: user.userName,
      );
    });
  }

  void addEcho() async {
    emitLoading();
    final user = await _authRepository.user.first;
    var id = const Uuid().v1();
    final echo = EchoModel(
      userImage: user.image ?? "",
      uid: user.uId,
      createdAt: DateTime.now(),
      uniId: user.uniId,
      id: id,
      echo: state.echo,
      allowChat: state.allowChats,
      username: '${user.name} ${user.lastname}',
    );
    final res = await _echoRepository.addEcho(echo);
    res.fold(
      (l) => emitError(l.error, l.stackTrace),
      (r) => emit(
        state.copyWith(
            echos: {echo.id: echo, ...state.echos},
            state: EchoStatus.posted,
            echo: ''),
      ),
    );
  }

  void echoChanged(String val) => emit(state.copyWith(echo: val));

  void allowChatChanged() =>
      emit(state.copyWith(allowChats: !state.allowChats));

  void getAllEchos({
    bool clearBefore = false,
    bool getMine = false,
  }) async {
    if (clearBefore) {
      emit(const EchoState());
    }
    if (state.echos.isEmpty) {
      emitLoading();
    }

    final user = await _authRepository.user.first;
    final res = await _echoRepository.getEchos(
        uid: getMine ? user.uId : null,
        lastDocId:
            state.echos.isEmpty ? null : state.echos.values.toList().last.id);
    res.fold(
      (l) => emitError(l.error),
      (echos) {
        emit(
          state.copyWith(
            echos: {...state.echos, for (var e in echos) e.id: e},
            state: EchoStatus.populated,
          ),
        );
      },
    );
  }

  void deleteEcho({
    required String id,
    String? parentId,
  }) async {
    emitLoading();
    final res = await _echoRepository.deleteEcho(id: id, parentId: parentId);
    res.fold((l) => emitError(l.error, l.stackTrace), (r) {
      if (parentId != null) {
        emit(state.copyWith(replies: state.replies..remove(id)));
      } else {
        emit(state.copyWith(echos: state.echos..remove(id)));
      }
      emit(state.copyWith(state: EchoStatus.deleted));
    });
  }

  void clearFormFields() => emit(state.copyWith(echo: "", allowChats: false));

  void emitLoading() => emit(state.copyWith(state: EchoStatus.loading));

  void emitError(String error, [StackTrace? st]) {
    emit(state.copyWith(state: EchoStatus.error, error: error));
    addError(error, st);
  }
}
