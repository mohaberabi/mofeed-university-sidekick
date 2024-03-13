import 'package:dartz/dartz.dart';
import 'package:mofeed_shared/clients/favorite_client/favorite_client.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/utils/error/failure.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

import '../../signup/data/user_storage.dart';
import 'favorite_storage.dart';

class FavoriteRepository {
  final FavoriteClient _favoriteClient;

  final FavoriteStorage _storage;

  final NetWorkInfo _netWorkInfo;
  final UserStorage _userStorage;

  const FavoriteRepository({
    required FavoriteStorage storage,
    required FavoriteClient favoriteClient,
    required NetWorkInfo netWorkInfo,
    required UserStorage userStorage,
  })  : _netWorkInfo = netWorkInfo,
        _storage = storage,
        _userStorage = userStorage,
        _favoriteClient = favoriteClient;

  FutureVoid addToFavorite({
    required String id,
    required FavoriteType type,
  }) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _userStorage.getUid();
        await _storage.saveFavorite(type: type, id: id);
        await _favoriteClient.addToFavorite(id: id, type: type, uid: uid!);
        return const Right(unit);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  Future<FoldFavorite> getFavoriteData() async {
    try {
      final savedFavorites = await _storage.getFavoriteData();
      if (savedFavorites.isEmpty) {
        final uid = await _userStorage.getUid();

        if (uid == null) {
          return const {};
        }
        final data = await _favoriteClient.getFavoriteData(
            foldFavorite: savedFavorites, uid: uid);
        await _storage.setFavorites(data);
        return data;
      } else {
        return savedFavorites;
      }
    } catch (e, st) {
      Error.throwWithStackTrace(e, st);
    }
  }

  FutureEither<List<Favorite>> getFavorites(FavoriteType type) async {
    try {
      final ids = await _storage.getFavoriteIds(type: type);
      print(ids);
      if (ids.isEmpty) {
        return const Right([]);
      }
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        late final List<Favorite> favorites;
        switch (type) {
          case FavoriteType.restarant:
            favorites =
                await _favoriteClient.getFavoriteRestaurants(ids: ids.toList());
            break;
          case FavoriteType.roomWanted:
          case FavoriteType.mateWanted:
            favorites =
                await _favoriteClient.getFavoriteSakans(ids: ids.toList());
            break;
        }
        return Right(favorites);
      }
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }
}
