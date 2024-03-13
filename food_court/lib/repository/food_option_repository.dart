import 'package:food_court/model/option_group.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

abstract class FoodOptionRepository {
  FutureVoid addOption(OptionGroup optionGroup);

  FutureVoid deleteOption(String id);

  FutureEither<List<OptionGroup>> getOptions();
}
