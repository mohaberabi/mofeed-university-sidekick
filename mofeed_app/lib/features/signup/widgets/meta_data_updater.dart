import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class MetaUpdater<T> extends StatelessWidget {
  final T current;

  final void Function(T) onTap;

  final String Function(T) leading;

  final String Function(T) subtitle;

  final String title;

  const MetaUpdater({
    super.key,
    required this.title,
    required this.current,
    required this.onTap,
    required this.subtitle,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: ListTile(
        onTap: () {
          onTap(current);
        },
        trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        leading: AppIcon(leading(current)),
        title: Text(title),
        subtitleTextStyle: context.bodyLarge,
        subtitle: Text(subtitle(current)),
        shape: context.theme.primaryOutlineBorder,
      ),
    );
  }
}
