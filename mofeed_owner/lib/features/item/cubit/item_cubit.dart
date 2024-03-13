import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_court/model/category_model.dart';
import 'package:food_court/model/item_model.dart';
import 'package:food_court/model/option_group.dart';
import 'package:food_court/repository/item_repository.dart';
import 'package:mofeed_owner/features/item/cubit/item_state.dart';
import 'package:uuid/uuid.dart';

class ItemCubit extends Cubit<ItemState> {
  final ItemRepository _itemRepository;

  ItemCubit({
    required ItemRepository itemRepository,
  })  : _itemRepository = itemRepository,
        super(const ItemState());

  void emitLoading() => emit(state.copyWith(status: ItemStatus.loading));

  void emitError(String error, [StackTrace? st]) {
    emit(state.copyWith(status: ItemStatus.error, error: error));
    addError(error, st);
  }

  void clearForm() => emit(state.copyWith(
      item: ItemModel.empty,
      category: CategoryModel.empty,
      optionsMap: const {}));

  void getItemVariants() async {
    emitLoading();
    final res =
        await _itemRepository.getItemVariants(ids: state.item.variationsIds);
    res.fold(
      (l) => emitError(l.error, l.stackTrace),
      (r) async {
        final categoryRes =
            await _itemRepository.getItemCategory(state.item.categoryId);
        categoryRes.fold((l) => emitError(l.error), (cate) {
          emit(
            state.copyWith(
              status: ItemStatus.populated,
              optionsMap: {
                ...state.optionsMap,
                ...{for (final option in r) option.id: option}
              },
              category: cate,
            ),
          );
        });
      },
    );
  }

  void itemChanged(ItemModel item) => emit(state.copyWith(item: item));

  void deleteItem(String id) async {
    emitLoading();
    final res = await _itemRepository.deleteItem(id);
    res.fold((l) => emitError(l.error, l.stackTrace),
        (r) => emit(state.copyWith(status: ItemStatus.deleted)));
  }

  void categoryChanged(CategoryModel category) => emit(state.copyWith(
      category: category, item: state.item.copyWith(categoryId: category.id)));

  void pickupOption(OptionGroup group) {
    final Map<String, OptionGroup> current = Map.from(state.optionsMap);

    if (current.containsKey(group.id)) {
      current.remove(group.id);
    } else {
      current.putIfAbsent(group.id, () => group);
    }
    emit(state.copyWith(optionsMap: current));
  }

  void addItem({
    ItemModel? item,
  }) async {
    emitLoading();
    final restId = FirebaseAuth.instance.currentUser!.uid;
    final id = state.item.id.isEmpty ? const Uuid().v1() : state.item.id;
    final res = await _itemRepository.addItem(item ??
        state.item.copyWith(
            id: id,
            restaurantId: restId,
            variationsIds: state.optionsMap.keys.toList(),
            categoryId: state.category.id));
    res.fold((l) => emitError(l.error, l.stackTrace),
        (r) => emit(state.copyWith(status: ItemStatus.added)));
    getItems();
  }

  void getItems() async {
    emitLoading();
    final res = await _itemRepository.getItems();
    res.fold((l) => emitError(l.error, l.stackTrace),
        (r) => emit(state.copyWith(status: ItemStatus.populated, items: r)));
  }

  void formChanged({
    String? url,
    String? ar,
    String? en,
    String? price,
  }) {
    emit(
      state.copyWith(
        item: state.item.copyWith(
            image: url,
            name: {
              "ar": ar ?? state.item.name['ar'],
              "en": en ?? state.item.name['en'],
            },
            price: double.parse(price ?? state.item.price.toStringAsFixed(2))),
      ),
    );
  }
}
