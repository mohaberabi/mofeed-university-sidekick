import 'package:bloc/bloc.dart';
import 'package:food_court/repository/restaurant_repository.dart';
import 'package:food_court/utils/enums/cuisine.dart';
import 'package:mofeed_owner/features/restraurant/cubit/restarant_state.dart';
import 'package:mofeed_shared/utils/enums/restarant.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';
import 'package:mofeed_shared/utils/mixins/cubitEmitter.dart';

class RestarantCubit extends Cubit<RestarantState> with CubitEmiiter {
  final RestaurntRepository _restaurntRepository;

  RestarantCubit({
    required RestaurntRepository restaurntRepository,
  })  : _restaurntRepository = restaurntRepository,
        super(const RestarantState());

  void formChanged({
    String? ar,
    String? en,
    bool? facultyHandover,
    int? minPickTime,
    Cuisine? cuisine,
  }) {
    List<Cuisine> cusines = state.restarant.cuisines;
    if (cuisine != null) {
      cusines.add(cuisine);
    }
    emit(state.copyWith(
        restarant: state.restarant.copyWith(
      cuisines: cusines,
      name: {
        "ar": ar ?? state.restarant.name['ar'],
        "en": en ?? state.restarant.name['en'],
      },
      offersDelivery: facultyHandover,
      minPickupTime: minPickTime,
    )));
  }

  void changeAvailabilty(RestarantStateEnum status) async {
    emit(state.copyWith(restarant: state.restarant.copyWith(state: status)));
    updateRestarant();
  }

  void updateRestarant() async {
    emitLoading();
    final res = await _restaurntRepository.updateResturant(state.restarant);
    res.fold((l) => emitError(l.error),
        (r) => emit(state.copyWith(state: CubitState.done)));
  }

  void getRestuanrt() async {
    emitLoading();
    final res = await _restaurntRepository.getRestaurant();
    res.fold((l) => emitError(l.error),
        (r) => emit(state.copyWith(restarant: r, state: CubitState.done)));
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
