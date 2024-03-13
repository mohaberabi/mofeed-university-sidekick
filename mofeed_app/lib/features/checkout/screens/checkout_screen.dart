import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/core/widgets/payment_builder.dart';
import 'package:mofeduserpp/features/checkout/widgets/checkout_shimmer.dart';
import 'package:mofeduserpp/features/order/widgets/order_handover.dart';
import 'package:mofeduserpp/features/order/widgets/order_methoder.dart';
import 'package:mofeduserpp/features/order/widgets/order_timer.dart';
import 'package:mofeduserpp/features/order/widgets/uni_resto_widget.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/conditioner.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/enums/langauge_enum.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

import '../cubit/checkout_cubit.dart';
import '../cubit/checkout_state.dart';

enum OrderMethod with CustomEnum {
  pickup("Pickup from food court", "استلم من الفود كورت"),
  handover("Building Handover", "توصيل للمبني");

  @override
  final String en;
  @override
  final String ar;

  const OrderMethod(this.en, this.ar);
}

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = context.read<CheckoutCubit>();
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.checkout)),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        listenWhen: (prev, curr) => prev.state != curr.state,
        listener: (context, state) {
          if (state.state == CheckoutStatus.orderCreated) {
            context.navigateAndFinish(
                routeName: FoodRoutes.orderTracking, args: state.recentOrderId);
          }
        },
        builder: (context, state) {
          return state.state.builder({
            CheckoutStatus.populated: () => Conditioner(
                  condition:
                      state.restarant != null && state.university != null,
                  builder: (okay) {
                    if (okay) {
                      final uni = state.university!;
                      final restaurant = state.restarant!;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UniRestoWidget(
                                title: uni.name[context.lang],
                                subtitle: restaurant.name[context.lang]),
                            OrderMethoder(
                                isEnabled: restaurant.offersDelivery,
                                currentMethod: state.method,
                                onChanged: (method) =>
                                    checkoutCubit.changeOrderMethod(method)),
                            if (state.method == OrderMethod.handover)
                              OrderHandover(
                                faculties: uni.faculties,
                                current: state.faculty,
                                onFloorChanged: (floor) => checkoutCubit
                                    .facultyFormChanged(floor: floor),
                                onRoomChanged: (room) => checkoutCubit
                                    .facultyFormChanged(room: room),
                                onChanged: (faculty) =>
                                    checkoutCubit.chooseFaculty(faculty),
                              ),
                            OrderTimer(
                              onTimeChoosed: (time) =>
                                  checkoutCubit.timeChanged(time),
                              choosedTime: state.time,
                            ),
                            PaymentBuilder(
                                discount: 0,
                                paymentAmount: state.grandTotal,
                                deliveryFees: state.deliveryFees,
                                cartTotal: state.cartTotal,
                                taxes: 0,
                                needsDelivery: state.deliveryFees > 0),
                            Center(
                              child: TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.info_outline_rounded),
                                  label: Text(l10n.readBeforOrder)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.xxlg),
                              child: state.state == CheckoutStatus.loading
                                  ? const Loader()
                                  : PrimaryButton(
                                      onPress: state.readyToOrder
                                          ? () => checkoutCubit.createOrder()
                                          : null,
                                      label: l10n.confirmPay,
                                    ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return AppPlaceHolder.error(
                          title: l10n.localizeError(state.error),
                          onTap: () => checkoutCubit.init());
                    }
                  },
                ),
            CheckoutStatus.error: () =>
                AppPlaceHolder.error(onTap: () => checkoutCubit.init()),
            CheckoutStatus.loading: () => const CheckoutShimmer()
          });
        },
      ),
    );
  }
}
