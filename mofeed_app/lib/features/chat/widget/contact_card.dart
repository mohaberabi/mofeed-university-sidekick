import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/model/app_media.dart';
import 'package:mofeed_shared/model/chat_model.dart';
import 'package:mofeed_shared/model/message_model.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/avatar_widget.dart';
import 'package:mofeed_shared/ui/widgets/message_status_icon.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/enums/media_source.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import '../../profile/cubit/profile_cubit.dart';

class ContactCard extends StatelessWidget {
  final ChatModel chat;

  const ContactCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final date = chat.sentAt.difference(DateTime.now()).inDays >= 1
        ? chat.sentAt.mDy
        : chat.sentAt.amPM;
    final uid = context.read<ProfileCubit>().state.user.uId;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: GestureDetector(
        onTap: () => context.navigateTo(
            routeName: AppRoutes.chatScreen, args: chat.recieverId),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: chat.recieverId,
              child: AvatarWidget.image(
                  radius: 46,
                  media:
                      AppMedia(path: chat.image, source: MediaSource.network)),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    chat.username,
                    style: context.titleLarge,
                  ),
                  _LastMessage(
                      isMine: chat.lastMessageSender == uid,
                      status: chat.status,
                      lastMessage: chat.lastMessage)
                ],
              ),
            ),
            Text(date, style: context.bodyLarge.copyWith(color: Colors.grey))
          ],
        ),
      ),
    );
  }
}

class _LastMessage extends StatelessWidget {
  final bool isMine;
  final MessageStatusEnum status;
  final String lastMessage;

  const _LastMessage({
    super.key,
    required this.isMine,
    required this.status,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    final color = isMine
        ? Colors.grey
        : status == MessageStatusEnum.seen
            ? Colors.grey
            : AppColors.primColor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMine) MessageStatusIcon(status: status, iconSize: 20),
        Expanded(
          child: Text(
            lastMessage,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                overflow: TextOverflow.ellipsis),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
