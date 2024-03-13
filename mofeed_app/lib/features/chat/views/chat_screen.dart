import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_shared/constants/common_params.dart';
import 'package:mofeed_shared/model/app_media.dart';
import 'package:mofeed_shared/model/client_user_model.dart';
import 'package:mofeed_shared/model/message_model.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/avatar_widget.dart';
import 'package:mofeed_shared/ui/widgets/conditioner.dart';
import 'package:mofeed_shared/ui/widgets/message_widget.dart';
import 'package:mofeed_shared/ui/widgets/messages_builder.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/ui/widgets/sender_widget.dart';
import 'package:mofeed_shared/utils/enums/media_source.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_states.dart';

class ChatScreen extends StatefulWidget {
  final String recieverId;

  const ChatScreen({Key? key, required this.recieverId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatCubit chatCubit;

  @override
  void initState() {
    chatCubit = context.read<ChatCubit>()
      ..getChatter(widget.recieverId)
      ..getMessages(widget.recieverId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.read<ProfileCubit>().state.user.uId;
    final l10n = context.l10n;
    return BlocBuilder<ChatCubit, ChatStates>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Conditioner(
                builder: (chatterExist) {
                  if (chatterExist) {
                    final chatter = state.chatter!;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Hero(
                              tag: widget.recieverId,
                              child: AvatarWidget.image(
                                radius: 36,
                                media: AppMedia(
                                    path: chatter.image,
                                    source: MediaSource.network),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${chatter.name} ${chatter.lastname}",
                                      style: context.titleLarge),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
                condition: state.chatter != null &&
                    !state.state.isError &&
                    state.chatter != ClientUser.anonymus),
          ),
          body: Conditioner(
              condition:
                  state.state.isError || state.chatter == ClientUser.anonymus,
              builder: (isError) {
                if (isError) {
                  return AppPlaceHolder.error(
                    onTap: () => Navigator.pop(context),
                    title: l10n.userDeletedNotFound,
                    subtitle: l10n.sorryComeLater,
                  );
                } else {
                  return MessagesBuilder(
                    messages: state.messages,
                    builderCallBack: (message) {
                      if (message.status != MessageStatusEnum.seen &&
                          message.sender != uid) {
                        chatCubit.markMessagesSeen(
                            message.copyWith(status: MessageStatusEnum.seen));
                      }
                    },
                    messageWidget: (message) {
                      return MessageWidget(
                          message: message, isMine: message.sender == uid);
                    },
                    senderChild: SenderWidget(
                      onChanged: (v) => chatCubit.messageTextChanged(v),
                      canSend: state.canSend,
                      onSend: (text) => chatCubit.sendMessage(
                          reciever: widget.recieverId,
                          recieverLangCode:
                              state.chatter?.local ?? CommonParams.ar,
                          token: state.chatter?.token ?? ""),
                    ),
                  );
                }
              }));
    });
  }
}
