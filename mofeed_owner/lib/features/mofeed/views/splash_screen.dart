import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/features/navigation/cubit/navigation_cubit.dart';
import 'package:mofeed_owner/shared/router/app_routes.dart';
import 'package:mofeed_shared/constants/app_icons.dart';
import 'package:mofeed_shared/cubit/navigation_cubit/navigation_cubit.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/style/app_colors.dart';

import '../../../shared/sl/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AcceptNavCubit navCubit;

  @override
  void initState() {
    navCubit = sl<AcceptNavCubit>()..navigateOnStartUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AcceptNavCubit, NavState>(
      listener: (context, state) async {
        if (state is GoToAuth) {
          await _wait();
          navigateAndFinish(context, routeName: Routes.auth);
        } else if (state is GoHomeScreen) {
          await _wait();
          navigateAndFinish(context, routeName: Routes.home);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppIcon(
                AppIcons.logo,
                size: 225,
                color: AppColors.primColor,
              ),
              Text(
                "Accept",
                style:
                    context.displayLarge.copyWith(color: AppColors.primColor),
              ),
              Text(
                "For Partners",
                style:
                    context.headlineSmall.copyWith(color: AppColors.primColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _wait() async =>
      await Future.delayed(const Duration(seconds: 1));
}
