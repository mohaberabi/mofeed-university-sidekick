import 'package:equatable/equatable.dart';
import 'package:food_court/model/category_model.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

enum CategoryStatus {
  initial,
  loading,
  added,
  error,
  populated,
  deleted,
  updated,
}

class CategoryState extends Equatable {
  final CategoryStatus status;
  final CategoryModel category;

  final String error;

  final List<CategoryModel> categories;

  const CategoryState({
    this.error = '',
    this.status = CategoryStatus.initial,
    this.categories = const [],
    this.category = CategoryModel.empty,
  });

  CategoryState copyWith({
    CategoryStatus? status,
    String? error,
    List<CategoryModel>? categories,
    CategoryModel? category,
  }) {
    return CategoryState(
      status: status ?? this.status,
      error: error ?? this.error,
      category: category ?? this.category,
      categories: categories ?? this.categories,
    );
  }

  bool get readyToAdd => category.name.isNotEmpty;

  @override
  List<Object?> get props => [error, status, categories, category];
}
