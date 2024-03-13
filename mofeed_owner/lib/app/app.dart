import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/app/widget/app_bloc_providers.dart';
import 'package:mofeed_owner/shared/router/app_routes.dart';
import 'package:mofeed_shared/cubit/localization_cubit/local_cubit.dart';
import 'package:mofeed_shared/cubit/localization_cubit/local_states.dart';
import 'package:mofeed_shared/localization/app_local.dart';
import 'package:mofeed_shared/utils/style/theme/app_theme.dart';
import '../shared/router/app_router.dart';

class MofeedAccept extends StatelessWidget {
  const MofeedAccept({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProviders(
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
          builder: (context, state) {
        if (state is ChangeLocalState) {
          return MaterialApp(
              locale: state.locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.delegates,
              onGenerateRoute: AppRouter.onGenderatRoute,
              title: 'Mofeed Accept',
              initialRoute: Routes.splash,
              debugShowCheckedModeBanner: false,
              theme: AppTheme(state.locale.languageCode).themeData);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
