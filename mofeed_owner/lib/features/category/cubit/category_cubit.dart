import 'package:bloc/bloc.dart';
import 'package:food_court/model/category_model.dart';
import 'package:food_court/repository/category_repository.dart';
import 'package:mofeed_owner/features/category/cubit/category_state.dart';

import 'package:uuid/uuid.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(const CategoryState());
  final CategoryRepository _categoryRepository;

  void getCategories() async {
    emitLoading();
    final res = await _categoryRepository.getCategories();
    res.fold(
        (l) => emitError(l.error, st: l.stackTrace),
        (r) => emit(
            state.copyWith(status: CategoryStatus.populated, categories: r)));
  }

  void clearCategory() => emit(state.copyWith(category: CategoryModel.empty));

  void formChanged({
    String? ar,
    String? en,
    String? order,
  }) {
    emit(
      state.copyWith(
        category: state.category.copyWith(
          name: {
            "ar": ar ?? state.category.name['ar'],
            "en": en ?? state.category.name['en'],
          },
          order: int.parse(order ?? "0"),
        ),
      ),
    );
  }

  void addCategory() async {
    emitLoading();
    final id =
        state.category.id.isEmpty ? const Uuid().v1() : state.category.id;
    final res =
        await _categoryRepository.addCategory(state.category.copyWith(id: id));
    res.fold((l) => emitError(l.error, st: l.stackTrace),
        (r) => emit(state.copyWith(status: CategoryStatus.added)));
  }

  void deleteCategory(String id) async {
    emitLoading();
    final res = await _categoryRepository.deleteCategory(id);
    res.fold((l) => emitError(l.error, st: l.stackTrace),
        (r) => emit(state.copyWith(status: CategoryStatus.deleted)));
  }

  void emitError(String error, {StackTrace? st}) {
    emit(state.copyWith(status: CategoryStatus.error));
    addError(error, st);
  }

  void emitInitial() => emit(state.copyWith(status: CategoryStatus.initial));

  void emitLoading() => emit(state.copyWith(status: CategoryStatus.loading));
}
