import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class SettingsSummary extends StatelessWidget {
  final String title;
  final Color? color;
  final EdgeInsets? padding;

  final List<Widget> children;
  final bool stackedTitle;

  const SettingsSummary(
      {Key? key,
      required this.title,
      this.padding,
      this.stackedTitle = true,
      required this.children,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!stackedTitle) buildTitle(context),
        Container(
          color: color ?? context.theme.scaffoldBackgroundColor,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [if (stackedTitle) buildTitle(context), ...children],
          ),
        ),
      ],
    );
  }

  Widget buildTitle(BuildContext context) => Container(
        padding: padding ?? const EdgeInsets.only(top: AppSpacing.xlg),
        child: Text(title, style: context.headlineMedium),
      );
}
