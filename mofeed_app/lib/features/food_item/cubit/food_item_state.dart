import 'package:equatable/equatable.dart';
import 'package:food_court/model/food_option.dart';
import 'package:food_court/model/option_group.dart';
import 'package:food_court/utils/typdefs/typdefs.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

class FoodItemState extends Equatable {
  final CubitState state;
  final ItemWithVariants? itemWithVariants;
  final String error;
  final int qty;
  final Map<OptionGroup, List<FoodOption>> options;

  const FoodItemState({
    this.error = '',
    this.itemWithVariants,
    this.state = CubitState.initial,
    this.qty = 1,
    this.options = const {},
  });

  FoodItemState copyWith({
    CubitState? state,
    ItemWithVariants? itemWithVariants,
    String? error,
    int? qty,
    Map<OptionGroup, List<FoodOption>>? options,
  }) {
    return FoodItemState(
      options: options ?? this.options,
      qty: qty ?? this.qty,
      state: state ?? this.state,
      itemWithVariants: itemWithVariants ?? this.itemWithVariants,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => state.name;


  dynamic get buttonString {
    if (itemWithVariants == null) {
      return "";
    } else {
      final item = itemWithVariants!.first;
      if (item.isVariable) {
        return readyToCart ? wholePrice : "Price on Selection";
      } else {
        return item.price;
      }
    }
  }

  List<FoodOption> get optionsFolded {
    final List<FoodOption> folded = [];
    for (final key in options.keys) {
      if (options[key] != null) {
        folded.addAll(options[key]!);
      }
    }
    return folded;
  }

  bool get readyToCart {
    if (itemWithVariants == null) {
      return false;
    } else {
      final item = itemWithVariants!.first;
      if (item.isVariable) {
        return isVariableItemValid;
      } else {
        return true;
      }
    }
  }

  double get wholePrice {
    if (itemWithVariants == null) {
      return 0.0;
    } else {
      final item = itemWithVariants!.first;
      if (item.isVariable) {
        return foldOptionsPrice * qty;
      } else {
        return item.price * qty;
      }
    }
  }

  double get foldOptionsPrice =>
      optionsFolded.fold(
          0, (previousValue, element) => previousValue + element.price);

  @override
  List<Object?> get props =>
      [
        state,
        itemWithVariants,
        error,
        options,
        qty,
      ];

  bool get isVariableItemValid {
    if (options.isEmpty) {
      return false;
    } else {
      for (final key in itemWithVariants!.second) {
        if (key.isRequired && options[key] == null) {
          return false;
        }
        if (key.isRequired && options[key]!.length != key.min) {
          return false;
        }
        if (key.isRequired && (options[key] == null || options[key]!.isEmpty)) {
          return false;
        }
      }
      return true;
    }
  }
}
