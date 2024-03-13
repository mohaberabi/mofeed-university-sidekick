import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';

class QtyAdapter extends StatelessWidget {
  final VoidCallback? onAdd;

  final VoidCallback? onRemove;
  final int qty;
  final bool elevated;

  const QtyAdapter({
    Key? key,
    required this.onAdd,
    this.elevated = true,
    required this.onRemove,
    required this.qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onRemove,
              child: const Icon(Icons.remove, color: AppColors.primColor),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Text('$qty', style: context.titleLarge)),
            GestureDetector(
              onTap: onAdd,
              child: const Icon(Icons.add, color: AppColors.primColor),
            ),
          ],
        ),
      ),
    );
  }
}
