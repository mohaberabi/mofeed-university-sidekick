import 'package:flutter/material.dart';
import 'package:food_court/model/item_model.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/cached_image.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class ItemWidget extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onTap;

  const ItemWidget({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name[context.lang], style: context.bodyMedium),
                      const SizedBox(height: AppSpacing.xs),
                      Text(item.describtion[context.lang],
                          style:
                              context.bodyMedium.copyWith(color: Colors.grey)),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                          item.isVariable
                              ? context.l10n.priceOnSelect
                              : item.price.toPrice(context.lang),
                          style: context.bodyLarge),
                    ],
                  ),
                ),
                CachedImage(
                    imageUrl: item.image,
                    w: 110,
                    decorated: true,
                    radius: 12,
                    h: 110,
                    boxFit: BoxFit.cover),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
