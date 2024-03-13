import 'package:flutter/material.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/core/widgets/settings_summary.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/cta.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:sakan/routes/sakan_routes.dart';

class AppAccountSettings extends StatelessWidget {
  const AppAccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SettingsSummary(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      title: l10n.yourAccount,
      stackedTitle: false,
      children: [
        CallToAction.custom(
          title: l10n.personalInfo,
          action: () => context.navigateTo(routeName: AppRoutes.profileScreen),
          leading: const AppIcon(AppIcons.user),
        ),
        CallToAction.custom(
          title: l10n.personalInfo,
          action: () =>
              context.navigateTo(routeName: AppRoutes.personalInfoScreen),
          leading: const AppIcon(AppIcons.insurance),
        ),
        CallToAction.custom(
          title: l10n.universityInfo,
          action: () => context.navigateTo(routeName: AppRoutes.univeristyInfo),
          leading: const AppIcon(AppIcons.uni),
        ),
        CallToAction.simple(
          title: l10n.notifications,
          action: () =>
              context.navigateTo(routeName: AppRoutes.notificationScreen),
          icon: Icons.notifications_active_outlined,
        ),
        CallToAction.custom(
          title: l10n.orders,
          action: () => context.navigateTo(routeName: FoodRoutes.orders),
          leading: const AppIcon(AppIcons.recipt),
        ),
        CallToAction.custom(
          title: l10n.listings,
          action: () => context.navigateTo(routeName: SakanRoutes.mySakans),
          leading: const AppIcon(AppIcons.bed),
        ),
        CallToAction.custom(
          title: l10n.echo,
          action: () =>
              context.navigateTo(routeName: AppRoutes.echoScreen, args: true),
          leading: const AppIcon(AppIcons.microphone),
        ),
        CallToAction.simple(
          title: l10n.favorites,
          action: () => context.navigateTo(routeName: AppRoutes.favoritescreen),
          icon: Icons.favorite_border,
        ),
      ],
    );
  }
}
