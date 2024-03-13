import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/login/cubit/login_cubit.dart';
import 'package:mofeduserpp/features/login/cubit/login_state.dart';
import 'package:mofeduserpp/features/mofeed/widget/app_extra_settings.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_cubit.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_state.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/avatar_widget.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/enums/user_prefs.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import '../../signup/widgets/meta_data_updater.dart';
import 'meta_chooser.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  late PageController pageController;
  late ProfileCubit profileCubit;

  @override
  void initState() {
    pageController = PageController();
    profileCubit = context.read<ProfileCubit>();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileCubit, ProfileState>(
          listenWhen: (prev, curr) => prev.state != curr.state,
          listener: (context, state) {
            state.state.when({
              ProfileStatus.updated: () {
                context.navigateAndFinish(routeName: AppRoutes.homeScreen);
              },
              ProfileStatus.error: () => context.showSnackBar(
                  message: local.localizeError(state.error),
                  state: FlushBarState.error),
            });
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (prev, curr) => prev.state != curr.state,
          listener: (context, state) {
            state.state.when({
              LoginStatus.unAuthed: () {
                context.navigateAndFinish(routeName: AppRoutes.onBoarding);
              },
            });
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(local.completeProfile),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You will need this data in order to easily find a room / roommate",
                  style: context.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.lg),
                BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                  final user = state.user;
                  return Column(
                    children: [
                      GestureDetector(
                        child: AvatarWidget.image(
                            media: state.profilePic, radius: 165),
                        onTap: () => profileCubit.pickupImage(),
                      ),
                      MetaUpdater<Gender>(
                          title: local.gender,
                          current: user.gender,
                          onTap: (gender) async {
                            final choosedGender =
                                await MetaChooser.updateGender(context);
                            profileCubit.formChanged(gender: choosedGender);
                          },
                          subtitle: (gender) => gender.tr(context.lang),
                          leading: (gender) => gender.icon),
                      MetaUpdater<Religion>(
                          title: local.religion,
                          current: user.religion,
                          onTap: (religion) async {
                            final choosedReligion =
                                await MetaChooser.updateReligion(context);
                            profileCubit.formChanged(religion: choosedReligion);
                          },
                          subtitle: (religion) => religion.tr(context.lang),
                          leading: (religion) => religion.icon),
                      MetaUpdater<Smoking>(
                          title: local.smoking,
                          current: user.smoking,
                          onTap: (smoking) async {
                            final choosedSmoking =
                                await MetaChooser.updateSmoking(context);
                            profileCubit.formChanged(smoking: choosedSmoking);
                          },
                          subtitle: (smoking) => smoking.tr(context.lang),
                          leading: (smoking) => smoking.icon),
                      MetaUpdater<Pet>(
                          title: local.petOpinion,
                          current: user.pet,
                          onTap: (pet) async {
                            final choosedPet =
                                await MetaChooser.updatePet(context);
                            profileCubit.formChanged(pet: choosedPet);
                          },
                          subtitle: (pet) => pet.tr(context.lang),
                          leading: (pet) => pet.icon),
                      state.state.isLoading
                          ? const Loader()
                          : PrimaryButton(
                              onPress: state.profilePic.path.isNotEmpty &&
                                      state.isMetaDataValid
                                  ? () => profileCubit.changeProfilePic()
                                  : null,
                              label: "Continue"),
                      const AppExtraSettings(),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
