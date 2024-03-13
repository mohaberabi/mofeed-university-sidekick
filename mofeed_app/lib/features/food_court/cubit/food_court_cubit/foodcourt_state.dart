import 'package:equatable/equatable.dart';
import 'package:food_court/model/restaurant_model.dart';
import 'package:food_court/utils/typdefs/typdefs.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

class FoodCourtState extends Equatable {
  final List<RestarantModel> restaurants;
  final RestaurantDetail? restaurantDetail;
  final CubitState state;
  final String error;

  const FoodCourtState({
    this.error = '',
    this.state = CubitState.initial,
    this.restaurants = const [],
    this.restaurantDetail,
  });

  @override
  List<Object?> get props => [
        state,
        error,
        restaurants,
        restaurantDetail,
      ];

  FoodCourtState copyWith({
    CubitState? state,
    String? error,
    List<RestarantModel>? restaurants,
    RestaurantDetail? restaurantDetail,
  }) {
    return FoodCourtState(
        restaurantDetail: restaurantDetail ?? this.restaurantDetail,
        restaurants: restaurants ?? this.restaurants,
        error: error ?? this.error,
        state: state ?? this.state);
  }

  @override
  String toString() => state.name;
}
