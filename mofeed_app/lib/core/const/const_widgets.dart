import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/theme/theme_ext.dart';
import 'dart:io';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class AppBackBtn extends StatelessWidget {
  final Color background;

  const AppBackBtn({
    super.key,
    this.background = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final icon = Platform.isAndroid
        ? Icons.arrow_back_rounded
        : Icons.arrow_back_ios_new_rounded;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
          radius: 20,
          foregroundColor: context.theme.isDark ? Colors.white : Colors.black,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                icon,
                size: 20,
              ))),
    );
  }
}
