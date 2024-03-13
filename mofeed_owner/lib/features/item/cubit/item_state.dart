import 'package:equatable/equatable.dart';
import 'package:food_court/model/category_model.dart';
import 'package:food_court/model/item_model.dart';
import 'package:food_court/model/option_group.dart';

enum ItemStatus {
  initial,
  loading,
  error,
  populated,
  added,
  deleted;
}

class ItemState extends Equatable {
  final String error;
  final ItemStatus status;

  final Map<String, OptionGroup> optionsMap;

  final ItemModel item;

  final List<ItemModel> items;
  final CategoryModel category;

  const ItemState({
    this.error = '',
    this.status = ItemStatus.initial,
    this.items = const [],
    this.item = ItemModel.empty,
    this.optionsMap = const {},
    this.category = CategoryModel.empty,
  });

  ItemState copyWith({
    String? error,
    ItemStatus? status,
    ItemModel? item,
    List<ItemModel>? items,
    Map<String, OptionGroup>? optionsMap,
    CategoryModel?category,
  }) {
    return ItemState(
      error: error ?? this.error,
      status: status ?? this.status,
      item: item ?? this.item,
      items: items ?? this.items,
      optionsMap: optionsMap ?? this.optionsMap,
      category: category ?? this.category,
    );
  }


  bool get readyToAdd =>
      item.name.isNotEmpty && item.price > 0 && item.categoryId.isNotEmpty;

  @override
  List<Object?> get props => [error, status, item, items, optionsMap, category];
}
