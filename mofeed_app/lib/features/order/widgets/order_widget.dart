import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/model/order_model.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_cubit.dart';
import 'package:mofeduserpp/features/rating/widget/order_rater.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/cached_image.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return GestureDetector(
      onTap: () => context.navigateTo(
        routeName: FoodRoutes.orderTracking,
        args: order.id,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CachedImage(
              imageUrl: tempImage,
              decorated: true,
              boxFit: BoxFit.cover,
              radius: 8,
              w: 65,
              h: 65,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.restaurantName[context.lang],
                        style: context.titleLarge,
                      ),
                      Text(
                        order.status.tr(context.lang),
                        style: context.bodyMedium,
                      ),
                      Text(
                        order.orderTime.mdyHm,
                        style: context.bodyMedium,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        '${l10n.orderId} ${order.id}',
                        style: context.bodySmall,
                      ),
                      Row(
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                context.read<CartCubit>().reOrder(order.items);
                              },
                              icon: const Icon(Icons.add),
                              label: Text(l10n.reOrder)),
                          TextButton.icon(
                              onPressed: order.canRate
                                  ? () {
                                      context.showAppSheet(
                                          scrollable: true,
                                          padding: EdgeInsets.only(
                                              bottom: context.bottom),
                                          child: OrderRater(
                                              orderId: order.id,
                                              restaurantId: order.restaurantId,
                                              title:
                                                  "${l10n.shareYourExperienceWith} ${order.restaurantName[context.lang]}"));
                                    }
                                  : null,
                              icon: const Icon(Icons.star_rate_rounded),
                              label: Text(l10n.rate)),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios_outlined,
                      size: 16, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}
