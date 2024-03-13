import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/core/widgets/complex_scroll.dart';
import 'package:mofeduserpp/features/echo/cubit/echo_cubit.dart';
import 'package:mofeduserpp/features/echo/widgets/echo_widget.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_cubit.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/model/app_media.dart';
import 'package:mofeed_shared/model/echo_model.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/theme/theme_ext.dart';
import 'package:mofeed_shared/ui/widgets/app_view_builder.dart';
import 'package:mofeed_shared/ui/widgets/avatar_widget.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/utils/enums/media_source.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import '../../../core/widgets/text_edit_screen.dart';
import '../../signup/widgets/user_builder.dart';
import '../cubit/echo_states.dart';

class EchoReplyScreen extends StatelessWidget {
  final EchoModel echo;

  const EchoReplyScreen({
    super.key,
    required this.echo,
  });

  @override
  Widget build(BuildContext context) {
    final uid = context.read<ProfileCubit>().state.user.uId;
    final echoCubit = context.read<EchoCubit>();
    final l10n = context.l10n;
    return BlocProvider.value(
      value: echoCubit..getReplies(echoId: echo.id),
      child: BlocListener<EchoCubit, EchoState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          state.status.when({
            EchoStatus.replied: () {
              context.showSnackBar(
                  message: l10n.helpReachedColleague,
                  doBefore: () => Navigator.pop(context));
            },
            EchoStatus.error: () {
              context.showSnackBar(
                  message: l10n.localizeError(state.error),
                  state: FlushBarState.error);
            },
          });
        },
        child: Scaffold(
          bottomNavigationBar: uid == echo.uid
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg, vertical: AppSpacing.xxlg),
                  child: GestureDetector(
                    onTap: () async {
                      await _reply(context).then(
                          (value) => echoCubit.getReplies(echoId: echo.id));
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.sm, horizontal: AppSpacing.md),
                        decoration: context.theme.primaryDecoration,
                        child: Text(
                          "${l10n.replyTo} ${echo.username}",
                          style: context.bodyLarge.copyWith(color: Colors.grey),
                        )),
                  ),
                ),
          appBar: AppBar(title: Text(l10n.echo)),
          body: ComplexScrollView(
            onMax: () async => echoCubit.getReplies(echoId: echo.id),
            onRefresh: () async => echoCubit.getReplies(echoId: echo.id),
            children: [
              EchoWidget(echo: echo, showReplies: true),
              const Divider(thickness: 0.5),
              BlocBuilder<EchoCubit, EchoState>(builder: (context, state) {
                final view = AppViewBuilder.list(
                    primary: false,
                    shrinkWrap: true,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    seprator: (context, index) =>
                        const Divider(height: 0, thickness: 1),
                    builder: (context, index) {
                      final reply = state.replies.values.toList()[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md),
                        child: EchoWidget(echo: reply, parentId: echo.id),
                      );
                    },
                    count: state.replies.length,
                    placeHolder: const SizedBox());
                return state.status.builder({
                  EchoStatus.loading: () => const Loader(),
                  EchoStatus.error: () => AppPlaceHolder.error(
                      onTap: () async => echoCubit.getReplies(echoId: echo.id)),
                  EchoStatus.populated: () => view
                }, placeHolder: view);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _reply(BuildContext context) async {
    final l10n = context.l10n;
    await showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: context.height * 0.9,
          child: BlocBuilder<EchoCubit, EchoState>(
            builder: (context, state) {
              return TextEditScreen(
                leading: UserBuilder(builder: (user) {
                  return AvatarWidget.image(
                    radius: 18,
                    media:
                        AppMedia(path: user.image, source: MediaSource.network),
                  );
                }),
                loading: state.status.isSame(EchoStatus.loading),
                absorbing: state.status.isSame(EchoStatus.loading),
                title: l10n.reply,
                hint: "${l10n.replyTo} ${echo.username}",
                onChanged: (v) => context.read<EchoCubit>().echoChanged(v),
                onAction: state.formValid
                    ? () =>
                        context.read<EchoCubit>().leaveReply(echoId: echo.id)
                    : null,
                actionText: l10n.post,
              );
            },
          ),
        );
      },
    );
  }
}
