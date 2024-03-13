import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/shared/router/app_routes.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/widgets/custom_texfield.dart';
import 'package:mofeed_shared/widgets/loader.dart';
import 'package:mofeed_shared/widgets/primary_button.dart';
import '../../../shared/sl/service_locator.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthCubit authCubit;

  @override
  void initState() {
    authCubit = sl<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthStates>(
          listener: (context, state) {
            state.state.when(
                error: () => showSnackBar(context,
                    message: state.error, state: FlushBarState.error),
                done: () {
                  navigateAndFinish(context, routeName: Routes.home);
                },
                loading: () {});
          },
        )
      ],
      child: BlocBuilder<AuthCubit, AuthStates>(
        buildWhen: (prev, curr) => prev != curr,
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            appBar: AppBar(title: Text("Login")),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login to mofeed accept", style: context.displaySmall),
                    16.height,
                    CustomTextField(
                      onChanged: (email) => authCubit.emailChanged(email),
                      label: l10n.email,
                      errorText: state.emailError,
                      labelStyle: context.titleLarge
                          .copyWith(fontWeight: FontWeight.normal),
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          state.universityDomain,
                          style:
                              context.titleLarge.copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    16.height,
                    CustomTextField(
                      maxLines: 1,
                      isPassword: state.isPassword,
                      suffix: IconButton(
                        onPressed: () => authCubit.changeVisibillity(),
                        icon: Icon(state.passWordIcon, color: Colors.grey),
                      ),
                      onChanged: (email) => authCubit.passWordChanged(email),
                      label: l10n.passowrd,
                      labelStyle: context.titleLarge
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              authCubit.sendPasswordResetLink();
                            },
                            child: Text(l10n.resendPassword)),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: state.state.loadingOrElse(
                          whenLoading: const Loader(),
                          orElse: PrimaryButton(
                            onPress: () {
                              authCubit.login();
                            },
                            label: "Login",
                          ),
                        )),
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
