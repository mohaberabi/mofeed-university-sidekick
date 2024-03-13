import 'package:equatable/equatable.dart';

import 'package:mofeed_shared/clients/favorite_client/favorite_client.dart';
import 'package:mofeed_shared/model/favorite_model.dart';

enum FavoriteStatus {
  initial,
  loading,
  populated,
  addedRemovedFavorite,
  loadingData,
  error;

  bool get isInitial => this == FavoriteStatus.initial;

  bool get isLoading => this == FavoriteStatus.loading;

  bool get isPopulated => this == FavoriteStatus.populated;

  bool get isAddedRemovedFavorite =>
      this == FavoriteStatus.addedRemovedFavorite;

  bool get isLoadingData => this == FavoriteStatus.loadingData;

  bool get isError => this == FavoriteStatus.error;
}

class FavoriteState extends Equatable {
  final String error;
  final FavoriteType type;
  final FoldFavorite favoriteData;
  final List<Favorite> favorites;

  final FavoriteStatus state;

  const FavoriteState({
    this.favoriteData = const {},
    this.favorites = const [],
    this.error = '',
    this.state = FavoriteStatus.initial,
    this.type = FavoriteType.restarant,
  });

  @override
  List<Object?> get props => [
        error,
        favoriteData,
        favorites,
        state,
        type,
      ];

  FavoriteState copyWith({
    String? error,
    FoldFavorite? favoriteData,
    List<Favorite>? favorites,
    FavoriteStatus? state,
    FavoriteType? type,
  }) {
    return FavoriteState(
      type: type ?? this.type,
      error: error ?? this.error,
      favoriteData: favoriteData ?? this.favoriteData,
      favorites: favorites ?? this.favorites,
      state: state ?? this.state,
    );
  }

  bool isFavorite(String favType, String id) => favoriteData[favType] == null
      ? false
      : favoriteData[favType]!.contains(id);

  @override
  String toString() => state.name;
}
