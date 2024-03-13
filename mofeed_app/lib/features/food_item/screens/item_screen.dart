import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/model/food_option.dart';
import 'package:food_court/model/option_group.dart';
import 'package:mofeduserpp/core/widgets/sliver_scafolld.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_cubit.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_state.dart';
import 'package:mofeduserpp/features/food_item/widgets/choice_widget.dart';
import 'package:mofeduserpp/features/food_court/widgets/inc_dec_qty.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/cached_image.dart';
import 'package:mofeed_shared/ui/widgets/conditioner.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import '../../../core/services/service_lcoator.dart';
import '../../../core/widgets/empty_scaffold.dart';
import '../cubit/food_item_state.dart';
import '../cubit/fooditem_cubit.dart';

class FoodItemScreen extends StatelessWidget {
  final String itemId;
  final String restaurantId;

  const FoodItemScreen({
    Key? key,
    required this.itemId,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foodItemCubit = context.read<FoodItemCubit>();

    final local = context.l10n;
    const divider = Divider(thickness: 3);
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state.state.isRestaurantChanged) {
              // _showCartDialog();
            } else if (state.state.isAddedToCart) {
              Navigator.pop(context);
            }
          },
        ),
      ],
      child: BlocBuilder<FoodItemCubit, FoodItemState>(
        builder: (context, state) {
          return state.state.child(
              doneChild: Conditioner(
                condition: state.itemWithVariants == null,
                builder: (nullData) {
                  if (nullData) {
                    return EmptyScaffold(
                        child: AppPlaceHolder.error(
                            title: local.localizeError(state.error),
                            onTap: () => foodItemCubit.getItem(
                                id: itemId, restaurantId: restaurantId)));
                  } else {
                    final item = state.itemWithVariants!.first;
                    final variants = state.itemWithVariants!.second;
                    final String buttonString = state.buttonString is String
                        ? state.buttonString
                        : (state.buttonString as double).toPrice(context.lang);
                    addToCart() {
                      context.read<CartCubit>().addToCart(
                          image: item.image,
                          restaurantId: restaurantId,
                          name: item.name,
                          id: item.id,
                          options: state.optionsFolded,
                          itemPrice: state.wholePrice,
                          qty: state.qty);
                    }

                    return SliverScaffold(
                      collapsedWidgetHeight: 0,
                      expandedHeight: 120,
                      bootomNavBar: Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        height: 80,
                        child: PrimaryButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg),
                          onPress: state.readyToCart ? () => addToCart() : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(context.l10n.addToCart,
                                  style: context.titleLarge
                                      .copyWith(color: Colors.white)),
                              Text(buttonString,
                                  style: context.titleLarge
                                      .copyWith(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      title: Text(item.name[context.lang]),
                      background: CachedImage(
                          imageUrl: item.image,
                          decorated: false,
                          h: 100,
                          boxFit: BoxFit.cover),
                      body: CustomScrollView(
                        slivers: [
                          const SizedBox(height: AppSpacing.md).toSliver,
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg),
                            sliver: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name[context.lang],
                                    style: context.headlineSmall),
                                Text(item.describtion[context.lang],
                                    style: context.bodyLarge),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _price(state.wholePrice,
                                            lang: context.lang),
                                        style: context.bodyLarge.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    QtyAdapter(
                                        onAdd: () => foodItemCubit.incQty(),
                                        onRemove: () => foodItemCubit.decQty(),
                                        qty: state.qty)
                                  ],
                                ),
                                divider,
                              ],
                            ).toSliver,
                          ),
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (context, parentIdx) {
                            final variant = variants[parentIdx];
                            return GroupOptionsBuilder(
                                parent: variant,
                                onVariantChoseed: (child) => _chooseOption(
                                    context: context,
                                    child: child,
                                    variant: variant),
                                selected: (child) {
                                  return state.options[variant]
                                          ?.contains(child) ??
                                      false;
                                });
                          }, childCount: variants.length)),
                          if (item.isVariable) divider.toSliver,
                          const _SpeicalRequest().toSliver
                        ],
                      ),
                    );
                  }
                },
              ),
              errorChild: EmptyScaffold(
                child: AppPlaceHolder.error(
                    title: local.localizeError(state.error),
                    onTap: () => foodItemCubit.getItem(
                        id: itemId, restaurantId: restaurantId)),
              ),
              loadingChild: const EmptyScaffold(child: Loader()));
        },
      ),
    );
  }

  void _chooseOption({
    required FoodOption child,
    required OptionGroup variant,
    required BuildContext context,
  }) =>
      context.read<FoodItemCubit>().pikcupOption(value: child, key: variant);

  String _price(dynamic val, {required String lang}) {
    if (val is String) {
      return val.toString();
    } else if (val is num) {
      return val.toPrice(lang);
    }
    return "";
  }
}

class _SpeicalRequest extends StatelessWidget {
  const _SpeicalRequest({Key? key}) : super(key: key);

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
              prefix: const Icon(
                Icons.mode_comment_outlined,
                size: 24,
              ))
        ],
      ),
    );
  }
}
