import 'package:flutter/material.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';

import '../../model/message_model.dart';
import '../colors/app_colors.dart';
import 'mesage_adapter.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel message;
  final bool isMine;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.isMine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColor = isMine ? AppColors.primDark : Colors.grey.withOpacity(0.2);
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: EdgeInsets.only(
            top: 12,
            left: isMine ? context.width / 3.2 : 16,
            right: isMine ? 16 : context.width / 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
              bottomLeft: Radius.circular(isMine ? 10 : 0),
              bottomRight: Radius.circular(isMine ? 0 : 10)),
          color: myColor,
        ),
        child: MessageAdapter(message: message, isMine: isMine),
      ),
    );
  }
}
