import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

import '../model/category_model.dart';
import '../model/item_model.dart';
import '../model/option_group.dart';

abstract class ItemRepository {
  FutureEither<List<ItemModel>> getItems({String? restarantId});

  FutureVoid addItem(ItemModel item);

  FutureVoid deleteItem(String id);

  FutureEither<List<OptionGroup>> getItemVariants({
    required List<String> ids,
  });

  FutureEither<CategoryModel> getItemCategory(String id);
}
