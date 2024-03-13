import 'package:food_court/model/category_model.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

abstract class CategoryRepository {
  FutureEither<List<CategoryModel>> getCategories();

  FutureVoid addCategory(CategoryModel item);

  FutureVoid deleteCategory(String id);
}
