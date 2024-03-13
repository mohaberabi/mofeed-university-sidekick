import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_cubit.dart';
import 'package:mofeduserpp/features/sakan/cubit/sakan_cubit/sakan_cubit.dart';
import 'package:mofeduserpp/features/sakan/cubit/sakan_cubit/sakan_state.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/action_builder.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:sakan/model/mate_wanted.dart';
import 'package:sakan/model/sakan_model.dart';

class ViewSakanBottomNavBar extends StatelessWidget {
  final Sakan sakan;

  const ViewSakanBottomNavBar({
    super.key,
    required this.sakan,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final uid = context.read<ProfileCubit>().state.user.uId;
    final String priceS = sakan is MateWanted ? l10n.price : l10n.budget;
    return Container(
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Colors.grey.shade300, width: 1))),
      width: context.width,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      height: context.height * 0.133,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      priceS,
                      style: context.bodyLarge.copyWith(color: Colors.grey),
                    ),
                    Text(sakan.price.toPrice(context.lang),
                        style: context.titleLarge),
                    const SizedBox(width: AppSpacing.xxs),
                    Text(("(${sakan.billingPeriod.tr(context.lang)})"),
                        style: context.bodyLarge),
                    if (sakan is MateWanted)
                      Text(
                          (sakan as MateWanted).isBillIncluded
                              ? l10n.allBillsInclueded
                              : l10n.plustExtraBills,
                          style: context.bodyLarge),
                  ],
                ),
              ),
              if (sakan.uid != uid && sakan.showPhoneNo)
                PrimaryButton.circleRounded(
                  onPress: () {},
                  child: const Icon(Icons.call, color: AppColors.primColor),
                ),
              if (sakan.uid != uid) const SizedBox(width: AppSpacing.sm),
              PrimaryButton(
                onPress: () {
                  if (sakan.uid == uid) {
                    showAdaptiveActionSheet(context, actions: [
                      AdaptiveSheetAction(
                        onPress: () {
                          context.read<SakanCubit>().deleteSakan(sakan);
                        },
                        title: l10n.delete,
                        textColor: Colors.red,
                      ),
                    ]);
                  } else {
                    context.navigateTo(
                        routeName: AppRoutes.chatScreen, args: sakan.uid);
                  }
                },
                color: sakan.uid == uid ? Colors.red : AppColors.primColor,
                label: sakan.uid == uid ? l10n.delete : l10n.chat,
                minimumSize: const Size(136, 50),
                maximumSize: const Size(200, 50),
              )
            ],
          ),
        ],
      ),
    );
  }
}
