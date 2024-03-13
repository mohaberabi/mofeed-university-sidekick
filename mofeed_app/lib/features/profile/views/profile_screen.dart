import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_cubit.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_state.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/model/app_media.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/avatar_widget.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/enums/media_source.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  static const _spacer = SizedBox(height: AppSpacing.lg);

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final profileCubit = context.read<ProfileCubit>();
    return BlocProvider.value(
      value: profileCubit..listenYoUserUpdates(),
      child: Scaffold(
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
          builder: (context, state) {
            final user = state.user;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AvatarWidget.image(
                      media: AppMedia(
                          source: MediaSource.network, path: user.image),
                      radius: 165,
                    ),
                    _spacer,
                    CustomTextField(
                      filled: false,
                      isOutlined: false,
                      isReadOnly: true,
                      initialValue: user.email,
                      label: local.email,
                    ),
                    _spacer,
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            filled: false,
                            isOutlined: false,
                            label: local.firstname,
                            initialValue: user.name,
                            onChanged: (v) => profileCubit.formChanged(name: v),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: CustomTextField(
                            filled: false,
                            isOutlined: false,
                            label: local.lastname,
                            initialValue: user.lastname,
                            onChanged: (v) =>
                                profileCubit.formChanged(lastname: v),
                          ),
                        ),
                      ],
                    ),
                    _spacer,
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
      ),
    );
  }
}
