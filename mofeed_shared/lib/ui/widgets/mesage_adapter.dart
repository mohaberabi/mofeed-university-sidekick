import 'package:flutter/material.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/ui/widgets/message_status_icon.dart';
import 'package:mofeed_shared/ui/widgets/read_more.dart';

import '../../model/message_model.dart';
import '../colors/app_colors.dart';
import '../spacing/spacing.dart';

class MessageAdapter extends StatelessWidget {
  final MessageModel message;
  final bool isMine;

  const MessageAdapter({
    Key? key,
    required this.message,
    required this.isMine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = isMine ? Colors.white : context.bodyLarge.color;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: ReadMore(
            message.message,
            readMoreStyle:
                context.bodyLarge.copyWith(color: AppColors.primColor),
            style: context.bodyLarge.copyWith(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isMine)
              MessageStatusIcon(
                status: message.status,
              ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              message.issuedAt.amPM,
              style: context.bodyMedium.copyWith(color: textColor),
            )
          ],
        ),
      ],
    );
  }
}
