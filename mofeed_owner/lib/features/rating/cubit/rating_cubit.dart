import 'package:bloc/bloc.dart';
import 'package:food_court/repository/rating_repository.dart';
import 'package:mofeed_owner/features/rating/cubit/rating_state.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';
import 'package:mofeed_shared/utils/mixins/cubitEmitter.dart';

class RatingCubit extends Cubit<RatingState> with CubitEmiiter {
  RatingCubit({required RatingRepository ratingRepository})
      : _ratingRepository = ratingRepository,
        super(const RatingState());

  final RatingRepository _ratingRepository;

  void clear() => emit(const RatingState());

  void getRatings({bool loadBefore = true}) async {
    if (loadBefore) {
      emitLoading();
    }
    final res = await _ratingRepository.getRatings(
      lastDocId: state.ratings.isEmpty ? null : state.ratings.last.id,
    );

    res.fold((l) => emitError(l.error, st: l.stackTrace), (ratings) {
      emit(state.copyWith(
          ratings: [...state.ratings, ...ratings], state: CubitState.done));
    });
  }

  @override
  void emitDone() => emit(state.copyWith(state: CubitState.done));

  @override
  void emitError(String error, {StackTrace? st}) {
    emit(state.copyWith(state: CubitState.done));
    addError(error, st);
  }

  @override
  void emitInitial() => emit(state.copyWith(state: CubitState.initial));

  @override
  void emitLoading() => emit(state.copyWith(state: CubitState.loading));
}
