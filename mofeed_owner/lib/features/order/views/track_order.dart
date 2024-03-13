import 'package:flutter/material.dart';
import 'package:food_court/model/order_model.dart';
import 'package:mofeed_shared/constants/app_icons.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/utils/style/app_colors.dart';
import 'package:mofeed_shared/utils/style/shapes.dart';
import 'package:mofeed_shared/utils/time_ago.dart';
import 'package:mofeed_shared/widgets/text_icon.dart';

class OrderTracking extends StatelessWidget {
  final OrderModel order;

  const OrderTracking({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final divider = Divider(thickness: 16, color: Colors.grey.shade300);
    return Scaffold(
      appBar: AppBar(title: Text('#${order.id}')),
      body: CustomScrollView(
        slivers: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextIcon.custom(
                      iconFirst: true,
                      style: context.titleLarge,
                      text: "Due at ${order.pickupTime.amPM}",
                      icon: const AppIcon(AppIcons.clock),
                    ),
                    const Spacer(),
                    Text(TimeAgo(order.orderTime, context.lang).timeAgo),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextIcon.custom(
                      iconFirst: true,
                      style: context.titleLarge,
                      text: order.username,
                      icon: const AppIcon(AppIcons.user),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.call,
                            color: AppColors.primColor, size: 30))
                  ],
                ),
                const SizedBox(height: 16),
                _PickupInfo(order: order),
              ],
            ),
          ),
          divider,
          _Items(order: order),
          divider,
          _Payment(order: order),
        ].map((e) => e.toSliver).toList(),
      ),
    );
  }
}

class _Payment extends StatelessWidget {
  final OrderModel order;

  const _Payment({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ("Cart Total", order.cartTotal),
        ("Grand total", order.cartTotal)
      ].map((pair) {
        return ListTile(
          leadingAndTrailingTextStyle: context.bodyLarge.copyWith(fontSize: 16),
          trailing: Text(pair.$2.toPrice(context.lang)),
          leading: Text(
            pair.$1,
            style: context.titleLarge,
          ),
        );
      }).toList(),
    );
  }
}

class _Items extends StatelessWidget {
  final OrderModel order;

  const _Items({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        final item = order.items[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "${item.qty}x",
                    style: context.titleLarge
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  8.width,
                  Text(
                    item.name[context.lang],
                    style: context.titleLarge,
                  ),
                  const Spacer(),
                  Text(
                    item.totalPrice.toPrice(context.lang),
                    style: context.bodyLarge,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flexible(
                  child: Wrap(
                spacing: 8,
                children: item.options.map((option) {
                  return Text(
                    option.name[context.lang] + ", ",
                    style: context.bodyLarge.copyWith(color: Colors.black54),
                  );
                }).toList(),
              )),
            )
          ],
        );
      },
      itemCount: order.items.length,
    );
  }
}

class _PickupInfo extends StatelessWidget {
  final OrderModel order;

  const _PickupInfo({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final title = order.isDelivery
        ? "Handover to ${order.faculty!.name[context.lang]}"
        : "Pickup From Restaurant ";

    return ListTile(
      horizontalTitleGap: 4,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      shape: AppShapes.primary,
      leading:
          const AppIcon(AppIcons.moto, size: 30, color: AppColors.primDark),
      title: Text(title),
      titleTextStyle: context.titleLarge.copyWith(fontSize: 18),
      subtitle: order.isDelivery
          ? Text("Room :${order.floor} , Room :${order.room}")
          : null,
      subtitleTextStyle: context.bodyLarge.copyWith(fontSize: 16),
    );
  }
}
