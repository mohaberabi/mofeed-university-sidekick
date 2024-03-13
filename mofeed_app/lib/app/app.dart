import 'package:flutter/material.dart';
import 'package:mofeduserpp/app/widget/bloc_providers.dart';
import 'package:mofeduserpp/app/widget/mofeed_builder.dart';
import 'package:mofeduserpp/core/router/app_router.dart';
import 'package:mofeduserpp/features/navigation/widget/navigation_observer.dart';
import 'package:mofeed_shared/localization/app_local.dart';
import 'package:mofeed_shared/ui/theme/dark_theme.dart';
import 'package:mofeed_shared/ui/theme/theme.dart';
import 'package:mofeed_shared/utils/app_routes.dart';

class MofeedApp extends StatelessWidget {
  const MofeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProviders(
      child: MofeedBuilder(
        builder: (locale, theme) {
          return MaterialApp(
            navigatorObservers: [
              AppNavigationObserver(),
            ],
            locale: locale.locale,
            onGenerateRoute: AppRouter.onGenerateRoute,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.delegates,
            debugShowCheckedModeBanner: false,
            title: 'Mofeed',
            theme: AppTheme(locale.locale.languageCode).themeData,
            darkTheme: DarkTheme(locale.locale.languageCode).themeData,
            themeMode: theme,
            initialRoute: AppRoutes.splashScreen,
          );
        },
      ),
    );
  }
}
