import 'package:bloc/bloc.dart';
import 'package:food_court/repository/rating_repository.dart';
import 'package:mofeduserpp/features/rating/cubit/rating_state.dart';
import 'package:mofeed_shared/model/rating_model.dart';
import 'package:uuid/uuid.dart';

import '../../signup/data/mofeed_auth_repository.dart';

class RatingCubit extends Cubit<RatingState> {
  final UserRatingRepository _ratingRepository;
  final AuthRepository _authRepository;

  RatingCubit({
    required UserRatingRepository ratingRepository,
    required AuthRepository authRepository,
  })  : _ratingRepository = ratingRepository,
        _authRepository = authRepository,
        super(const RatingState());

  void getRatings({
    required String restaurantId,
    bool loadBefore = true,
  }) async {
    if (loadBefore) {
      emit(state.copyWith(status: RatingStatus.loading));
    }
    final res = await _ratingRepository.getRatings(
        restaurantId: restaurantId,
        lastDocId: state.ratings.isEmpty ? null : state.ratings.last.id);
    res.fold(
        (l) => emit(state.copyWith(status: RatingStatus.error, error: l.error)),
        (r) => emit(state.copyWith(
            status: RatingStatus.populated,
            ratings: [...state.ratings, ...r])));
  }

  void ratingValueChange(int val) => emit(state.copyWith(value: val));

  void ratingTextChanged(String val) => emit(state.copyWith(rate: val));

  void rate({required String restaurantId, required String orderId}) async {
    final user = await _authRepository.user.first;
    emit(state.copyWith(status: RatingStatus.loading));
    var id = const Uuid().v1();
    final rating = RatingModel(
      value: state.value + 1,
      text: state.rate,
      id: id,
      createdAt: DateTime.now(),
      uid: user.uId,
      username: user.userName,
    );
    final res = await _ratingRepository.rate(
        orderId: orderId, restaurantId: restaurantId, rating: rating);
    res.fold(
        (l) => emit(state.copyWith(status: RatingStatus.error, error: l.error)),
        (r) {
      emit(state.copyWith(status: RatingStatus.rated));
    });
  }
}
