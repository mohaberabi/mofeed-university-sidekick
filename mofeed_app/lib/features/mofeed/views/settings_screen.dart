import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/app/widget/app_logo.dart';
import 'package:mofeduserpp/features/login/cubit/login_cubit.dart';
import 'package:mofeduserpp/features/login/cubit/login_state.dart';
import 'package:mofeduserpp/features/mofeed/widget/app_account_settings.dart';
import 'package:mofeduserpp/features/mofeed/widget/app_extra_settings.dart';
import 'package:mofeduserpp/features/mofeed/widget/app_settings.dart';

import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (prev, curr) => curr.state.isUnAthed,
      listener: (context, state) {
        if (state.state.isUnAthed) {
          context.navigateAndFinish(
            routeName: AppRoutes.chooseUniversityScreen,
          );
        }
      },
      child: Container(
        color: context.theme.shadowColor.withOpacity(0.08),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppAccountSettings(),
              const AppSettingsCta(),
              const AppExtraSettings(),
              const Center(
                  child: AppLogo(size: 33, color: AppColors.primColor)),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    l10n.termsCondition,
                    style:
                        context.bodyLarge.copyWith(color: AppColors.primColor),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
