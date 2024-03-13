import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_cubit.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_state.dart';
import 'package:mofeduserpp/features/order/cubit/order_cubit/order_cubit.dart';
import 'package:mofeduserpp/features/order/cubit/order_cubit/order_state.dart';
import 'package:mofeduserpp/features/order/widgets/order_widget.dart';
import 'package:mofeed_shared/constants/app_constants.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/widgets/app_view_builder.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final orderCubit = context.read<OrderCubit>();
    return BlocListener<CartCubit, CartState>(
      listenWhen: (prev, curr) => prev.state != curr.state,
      listener: (context, state) {
        state.state.when({
          CartStatus.itemsCopiedToReOrder: () => context.navigateTo(
              routeName: FoodRoutes.cartScreen, doBefore: () => context.pop()),
          CartStatus.loading: () => showLoader(context),
          CartStatus.error: () => context.showSnackBar(
                message: l10n.localizeError(state.error),
                state: FlushBarState.error,
                doBefore: () => context.pop(),
              )
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.myOrders),
        ),
        body: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
          return state.state.buildWhen(
            onLoading: () => const Loader(),
            onError: () => AppPlaceHolder.error(
              title: l10n.localizeError(state.error),
              onTap: () => orderCubit.getOrders(),
            ),
            onDone: () {
              final orders = state.orders;
              return AppViewBuilder.list(
                  seprator: (context, index) =>
                      const Divider(height: 0, thickness: 0.5),
                  onRefresh: () async => orderCubit.getOrders(),
                  builder: (context, index) {
                    final order = orders[index];
                    return OrderCard(order: order);
                  },
                  count: orders.length,
                  placeHolder: AppPlaceHolder.empty(
                      title: l10n.noOrdersTitle,
                      subtitle: l10n.noOrdersSubtitle));
            },
          );
        }),
      ),
    );
  }
}
