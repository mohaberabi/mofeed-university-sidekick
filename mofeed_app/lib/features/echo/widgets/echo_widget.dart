import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/echo/widgets/echo_asker.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_cubit.dart';
import 'package:mofeed_shared/model/app_media.dart';
import 'package:mofeed_shared/model/echo_model.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/action_builder.dart';
import 'package:mofeed_shared/ui/widgets/avatar_widget.dart';
import 'package:mofeed_shared/ui/widgets/read_more.dart';
import 'package:mofeed_shared/utils/enums/media_source.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/time_ago.dart';

import '../../../core/widgets/text_edit_screen.dart';
import '../../signup/widgets/user_builder.dart';
import '../cubit/echo_cubit.dart';
import '../cubit/echo_states.dart';

class EchoWidget extends StatelessWidget {
  final EchoModel echo;
  final VoidCallback? onTap;
  final bool showReplies;
  final bool isMini;
  final String? parentId;

  const EchoWidget({
    super.key,
    required this.echo,
    this.onTap,
    this.showReplies = false,
    this.isMini = false,
    this.parentId,
  });

  static Widget add = const _AddEcho();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final uid = context.read<ProfileCubit>().state.user.uId;
    final double radius = echo.isReply ? 30 : 32;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AvatarWidget.image(
                      media: AppMedia(
                          path: echo.userImage, source: MediaSource.network),
                      radius: radius,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        echo.username,
                        style: context.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      TimeAgo(echo.createdAt, context.lang).timeAgo,
                      style: context.bodySmall.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    if (uid == echo.uid)
                      GestureDetector(
                        onTap: () => _menuTapped(context, uid: uid ?? ''),
                        child: const Icon(Icons.more_horiz_outlined),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                isMini
                    ? Text(
                        echo.echo,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: context.bodyLarge.copyWith(height: 1.2),
                      )
                    : ReadMore(
                        echo.echo,
                        style: context.bodyMedium.copyWith(height: 1.8),
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showReplies && echo.replies > 0)
                  Text(
                    "${echo.replies} ${l10n.replies}",
                    style: context.bodyLarge.copyWith(color: Colors.grey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _menuTapped(BuildContext context, {required String uid}) {
    final l10n = context.l10n;
    showAdaptiveActionSheet(
      context,
      actions: [
        if (uid == echo.uid)
          AdaptiveSheetAction(
              onPress: () => context
                  .read<EchoCubit>()
                  .deleteEcho(id: echo.id, parentId: parentId),
              title: l10n.delete,
              icon: Icons.delete_outline_rounded,
              iconColor: Colors.red,
              textColor: Colors.red),
      ],
    );
  }
}

class _AddEcho extends StatelessWidget {
  const _AddEcho({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: false,
            isScrollControlled: true,
            builder: (context) {
              return SizedBox(
                height: context.height * 0.9,
                child: BlocBuilder<EchoCubit, EchoState>(
                  builder: (context, state) {
                    return TextEditScreen(
                      onInit: () => context.read<EchoCubit>().clearFormFields(),
                      bottomSheet: EchoAsker(
                        enabled: state.allowChats,
                        onChanged: (v) =>
                            context.read<EchoCubit>().allowChatChanged(),
                      ),
                      leading: UserBuilder(
                        builder: (user) {
                          return AvatarWidget.image(
                              radius: 20,
                              media: AppMedia(
                                  path: user.image,
                                  source: MediaSource.network));
                        },
                      ),
                      loading: state.status == EchoStatus.loading,
                      absorbing: state.status == EchoStatus.loading,
                      title: l10n.leaveEcho,
                      hint: l10n.needAnyHelp,
                      onChanged: (v) =>
                          context.read<EchoCubit>().echoChanged(v),
                      onAction: state.formValid
                          ? () => context.read<EchoCubit>().addEcho()
                          : null,
                      actionText: l10n.post,
                    );
                  },
                ),
              );
            },
          );
        },
        icon: const AppIcon(AppIcons.edit));
  }
}
