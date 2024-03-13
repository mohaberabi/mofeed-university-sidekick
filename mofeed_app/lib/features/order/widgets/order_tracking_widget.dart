import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mofeduserpp/features/order/cubit/order_cubit/order_state.dart';
import 'package:mofeduserpp/features/order/widgets/order_progess_.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/model/university_model.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/theme/theme_ext.dart';
import 'package:mofeed_shared/ui/widgets/cached_image.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import '../../../core/services/service_lcoator.dart';
import '../../../core/widgets/payment_builder.dart';
import '../cubit/order_cubit/order_cubit.dart';
import 'items_builder.dart';

class OrderTrackingWidget extends StatelessWidget {
  final String orderId;

  const OrderTrackingWidget({required this.orderId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();
    final l10n = context.l10n;
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final order = state.order;
        if (order == null) {
          return AppPlaceHolder.error(
              onTap: () => orderCubit.trackOrder(orderId));
        } else {
          return RefreshIndicator.adaptive(
            onRefresh: () async => orderCubit.trackOrder(orderId),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: TextButton.icon(
                    label: Text("#${order.id}",
                        style: context.titleLarge
                            .copyWith(color: AppColors.primColor)),
                    icon: const Icon(Icons.copy),
                    onPressed: () {},
                  ),
                  leading: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => context.navigateAndFinish(
                          routeName: AppRoutes.homeScreen)),
                  backgroundColor: context.theme.isDark
                      ? AppColors.lightDark
                      : AppColors.primMaterial.shade50,
                ),
                Column(
                  children: [
                    AppIcon(order.status.image(context.theme.isDark),
                        custom: true, size: 350),
                    Container(
                      width: context.width,
                      decoration: BoxDecoration(
                        color: context.theme.scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppSpacing.lg),
                          topRight: Radius.circular(AppSpacing.lg),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              order.status.tr(context.lang),
                              style: context.displaySmall
                                  .copyWith(color: AppColors.primDark),
                            ),
                          ),
                          Center(
                            child: Text(
                              l10n.orderTrackingIdle,
                              style: context.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          OrderProgressWidget(status: order.status),
                          _Handover(
                            faculty: order.faculty,
                            floor: order.floor,
                            room: order.room,
                          ),
                          _DataBuilder(
                            icon: const AppIcon(AppIcons.clock,
                                color: AppColors.primDark),
                            title: l10n.handoverTime,
                            subtitle: order.pickupTime.amPM,
                          ),
                          _DataBuilder(
                              icon: const CachedImage(
                                imageUrl: tempImage,
                                decorated: true,
                                boxFit: BoxFit.cover,
                                w: 40,
                                h: 40,
                              ),
                              title: l10n.orderFrom,
                              subtitle:
                                  "${order.restaurantName[context.lang]}"),
                          OrderItemsBuilder(items: order.items),
                          PaymentBuilder(
                              needsDelivery: order.isDelivery,
                              discount: order.discount,
                              paymentAmount: order.cartTotal,
                              deliveryFees: order.cartTotal,
                              cartTotal: order.cartTotal,
                              taxes: order.cartTotal),
                          const SizedBox(height: AppSpacing.xxlg),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: PrimaryButton(
                                onPress: () {}, label: l10n.talkToSupport),
                          ),
                          const SizedBox(height: AppSpacing.xxlg),
                        ],
                      ),
                    ),
                  ],
                ).toSliver,
              ],
            ),
          );
        }
      },
    );
  }
}

class _DataBuilder extends StatelessWidget {
  final String title;

  final String subtitle;

  final Widget? icon;

  const _DataBuilder({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              if (icon != null)
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: icon!),
              Text(
                subtitle,
                style: context.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primDark,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Handover extends StatelessWidget {
  final FacultyModel? faculty;
  final String floor;

  final String room;

  const _Handover({
    super.key,
    required this.faculty,
    this.room = '',
    this.floor = '',
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final style = context.headlineSmall.copyWith(color: AppColors.primColor);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.orderHandover,
            style: context.headlineMedium,
          ),
          ...faculty != null
              ? [
                  Text(faculty!.name[context.lang], style: style),
                  Row(
                    children: [
                      Text("${l10n.floor} $floor", style: context.bodyLarge),
                      const SizedBox(width: 8),
                      Text("${l10n.floor} $room", style: context.bodyLarge),
                    ],
                  ),
                ]
              : [Text(l10n.pickupFromFoodCourt, style: style)],
        ],
      ),
    );
  }
}
