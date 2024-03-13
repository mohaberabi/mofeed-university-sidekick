import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/features/checkout/cubit/checkout_cubit.dart';
import 'package:mofeduserpp/features/food_court/cubit/food_court_cubit/foodcourt_cubit.dart';
import 'package:mofeduserpp/features/food_item/cubit/fooditem_cubit.dart';
import 'package:mofeduserpp/features/food_item/screens/item_screen.dart';
import 'package:mofeduserpp/features/checkout/screens/checkout_screen.dart';
import 'package:mofeduserpp/features/order/cubit/order_cubit/order_cubit.dart';
import 'package:mofeduserpp/features/order/screens/order_tracking_screen.dart';
import 'package:mofeduserpp/features/order/screens/orders_screen.dart';
import 'package:mofeduserpp/features/rating/cubit/rating_cubit.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import '../../features/cart/views/cart_screen.dart';
import '../../features/food_court/views/food_court_screen.dart';
import '../../features/food_court/views/restarant_screen.dart';
import '../../features/rating/screens/restaurant_ratings.dart';
import '../services/service_lcoator.dart';
import 'main_app_router.dart';

class FoodRouter extends MainAppRouter {
  @override
  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case FoodRoutes.orders:
        return BlocProvider(
            child: const OrdersScreen(),
            create: (_) => sl<OrderCubit>()..getOrders()).toMaterialRoute;
      case FoodRoutes.orderTracking:
        final String orderId = settings.arguments as String;
        return BlocProvider(
                child: OrderTrackingScreen(orderID: orderId),
                create: (_) => sl<OrderCubit>()..trackOrder(orderId))
            .toMaterialRoute;
      case FoodRoutes.checkoutScreen:
        return BlocProvider(
          create: (_) => sl<CheckoutCubit>()..init(),
          child: const CheckoutScreen(),
        ).toMaterialRoute;
      case FoodRoutes.foodCourtScreen:
        return const FoodCourtScreen().toMaterialRoute;
      case FoodRoutes.variableItemScreen:
        final itemScreen = settings.arguments as FoodItemScreen;
        return BlocProvider(
            child: itemScreen,
            create: (_) => sl<FoodItemCubit>()
              ..getItem(
                  id: itemScreen.itemId,
                  restaurantId: itemScreen.restaurantId)).toMaterialRoute;

      case FoodRoutes.cartScreen:
        return MaterialPageRoute(builder: (context) => const CartScreen());
      case FoodRoutes.restarantScreen:
        final restarant = settings.arguments as String;
        return BlocProvider(
          create: (_) => sl<FoodCourtCubit>()..getRestaurantDetail(restarant),
          child: RestaurantScreen(restaurantId: restarant),
        ).toMaterialRoute;
      case FoodRoutes.restaurnatRatings:
        final restarant = settings.arguments as String;
        return BlocProvider(
          create: (_) => sl<RatingCubit>()..getRatings(restaurantId: restarant),
          child: RestaurantRatingScreen(restaruantId: restarant),
        ).toMaterialRoute;
      default:
        return super.undefinedRoute();
    }
  }
}
