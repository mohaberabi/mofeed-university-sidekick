import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/utils/enums/langauge_enum.dart';

abstract class Favorite {
  final FavoriteType favoriteType;

  const Favorite(this.favoriteType);
}

enum FavoriteType with CustomEnum {
  restarant("Restaurants", "", AppIcons.pizza),
  mateWanted("Rooms", "", AppIcons.room),
  roomWanted("Roommates", "", AppIcons.mates);

  @override
  final String ar;
  @override
  final String en;

  final String path;

  const FavoriteType(
    this.en,
    this.ar,
    this.path,
  );
}
