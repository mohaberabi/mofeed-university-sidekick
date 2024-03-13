import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class AdaptiveSheetAction {
  final String title;

  final void Function()? onPress;
  final Color? iconColor;

  final Color? textColor;

  final IconData? icon;

  const AdaptiveSheetAction({
    this.title = '',
    this.onPress,
    this.icon,
    this.textColor,
    this.iconColor,
  });
}

void showAdaptiveActionSheet(
  BuildContext context, {
  void Function()? onDelete,
  String iosTitle = '',
  List<AdaptiveSheetAction> actions = const [],
  String iosCancelText = "Cancel",
}) {
  if (Platform.isIOS) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(iosTitle),
          actions: actions.map((action) {
            return CupertinoActionSheetAction(
              child: action.icon != null
                  ? Row(
                      children: [
                        Icon(
                          action.icon!,
                          size: 30,
                          color: action.iconColor ?? CupertinoColors.activeBlue,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          action.title,
                          style: context.bodyLarge.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: action.textColor),
                        ),
                      ],
                    )
                  : Text(action.title),
              onPressed: () {
                Navigator.pop(context);
                if (action.onPress != null) {
                  action.onPress!.call();
                }
              },
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            child: Text(iosCancelText),
            onPressed: () => Navigator.pop(context),
          ),
        );
      },
    );
  } else {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: actions.map((e) {
                return ListTile(
                  leading: e.icon != null ? Icon(e.icon) : null,
                  title: Text(e.title),
                  onTap: () {
                    Navigator.pop(context);
                    if (e.onPress != null) {
                      e.onPress!.call();
                    }
                  },
                );
              }).toList()),
        );
      },
    );
  }
}
