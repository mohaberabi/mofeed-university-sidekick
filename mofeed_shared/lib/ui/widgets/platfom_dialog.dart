import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogAction {
  final String title;

  final void Function() onTap;

  const DialogAction({
    required this.onTap,
    required this.title,
  });
}

void showPlatformDialog(
  BuildContext context, {
  required String title,
  String? subtitle,
  List<DialogAction> actions = const [],
  bool dismissable = true,
}) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      barrierDismissible: dismissable,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
            title: Text(title),
            content: subtitle != null ? Text(subtitle) : null,
            actions: actions.map((e) {
              return CupertinoDialogAction(
                child: Text(e.title),
                onPressed: () {
                  e.onTap.call();
                },
              );
            }).toList());
      },
    );
  } else {
    showDialog(
      barrierDismissible: dismissable,
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(title),
            content: subtitle != null ? Text(subtitle) : null,
            actions: actions.map((e) {
              return TextButton(
                onPressed: () {
                  e.onTap.call();
                },
                child: Text(e.title),
              );
            }).toList());
      },
    );
  }
}
