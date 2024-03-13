import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_cubit.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_state.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/theme/theme_ext.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/enums/user_prefs.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import '../../signup/widgets/meta_data_updater.dart';
import 'meta_chooser.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    final local = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(local.profile)),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.state.isUpdated) {
            context.showSnackBar(message: local.infoUpdated);
          } else if (state.state.isError) {
            context.showSnackBar(
                message: local.localizeError(state.error),
                state: FlushBarState.error);
          }
        },
        listenWhen: (prev, curr) => prev.state != curr.state,
        builder: (context, state) {
          final user = state.user;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    decoration: context.theme.primaryDecoration,
                    child: CustomTextField(
                      border: InputBorder.none,
                      initialValue: user.bio,
                      isOutlined: false,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      height: 100,
                      isColumed: false,
                      onChanged: (v) => profileCubit.formChanged(bio: v),
                      hint: local.aboutYouHint,
                      hintStyle: context.bodyLarge.copyWith(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
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
                        final choosedPet = await MetaChooser.updatePet(context);
                        profileCubit.formChanged(pet: choosedPet);
                      },
                      subtitle: (pet) => pet.tr(context.lang),
                      leading: (pet) => pet.icon),
                  state.state.isLoading
                      ? const Loader()
                      : PrimaryButton(
                          onPress: state.canUpdateAccount
                              ? () => profileCubit.updateProfile()
                              : null,
                          label: local.save)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
