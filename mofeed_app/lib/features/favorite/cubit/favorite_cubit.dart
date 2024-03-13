import 'package:bloc/bloc.dart';
import 'package:mofeduserpp/features/favorite/cubit/favorite_state.dart';
import 'package:mofeduserpp/features/favorite/data/favorite_repository.dart';
import 'package:mofeed_shared/model/favorite_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository _favoriteRepository;

  FavoriteCubit({
    required FavoriteRepository favoriteRepository,
  })  : _favoriteRepository = favoriteRepository,
        super(const FavoriteState());

  void dispose() =>
      emit(state.copyWith(favorites: [], state: FavoriteStatus.initial));

  void addToFavorite({
    required FavoriteType type,
    required String id,
  }) async {
    emit(state.copyWith(state: FavoriteStatus.loading));
    final res = await _favoriteRepository.addToFavorite(id: id, type: type);
    res.fold((l) {
      addError(l.error, l.stackTrace);
    }, (r) {
      emit(state.copyWith(state: FavoriteStatus.addedRemovedFavorite));
      getFavorites(loadBefore: false);
      getFavoriteData();
    });
  }

  void typeChanged(FavoriteType type) {
    if (type == state.type) {
      return;
    }
    emit(state.copyWith(type: type));
    getFavorites();
  }

  void getFavorites({
    bool loadBefore = true,
  }) async {
    if (loadBefore) {
      emit(state.copyWith(state: FavoriteStatus.loadingData, favorites: []));
    }
    final res = await _favoriteRepository.getFavorites(state.type);
    res.fold(
        (l) => emitError(l.error, st: l.stackTrace),
        (fav) => emit(
            state.copyWith(state: FavoriteStatus.populated, favorites: fav)));
  }

  void getFavoriteData() async {
    try {
      final map = await _favoriteRepository.getFavoriteData();
      emit(state.copyWith(favoriteData: map));
    } catch (e, st) {
      addError(e, st);
    }
  }

  void emitError(String error, {StackTrace? st}) =>
      emit(state.copyWith(state: FavoriteStatus.error, error: error));

  void emitInitial() => emit(state.copyWith(state: FavoriteStatus.initial));

  void emitLoading() => emit(state.copyWith(state: FavoriteStatus.loading));
}
