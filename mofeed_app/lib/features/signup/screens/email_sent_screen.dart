import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/signup/cubit/auth_state.dart';
import 'package:mofeduserpp/features/signup/cubit/signup_cubit.dart';
import 'package:mofeduserpp/features/signup/screens/create_account_screen.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class EmailSentScreen extends StatelessWidget {
  const EmailSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        state.state.when({
          SignUpStatus.emailNotVerified: () => context.showSnackBar(
                message: local.emailNotVerifiedError,
                state: FlushBarState.error,
              ),
          SignUpStatus.emailVerified: () =>
              context.navigateAndFinish(routeName: AppRoutes.completeProfile),
          SignUpStatus.error: () => context.showSnackBar(
                message: local.localizeError(state.error),
                state: FlushBarState.error,
              ),
          SignUpStatus.emailVerificationSent: () => context.showSnackBar(
                message: local.emailResnt,
                state: FlushBarState.done,
              ),
        });
      },
      listenWhen: (prev, curr) => prev.state != curr.state,
      child: Scaffold(
        bottomNavigationBar: const Disclaimer(),
        appBar: AppBar(
          title: Text(local.verifyEmailAddress),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: context.height / 6),
                const Icon(
                  Icons.mark_email_read_outlined,
                  color: AppColors.primColor,
                  size: 200,
                ),
                Text(
                  local.emailSent,
                  style: context.displayMedium
                      .copyWith(color: AppColors.primColor),
                ),
                Text(
                  local.emailSentDescribiton,
                  style: context.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xlg),
                BlocBuilder<SignUpCubit, SignUpState>(
                    builder: (context, state) {
                  return state.state.isLoading
                      ? const Loader()
                      : PrimaryButton(
                          onPress: () {
                            context
                                .read<SignUpCubit>()
                                .checkEmailverification();
                          },
                          label: local.didVerify,
                        );
                }),
                TextButton(
                    onPressed: () {
                      context.read<SignUpCubit>().sendEmailVerification();
                    },
                    child: Text(local.resendEmail)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
