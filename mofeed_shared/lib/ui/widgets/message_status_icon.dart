import 'package:flutter/material.dart';
import 'package:mofeed_shared/model/message_model.dart';

import '../colors/app_colors.dart';

class MessageStatusIcon extends StatelessWidget {
  final MessageStatusEnum status;
  final double iconSize;

  const MessageStatusIcon({
    super.key,
    required this.status,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case MessageStatusEnum.sending:
        return Icon(Icons.alarm, color: Colors.grey, size: iconSize);
      case MessageStatusEnum.sent:
        return Icon(Icons.done, color: Colors.grey, size: iconSize);
      case MessageStatusEnum.recieved:
        return Icon(Icons.done_all, color: Colors.grey, size: iconSize);
      case MessageStatusEnum.seen:
        return Icon(Icons.done_all, color: AppColors.primColor, size: iconSize);
    }
  }
}
