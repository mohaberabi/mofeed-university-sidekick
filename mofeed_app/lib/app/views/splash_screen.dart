import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/app/widget/app_logo.dart';
import 'package:mofeed_shared/cubit/navigation_cubit/navigation_cubit.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';

import '../../features/navigation/cubit/mofeed_nav_cubit.dart';
import '../../features/navigation/cubit/mofeed_nav_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavState>(
      listener: (context, state) {
        if (state is GoOnBoarding) {
          context.navigateAndFinish(routeName: AppRoutes.onBoarding);
        } else if (state is GoChooseUniversity) {
          context.navigateAndFinish(
              routeName: AppRoutes.chooseUniversityScreen);
        } else if (state is GoHomeScreen) {
          context.navigateAndFinish(routeName: AppRoutes.homeScreen);
        } else if (state is GoCompleteProfile) {
          context.navigateAndFinish(routeName: AppRoutes.completeProfile);
        } else if (state is GoVerifyAccount) {
          context.navigateAndFinish(routeName: AppRoutes.emailSentScreen);
        }
      },
      child: const Scaffold(
        backgroundColor: AppColors.primColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppLogo(),
            ],
          ),
        ),
      ),
    );
  }
}
