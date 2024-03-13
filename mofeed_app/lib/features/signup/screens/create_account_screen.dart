import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/signup/cubit/auth_state.dart';
import 'package:mofeduserpp/features/signup/cubit/signup_cubit.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final authCubit = context.read<SignUpCubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (prev, curr) => (prev.state != curr.state),
          listener: (context, state) {
            if (state.state.isError) {
              context.showSnackBar(
                  message: local.localizeError(state.error),
                  state: FlushBarState.error);
            } else if (state.state.isEmailSent) {
              context.navigateAndFinish(routeName: AppRoutes.emailSentScreen);
            }
          },
        )
      ],
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return Scaffold(
            bottomSheet: const Disclaimer(),
            appBar: AppBar(
                title: const AppIcon(
              AppIcons.logo,
              color: AppColors.primColor,
              size: 65,
            )),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(local.createAccount, style: context.displaySmall),
                    const SizedBox(height: AppSpacing.sm),
                    Text(local.createAccountSubTtl),
                    const SizedBox(height: AppSpacing.xlg),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            filled: false,
                            onChanged: (name) =>
                                authCubit.formChanged(name: name),
                            isColumed: false,
                            label: local.fname,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: CustomTextField(
                            filled: false,
                            onChanged: (v) =>
                                authCubit.formChanged(lastname: v),
                            isColumed: false,
                            label: local.lastName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xlg),
                    CustomTextField(
                      filled: false,
                      textInputType: TextInputType.emailAddress,
                      onChanged: (v) => authCubit.formChanged(email: v),
                      isColumed: false,
                      label: local.email,
                      suffix: Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Text(
                          state.choosedUniversity.domain,
                          style:
                              context.bodyMedium.copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xlg),
                    CustomTextField(
                      filled: false,
                      onChanged: (password) =>
                          authCubit.formChanged(password: password),
                      isColumed: false,
                      label: local.passowrd,
                      isPassword: state.isPassword,
                      maxLines: 1,
                      suffix: IconButton(
                        onPressed: () => authCubit.changeVisibillity(),
                        icon: Icon(state.passWordIcon, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xlg),
                    state.state.isLoading
                        ? const Loader()
                        : PrimaryButton(
                            onPress: state.buttonEnabled
                                ? () => authCubit.createUser()
                                : null,
                            label: local.createAccount),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Disclaimer extends StatelessWidget {
  const Disclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final linkStyle = context.bodySmall.copyWith(
      color: AppColors.primColor,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.primColor,
    );
    return Container(
      margin: const EdgeInsets.all(AppSpacing.xlg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Text(local.disclaimerTtl, style: context.bodySmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Text(local.termsCondition, style: linkStyle),
                onTap: () {},
              ),
              Text(" ${local.and} ", style: context.bodySmall),
              GestureDetector(
                  child: Text(local.privacyPolicy, style: linkStyle),
                  onTap: () {})
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          GestureDetector(
            child: Text(local.helpSupport, style: linkStyle),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
