import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/signup/cubit/auth_state.dart';
import 'package:mofeduserpp/features/signup/cubit/signup_cubit.dart';
import 'package:mofeduserpp/features/university/widgets/university_chooser.dart';
import 'package:mofeed_shared/model/university_model.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import '../../university/cubit/university_cubit.dart';
import '../../university/cubit/university_state.dart';

class ChooseUniversityScreen extends StatelessWidget {
  const ChooseUniversityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final signUpState =
        context.select<SignUpCubit, SignUpState>((value) => value.state);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () => _navigate(context, route: AppRoutes.loginScreen),
              child: Text(l10n.haveAnAccount))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.chooseUniversity, style: context.displaySmall),
              Text(
                l10n.whereSideKick,
                style:
                    context.bodyLarge.copyWith(fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: AppSpacing.lg),
              BlocBuilder<UniversityCubit, UniversityState>(
                buildWhen: (prev, curr) => curr.state != prev.state,
                builder: (context, state) {
                  return state.state.builder({
                    CubitState.done: () => UniversityChooser(
                          onChoosed: (uni) =>
                              _universityInfoChanged(context, uni: uni),
                          unis: state.unis,
                          selected: (uni) =>
                              uni.id == signUpState.choosedUniversity.id,
                        ),
                    CubitState.loading: () => const Loader(),
                    CubitState.error: () => AppPlaceHolder.error(
                        title: l10n.localizeError(state.error),
                        onTap: () => _getAllUnis(context)),
                  });
                },
              ),
              PrimaryButton(
                onPress: signUpState.choosedUni
                    ? () => _navigate(
                          context,
                          route: AppRoutes.createAccountScreen,
                        )
                    : null,
                label: l10n.confirm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _universityInfoChanged(
    BuildContext context, {
    required UniversityModel uni,
  }) =>
      context.read<SignUpCubit>().universityInfoChanged(uni);

  void _getAllUnis(BuildContext context) =>
      context.read<UniversityCubit>().getAllUniversites();

  void _navigate(BuildContext context, {required String route}) =>
      context.navigateTo(routeName: route);
}
