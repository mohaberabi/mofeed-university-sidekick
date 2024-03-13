import 'package:equatable/equatable.dart';
import 'package:food_court/model/category_model.dart';
import 'package:food_court/model/item_model.dart';
import 'package:food_court/model/option_group.dart';
import 'package:food_court/model/restaurant_model.dart';

abstract class FoodCourtClient {
  Future<RestarantModel> getRestaurant(String restId);

  Future<ItemModel> getItem({
    required String id,
    required String restId,
  });

  Future<List<CategoryModel>> getCategories(String restId);

  Future<List<RestarantModel>> getRestaurnats({
    int limit = 10,
    required String uniId,
  });

  Future<List<OptionGroup>> getItemOpions({
    required restId,
    required itemId,
  });

  Future<List<ItemModel>> getItems(String restId);
}

abstract class FoodCourtException with EquatableMixin implements Exception {
  final Object? error;

  const FoodCourtException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => error.toString();
}

class GetRestaruantFailure extends FoodCourtException {
  const GetRestaruantFailure(super.error);
}

class GetCategoriesFailure extends FoodCourtException {
  const GetCategoriesFailure(super.error);
}

class GetRestaurantsFailure extends FoodCourtException {
  const GetRestaurantsFailure(super.error);
}

class GetItemOptionsFailure extends FoodCourtException {
  const GetItemOptionsFailure(super.error);
}

class GetItemsFailure extends FoodCourtException {
  const GetItemsFailure(super.error);
}

class GetOneItemFailure extends FoodCourtException {
  const GetOneItemFailure(super.error);
}
