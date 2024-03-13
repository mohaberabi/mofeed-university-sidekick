import 'package:bloc/bloc.dart';
import 'package:food_court/model/food_option.dart';
import 'package:food_court/model/option_group.dart';
import 'package:food_court/repository/food_repository.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';
import 'package:mofeed_shared/utils/mixins/cubitEmitter.dart';

import 'food_item_state.dart';

class FoodItemCubit extends Cubit<FoodItemState> with CubitEmiiter {
  final UserFoodRepository _foodRepository;

  FoodItemCubit({
    required UserFoodRepository foodRepository,
  })  : _foodRepository = foodRepository,
        super(const FoodItemState());

  void getItem({
    required String id,
    required String restaurantId,
  }) async {
    emitLoading();
    final res = await _foodRepository.getItemWithVariants(
        id: id, restaurantId: restaurantId);
    res.fold((l) => emitError(l.error), (r) {
      emit(state.copyWith(state: CubitState.done, itemWithVariants: r));
    });
  }

  void incQty() {
    if (state.readyToCart) {
      emit(state.copyWith(qty: state.qty + 1));
    }
  }

  void pikcupOption({
    required FoodOption value,
    required OptionGroup key,
  }) {
    final Map<OptionGroup, List<FoodOption>> currentMap =
        Map.from(state.options);
    final current = currentMap[key];
    if (current == null) {
      currentMap[key] = [value];
    } else if (current.contains(value)) {
      currentMap[key] = [...current]..remove(value);
    } else {
      if (key.min == 1) {
        currentMap[key] = [];
        currentMap[key] = [value];
      } else if (key.min > 1) {
        if (key.max > current.length) {
          currentMap[key] = [...current, value];
        }
      } else {
        currentMap[key] = [...current, value];
      }
    }
    emit(state.copyWith(options: currentMap));
  }

  void decQty() {
    if (state.qty > 1) {
      emit(state.copyWith(qty: state.qty - 1));
    }
  }

  @override
  void emitInitial() => emit(state.copyWith(state: CubitState.initial));

  @override
  void emitDone() => emit(state.copyWith(state: CubitState.done));

  @override
  void emitLoading() => emit(state.copyWith(state: CubitState.loading));

  @override
  void emitError(String error, {StackTrace? st}) =>
      emit(state.copyWith(state: CubitState.error, error: error));
}
