import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/login/cubit/login_cubit.dart';
import 'package:mofeduserpp/features/login/cubit/login_state.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<LoginCubit>();
    final l10n = context.l10n;
    return MultiBlocListener(
        listeners: [
          BlocListener<LoginCubit, LoginState>(
            listenWhen: (prev, curr) => (prev.state != curr.state),
            listener: (context, state) {
              state.state.when({
                LoginStatus.error: () {
                  context.showSnackBar(
                      message: l10n.localizeError(state.error),
                      state: FlushBarState.error);
                },
                LoginStatus.authedAndReady: () {
                  context.navigateAndFinish(routeName: AppRoutes.homeScreen);
                },
                LoginStatus.autheNeedsComplete: () {
                  context.navigateAndFinish(
                      routeName: AppRoutes.completeProfile);
                },
                LoginStatus.authAndNeedVerifiaction: () {
                  context.navigateAndFinish(
                      routeName: AppRoutes.emailSentScreen);
                },
              });
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(title: Text(l10n.login)),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.letsSideKickTogether, style: context.displaySmall),
                  const SizedBox(height: AppSpacing.md),
                  Text(l10n.loginUsingYouUniversityMail,
                      style: context.bodyLarge),
                  const SizedBox(height: AppSpacing.lg),
                  BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                    return Column(
                      children: [
                        CustomTextField(
                          filled: false,
                          isColumed: true,
                          onChanged: (email) =>
                              _formChanged(authCubit, email: email),
                          label: l10n.email,
                          hint: "20181944@fue.edu.eg",
                          hintStyle: context.bodyLarge
                              .copyWith(color: Colors.grey.withOpacity(0.4)),
                          labelStyle: context.titleLarge
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        CustomTextField(
                          hint: l10n.passowrd,
                          hintStyle:
                              context.titleLarge.copyWith(color: Colors.grey),
                          filled: false,
                          maxLines: 1,
                          isPassword: state.isPassword,
                          suffix: IconButton(
                            onPressed: () => _changeVisibility(authCubit),
                            icon: Icon(state.passWordIcon, color: Colors.grey),
                          ),
                          onChanged: (password) =>
                              _formChanged(authCubit, password: password),
                          label: l10n.passowrd,
                          labelStyle: context.titleLarge
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () =>
                                    _sendPasswordResetLink(authCubit),
                                child: Text(l10n.resetPassword)),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xxlg),
                        state.state == LoginStatus.loading
                            ? const Loader()
                            : PrimaryButton(
                                onPress: state.canLogin
                                    ? () => _login(authCubit)
                                    : null,
                                label: l10n.login,
                              ),
                      ],
                    );
                  })
                ],
              ),
            ),
          ),
        ));
  }

  void _formChanged(
    LoginCubit authCubit, {
    String? email,
    String? password,
  }) =>
      authCubit.formChanged(email: email, password: password);

  void _login(LoginCubit authCubit) => authCubit.login();

  void _changeVisibility(LoginCubit authCubit) => authCubit.changeVisibillity();

  void _sendPasswordResetLink(LoginCubit authCubit) =>
      authCubit.sendPasswordResetLink();
}
