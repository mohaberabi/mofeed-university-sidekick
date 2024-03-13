import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/model/echo_model.dart';

import '../../model/user_model.dart';

abstract class EchoClient {
  Future<void> addEcho(EchoModel echo);

  Future<UserModel> reply({
    required String echoId,
    required EchoModel reply,
  });

  Future<void> deleteEcho({
    required String id,
    String? parentId,
  });

  Future<void> deleteReply({
    required String echoId,
    required String replyId,
  });

  Future<List<EchoModel>> getReplies({
    int limit = 10,
    String? lastDocId,
    required String echoId,
  });

  Future<List<EchoModel>> getEchos({
    int limit = 10,
    String? lastDocId,
    String? uid,
    required String universityId,
  });
}

abstract class EchoException with EquatableMixin implements Exception {
  final Object? error;

  const EchoException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => error.toString();
}

class AddEchoFailure extends EchoException {
  const AddEchoFailure(super.error);
}

class DeleteEchoreplyFailure extends EchoException {
  const DeleteEchoreplyFailure(super.error);
}

class ReplyEchoFailure extends EchoException {
  const ReplyEchoFailure(super.error);
}

class DeleteEchoFailure extends EchoException {
  const DeleteEchoFailure(super.error);
}

class GetRepliesFailure extends EchoException {
  const GetRepliesFailure(super.error);
}

class GetEchosFailure extends EchoException {
  const GetEchosFailure(super.error);
}
