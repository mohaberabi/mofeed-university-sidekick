import 'package:food_court/model/category_model.dart';
import 'package:food_court/model/item_model.dart';
import 'package:food_court/model/option_group.dart';
import 'package:food_court/model/restaurant_model.dart';
import 'package:mofeed_shared/utils/pair.dart';
import 'package:mofeed_shared/utils/triple.dart';

typedef ItemWithVariants = Pair<ItemModel, List<OptionGroup>>;

typedef RestaurantDetail
    = Triple<RestarantModel, List<ItemModel>, List<CategoryModel>>;
