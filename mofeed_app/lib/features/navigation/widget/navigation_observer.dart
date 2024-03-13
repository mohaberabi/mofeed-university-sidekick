import 'package:flutter/cupertino.dart';

class AppNavigationObserver extends NavigatorObserver {
  static String? currentScreenName;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    currentScreenName = route.settings.name;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    currentScreenName = previousRoute?.settings.name;
  }
}
