import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/app/widget/app_logo.dart';
import 'package:mofeduserpp/features/mofeed/cubit/mofeed_cubit.dart';
import 'package:mofeed_shared/cubit/localization_cubit/local_cubit.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/icons/assets_manager.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/theme/theme_ext.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/enums/langauge_enum.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import '../../features/theme_changer/cubit/theme_changer_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            AssetManager.fue,
            fit: BoxFit.cover,
            width: context.width,
            height: context.height,
          ),
          Container(
            color: Colors.black.withOpacity(0.55),
          ),
          Container(
            height: context.height * 0.35,
            width: context.width,
            decoration: BoxDecoration(
              borderRadius: AppSpacing.lg.circle,
              color: context.theme.scaffoldBackgroundColor,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Row(
                      children: [
                        AppQuicker(),
                      ],
                    ),
                  ),
                ),
                const AppLogo(color: AppColors.primColor, size: 85),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  local.proudCrafted,
                  style: context.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(local.fue, style: context.headLineLarge),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: PrimaryButton(
                    onPress: () => _seeOnBoarding(context),
                    label: local.getStarted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _seeOnBoarding(BuildContext context) {
    context.read<MofeedCubit>().seeOnBoarding();
    context.navigateAndFinish(routeName: AppRoutes.chooseUniversityScreen);
  }
}

class AppQuicker extends StatelessWidget {
  const AppQuicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QuickAction(
          onTap: () => context
              .read<ThemeChangerCubit>()
              .changeTheme(context.theme.toOther),
          child: Icon(
            context.theme.modeIcon,
            color: AppColors.primColor,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        QuickAction(
          onTap: () => context
              .read<LocalizationCubit>()
              .changeLanguage(context.lang == 'ar' ? "en" : 'ar'),
          child: Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              context.lang.toAppLang.next.id,
              textAlign: TextAlign.center,
              style: context.titleLarge.copyWith(
                  color: AppColors.primColor,
                  fontFamily: context.lang.toAppLang.next.fontFamily),
            ),
          ),
        ),
      ],
    );
  }
}

@visibleForTesting
class QuickAction extends StatelessWidget {
  final VoidCallback onTap;

  final Widget child;

  const QuickAction({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 1.36,
          )),
      width: 36,
      height: 36,
      child: GestureDetector(onTap: onTap, child: child),
    );
  }
}
