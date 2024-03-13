import 'package:flutter/material.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import '../../model/message_model.dart';

class MessagesBuilder extends StatelessWidget {
  final List<MessageModel> messages;
  final Widget Function(MessageModel) messageWidget;
  final Widget senderChild;
  final void Function(MessageModel) builderCallBack;

  const MessagesBuilder({
    Key? key,
    required this.messages,
    required this.messageWidget,
    required this.senderChild,
    required this.builderCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Expanded(
              child: ListView.separated(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) {
                    final message = messages[index];
                    if (message.issuedAt.day !=
                        messages[index + 1].issuedAt.day) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            message.issuedAt.mDy,
                            style:
                                context.bodyMedium.copyWith(color: Colors.grey),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    builderCallBack(message);
                    return messageWidget(message);
                  },
                  itemCount: messages.length)),
          senderChild,
        ],
      ),
    );
  }
}
