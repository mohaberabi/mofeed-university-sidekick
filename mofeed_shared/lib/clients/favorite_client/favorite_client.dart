import 'package:equatable/equatable.dart';
import 'package:food_court/model/restaurant_model.dart';
import 'package:sakan/model/sakan_model.dart';

import '../../model/favorite_model.dart';

typedef FoldFavorite = Map<String, Set<String>>;

abstract class FavoriteClient {
  Future<List<RestarantModel>> getFavoriteRestaurants({
    required List<String> ids,
  });

  Future<void> addToFavorite({
    required String id,
    required FavoriteType type,
    required String uid,
  });

  Future<FoldFavorite> getFavoriteData({
    required FoldFavorite foldFavorite,
    required String uid,
  });

  Future<List<Sakan>> getFavoriteSakans({
    required List<String> ids,
  });
}

abstract class FavoriteException with EquatableMixin implements Exception {
  final Object? error;

  const FavoriteException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => error.toString();
}

class AddToFavoriteFailure extends FavoriteException {
  const AddToFavoriteFailure(super.error);
}

class GetFavoriteDataFailure extends FavoriteException {
  const GetFavoriteDataFailure(super.error);
}

class GetFavoriteSakansFailure extends FavoriteException {
  const GetFavoriteSakansFailure(super.error);
}

class GetFavoriteRestaurantsFailure extends FavoriteException {
  const GetFavoriteRestaurantsFailure(super.error);
}
