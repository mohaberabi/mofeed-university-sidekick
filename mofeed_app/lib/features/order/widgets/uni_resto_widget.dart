import 'package:flutter/material.dart';
import 'package:mofeduserpp/features/checkout/widgets/checkout_recaper.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class UniRestoWidget extends StatelessWidget {
  final String title;

  final String subtitle;

  const UniRestoWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return CheckoutRecaper(
      title: context.l10n.uniAndResto,
      child: ListTile(
        shape: context.theme.primaryOutlineBorder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        titleTextStyle: context.titleLarge,
        subtitleTextStyle: context.bodyLarge,
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
