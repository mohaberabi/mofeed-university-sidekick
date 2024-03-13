import 'package:flutter/material.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/core/router/sakan_router.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:sakan/routes/sakan_routes.dart';
import 'app_router.dart';
import 'food_router.dart';

abstract class MainAppRouter {
  Route onGeneratedRoute(RouteSettings settings);

  Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}

final Map<String, MainAppRouter> routesMap = {
  AppRoutes.start: AppRouter(),
  FoodRoutes.start: FoodRouter(),
  SakanRoutes.start: SakanRouter(),
};
