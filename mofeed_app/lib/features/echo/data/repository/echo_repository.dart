import 'package:dartz/dartz.dart';
import 'package:mofeed_shared/clients/echo_client/echo_client.dart';

import 'package:mofeed_shared/data/network_info.dart';

import 'package:mofeed_shared/model/client_user_model.dart';
import 'package:mofeed_shared/model/echo_model.dart';
import 'package:mofeed_shared/utils/error/failure.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';
import '../../../university/data/university_storage.dart';

class EchoRepository {
  final EchoClient _echoClient;
  final UniversityStorage _universityStorage;
  final NetWorkInfo _netWorkInfo;

  const EchoRepository({
    required EchoClient echoClient,
    required UniversityStorage universityStorage,
    required NetWorkInfo netWorkInfo,
  })  : _universityStorage = universityStorage,
        _netWorkInfo = netWorkInfo,
        _echoClient = echoClient;

  FutureVoid addEcho(EchoModel echo) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        await _echoClient.addEcho(echo);
        return const Right(unit);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  FutureVoid deleteEcho({
    required String id,
    String? parentId,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        _echoClient.deleteEcho(id: id, parentId: parentId);
        return const Right(unit);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  FutureEither<List<EchoModel>> getReplies({
    int limit = 10,
    String? lastDocId,
    required String echoId,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final replies = await _echoClient.getReplies(
          echoId: echoId,
          limit: limit,
          lastDocId: lastDocId,
        );
        return Right(replies);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  FutureEither<ClientUser> reply({
    required String echoId,
    required EchoModel reply,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final repliedTo = await _echoClient.reply(echoId: echoId, reply: reply);
        return Right(repliedTo as ClientUser);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  FutureEither<List<EchoModel>> getEchos({
    int limit = 10,
    String? lastDocId,
    String? uid,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uni = await _universityStorage.getUniId();

        final echos = await _echoClient.getEchos(
          universityId: uni!,
          uid: uid,
          lastDocId: lastDocId,
          limit: limit,
        );
        return Right(echos);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  FutureVoid deleteReply({
    required String echoId,
    required String replyId,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        await _echoClient.deleteReply(echoId: echoId, replyId: replyId);
        return const Right(unit);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }
}
