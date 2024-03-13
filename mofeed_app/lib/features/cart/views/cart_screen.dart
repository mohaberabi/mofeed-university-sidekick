import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_cubit.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_state.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final l10n = context.l10n;
    return BlocConsumer<CartCubit, CartState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(l10n.cart),
              actions: [
                IconButton(
                    onPressed: () {
                      cartCubit.clear();
                      context.pop();
                    },
                    icon: const Icon(Icons.delete_outline_rounded))
              ],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              height: 90,
              child: PrimaryButton(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                onPress: () =>
                    context.navigateTo(routeName: FoodRoutes.checkoutScreen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.confirmOrder,
                      style: context.titleLarge.copyWith(color: Colors.white),
                    ),
                    Text(
                      state.cart.cartTotal.toPrice(context.lang),
                      style: context.titleLarge.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            body: CustomScrollView(
              slivers: [
                ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = state.cart.items.values.toList()[index];
                    return CartItemWidget(
                      item: item,
                      onInc: () => cartCubit.incQty(item.id),
                      onDec: () {
                        cartCubit.decQty(item.id);
                        if (state.cart.items.isEmpty) {
                          context.pop();
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemCount: state.cart.items.length,
                ).toSliver,
                const _CartCommneter().toSliver,
              ],
            ),
          );
        },
        listener: (context, state) {});
  }

  static const Widget cart = _CartButton();
}

class _CartCommneter extends StatelessWidget {
  const _CartCommneter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.specialRequest, style: context.titleLarge),
          CustomTextField(
              maxLines: null,
              filled: false,
              isColumed: false,
              border: InputBorder.none,
              collapsed: true,
              isOutlined: false,
              onChanged: (v) {},
              hintStyle: context.bodyLarge.copyWith(color: Colors.grey),
              hint: l10n.anySpecialRequest,
              prefix: const Icon(Icons.mode_comment_outlined, size: 24))
        ],
      ),
    );
  }
}

class _CartButton extends StatelessWidget {
  const _CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      return state.cart.items.isEmpty
          ? const SizedBox()
          : GestureDetector(
              onTap: () => context.navigateTo(routeName: FoodRoutes.cartScreen),
              child: Badge(
                backgroundColor: AppColors.primColor,
                label: Text(state.cart.items.length.recap),
                textColor: Colors.white,
                smallSize: 16,
                largeSize: 22,
                offset: const Offset(0, 10),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                textStyle: context.button.copyWith(color: Colors.white),
                child: const Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: AppIcon(AppIcons.cart)),
              ),
            );
    });
  }
}
