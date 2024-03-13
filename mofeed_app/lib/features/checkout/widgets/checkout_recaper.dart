import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';

class CheckoutRecaper extends StatelessWidget {
  final String title;

  final Widget child;

  const CheckoutRecaper({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final style = context.titleLarge.copyWith(fontWeight: FontWeight.w900);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Text(title, style: style)),
          child
        ],
      ),
    );
  }
}
