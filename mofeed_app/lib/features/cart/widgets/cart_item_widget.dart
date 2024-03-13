import 'package:flutter/material.dart';
import 'package:food_court/model/cart_item.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/cached_image.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import '../../food_court/widgets/inc_dec_qty.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onInc;

  final VoidCallback onDec;

  const CartItemWidget({
    Key? key,
    required this.item,
    required this.onInc,
    required this.onDec,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedImage(
              w: 50,
              h: 50,
              imageUrl: item.image,
              decorated: true,
              radius: 8,
              boxFit: BoxFit.cover),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name[lang], style: context.bodyLarge),
                Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: AppSpacing.xs,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: item.options.map((e) {
                    return Text(e.name[lang] + " ,",
                        style: context.bodyMedium.copyWith(color: Colors.grey));
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.totalPrice.toPrice(lang),
                        style: context.bodyLarge),
                    QtyAdapter(
                        onAdd: onInc,
                        onRemove: onDec,
                        qty: item.qty,
                        elevated: false),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
