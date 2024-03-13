import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:mofeduserpp/core/router/main_app_router.dart';
import 'package:mofeduserpp/features/sakan_builder/screen/add_sakan_screen.dart';
import 'package:mofeduserpp/features/sakan/screen/my_sakan_screen.dart';
import 'package:mofeduserpp/features/sakan/screen/view_sakan_screen.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:sakan/model/sakan_model.dart';
import 'package:sakan/routes/sakan_routes.dart';

class SakanRouter extends MainAppRouter {
  @override
  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case SakanRoutes.viewSakanScreen:
        final sakan = settings.arguments as Sakan;
        return ViewSakanScreen(sakan: sakan).toMaterialRoute;
      case SakanRoutes.addSakanScreen:
        return const AddSakanScreen().toMaterialRoute;
      case SakanRoutes.mySakans:
        return const MySakanScreen().toMaterialRoute;
      default:
        return super.undefinedRoute();
    }
  }
}
