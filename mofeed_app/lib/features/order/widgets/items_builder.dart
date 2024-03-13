import 'package:flutter/material.dart';
import 'package:food_court/model/cart_item.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class OrderItemsBuilder extends StatelessWidget {
  final List<CartItem> items;

  const OrderItemsBuilder({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;
    return ListView.separated(
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            dense: true,
            subtitle: item.options.isNotEmpty
                ? Text(
                    item.options.fold(
                      "",
                      (previousValue, element) =>
                          "$previousValue , ${element.name[context.lang]}",
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.zero,
            leading: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: 4.circle,
                    color: Colors.grey.withOpacity(0.2)),
                child: Text('${item.qty}', style: context.bodyLarge)),
            title: Text(item.name[lang], style: context.bodyLarge),
            trailing: Text(
              item.totalPrice.toPrice(lang),
              style: context.bodyLarge,
            ),
          );
        },
        itemCount: items.length);
  }
}
