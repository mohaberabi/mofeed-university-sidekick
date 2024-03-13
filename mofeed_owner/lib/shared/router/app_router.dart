import 'package:flutter/cupertino.dart';
import 'package:food_court/model/order_model.dart';
import 'package:mofeed_owner/features/category/views/category_screen.dart';
import 'package:mofeed_owner/features/gallery/views/add_gallery_screen.dart';
import 'package:mofeed_owner/features/gallery/views/gallery_screen.dart';
import 'package:mofeed_owner/features/item/screens/add_item_screen.dart';
import 'package:mofeed_owner/features/item/screens/item_screen.dart';
import 'package:mofeed_owner/features/mofeed/views/splash_screen.dart';
import 'package:mofeed_owner/features/option/screens/add_option_screen.dart';
import 'package:mofeed_owner/features/order/views/track_order.dart';
import 'package:mofeed_owner/features/rating/view/rating_screen.dart';
import 'package:mofeed_owner/features/restraurant/views/restaurant_nifo_screen.dart';
import 'package:mofeed_owner/shared/router/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import '../../features/auth/views/auth_screen.dart';
import '../../features/mofeed/views/home_screen.dart';
import '../../features/option/screens/options_screen.dart';

abstract final class AppRouter {
  static Route onGenderatRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.restarantInfo:
        return const RestuarantInfoScreen().toMaterialRoute;
      case Routes.addGallery:
        return const AddGalleryScreen().toMaterialRoute;
      case Routes.auth:
        return const AuthScreen().toMaterialRoute;
      case Routes.home:
        return const HomeLayout().toMaterialRoute;
      case Routes.splash:
        return const SplashScreen().toMaterialRoute;
      case Routes.gallery:
        return const GalleryScreen().toMaterialRoute;
      case Routes.categoryScreen:
        return const CategoryScreen().toMaterialRoute;
      case Routes.ratingsScreen:
        return const RatingScreen().toMaterialRoute;
      case Routes.itemsScreen:
        return const ItemScreen().toMaterialRoute;
      case Routes.addItemScreen:
        return const AddItemScreen().toMaterialRoute;
      case Routes.foodOptionsScreen:
        return const FoodOptionScreen().toMaterialRoute;
      case Routes.orderTracking:
        final order = settings.arguments as OrderModel;
        return OrderTracking(order: order).toMaterialRoute;
      case Routes.addFoodOption:
        return const AddFoodOptionScreen().toMaterialRoute;
      default:
        return const AuthScreen().toMaterialRoute;
    }
  }
}
