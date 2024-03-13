import 'package:bloc/bloc.dart';
import 'package:food_court/repository/food_repository.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';
import 'package:mofeed_shared/utils/mixins/cubitEmitter.dart';

import 'foodcourt_state.dart';

class FoodCourtCubit extends Cubit<FoodCourtState> with CubitEmiiter {
  final UserFoodRepository _foodRepository;

  FoodCourtCubit({required UserFoodRepository foodRepository})
      : _foodRepository = foodRepository,
        super(const FoodCourtState());

  @override
  void emitInitial() => emit(state.copyWith(state: CubitState.initial));

  @override
  void emitDone() => emit(state.copyWith(state: CubitState.done));

  @override
  void emitLoading() => emit(state.copyWith(state: CubitState.loading));

  @override
  void emitError(String error, {StackTrace? st}) =>
      emit(state.copyWith(state: CubitState.error, error: error));

  void clearData() => emit(const FoodCourtState());

  void getRestaurantDetail(String id) async {
    emitLoading();
    final res = await _foodRepository.getRestaurantDetail(id);

    res.fold(
        (l) => emitError(l.error),
        (detail) => emit(
            state.copyWith(restaurantDetail: detail, state: CubitState.done)));
  }

  void getRestaruants() async {
    emitLoading();
    final res = await _foodRepository.getRestaurants();
    res.fold((l) => emitError(l.error), (restos) {
      emit(state.copyWith(restaurants: restos, state: CubitState.done));
    });
  }
}
