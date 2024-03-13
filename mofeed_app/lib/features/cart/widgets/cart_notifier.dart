import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_cubit.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_state.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class CartNotifier extends StatelessWidget {
  const CartNotifier({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      final items = state.cart.items;
      final itemsCount = state.cart.items.length;
      final cartTotal = state.cart.cartTotal;
      return Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: PrimaryButton(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          onPress: items.isEmpty
              ? null
              : () => context.navigateTo(routeName: FoodRoutes.cartScreen),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm, horizontal: AppSpacing.lg),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: 4.circle),
                child: Text(itemsCount.toString(),
                    style: context.button.copyWith(color: Colors.white)),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                l10n.viewCart,
                style: context.headlineSmall.copyWith(color: Colors.white),
              ),
              const Spacer(),
              Text(
                cartTotal.toPrice(context.lang),
                style: context.headlineSmall.copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      );
    });
  }
}
