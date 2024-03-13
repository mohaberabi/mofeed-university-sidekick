import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/utils/extensions/restarant_ext.dart';
import 'package:mofeed_owner/features/order/cubit/order_cubit.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/style/shapes.dart';
import 'package:mofeed_shared/widgets/my_place_holder.dart';
import 'package:mofeed_shared/widgets/primary_button.dart';
import 'package:mofeed_shared/widgets/text_icon.dart';

import '../../../shared/sl/service_locator.dart';
import '../../order/cubit/order_state.dart';

class ActiveOrdersBuilder extends StatefulWidget {
  const ActiveOrdersBuilder({super.key});

  @override
  State<ActiveOrdersBuilder> createState() => _ActiveOrdersBuilderState();
}

class _ActiveOrdersBuilderState extends State<ActiveOrdersBuilder> {
  late OrderCubit orderCubit;

  @override
  void initState() {
    orderCubit = sl<OrderCubit>()..getActiveOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
      if (state.activeOrders.isEmpty) {
        return AppPlaceHolder.empty(title: "No Active Orders");
      } else {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final order = state.activeOrders[index];
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: 4.circle,
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.username,
                          style: context.titleLarge,
                        ),
                        TextIcon.iconData(
                          text: "Due at ${order.pickupTime.amPM}",
                          icon: Icons.alarm,
                          iconFirst: true,
                          style: context.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PrimaryButton(
                        onPress: () =>
                            orderCubit.updateOrderStatus(order: order),
                        label: order.status
                            .actionLabel(order.isDelivery)[context.lang]),
                  )
                ],
              ),
            );
          },
          itemCount: state.activeOrders.length,
        );
      }
    });
  }
}
