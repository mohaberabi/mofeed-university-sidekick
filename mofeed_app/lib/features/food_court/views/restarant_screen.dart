import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/core/widgets/shimmer_builder.dart';
import 'package:mofeduserpp/core/widgets/sliver_scafolld.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_cubit.dart';
import 'package:mofeduserpp/features/cart/widgets/cart_notifier.dart';
import 'package:mofeduserpp/features/favorite/widget/favorite_detector.dart';
import 'package:mofeduserpp/features/food_court/cubit/food_court_cubit/foodcourt_cubit.dart';
import 'package:mofeduserpp/features/food_court/cubit/food_court_cubit/foodcourt_state.dart';
import 'package:mofeduserpp/features/food_item/screens/item_screen.dart';
import 'package:mofeduserpp/features/food_item/widgets/item_widget.dart';
import 'package:mofeduserpp/features/food_court/widgets/restarant_card.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/ui/widgets/cached_image.dart';
import 'package:mofeed_shared/ui/widgets/conditioner.dart';
import 'package:mofeed_shared/ui/widgets/custom_shimmer.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import '../../../core/widgets/empty_scaffold.dart';

class RestaurantScreen extends StatelessWidget {
  final String restaurantId;

  const RestaurantScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    final foodCourtCubit = context.read<FoodCourtCubit>();

    return BlocBuilder<FoodCourtCubit, FoodCourtState>(
      builder: (context, state) {
        return state.state.child(
          doneChild: Conditioner(
            condition: state.restaurantDetail != null,
            builder: (notNull) {
              if (notNull) {
                final restaurantDetail = state.restaurantDetail!;
                final restaurant = restaurantDetail.first;
                final items = restaurantDetail.second;
                final categories = restaurantDetail.third;
                return DefaultTabController(
                    length: categories.length,
                    child: SliverScaffold(
                      expandedHeight: 250,
                      actions: [
                        FavoriteDetector(
                            type: FavoriteType.restarant, id: restaurantId),
                      ],
                      bootomNavBar: const CartNotifier(),
                      innerSrollables: [
                        RestarantCard(restarant: restaurant, isMini: true)
                            .toSliver,
                      ],
                      background: CachedImage(
                        h: 200,
                        w: double.infinity,
                        imageUrl: restaurant.logo,
                        decorated: true,
                        boxFit: BoxFit.cover,
                      ),
                      title: Text(restaurant.name[context.lang]),
                      collapsedWidget: TabBar(
                        tabs: categories
                            .map((e) => Tab(text: e.name[context.lang]))
                            .toList(),
                        isScrollable: true,
                      ),
                      listenable: (collapsed) {
                        return Expanded(
                          child: TabBarView(
                              children: categories.map((cat) {
                            final correspondingItems = items
                                .where(
                                    (element) => element.categoryId == cat.id)
                                .toList();

                            return CustomScrollView(
                              slivers: [
                                ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  padding: EdgeInsets.only(
                                      top:
                                          collapsed ? context.height * 0.2 : 0),
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final item = correspondingItems[index];
                                    return ItemWidget(
                                        item: item,
                                        onTap: () => _goToItemScreen(
                                            itemId: item.id,
                                            context: context,
                                            restId: restaurantId));
                                  },
                                  itemCount: correspondingItems.length,
                                ).toSliver,
                              ],
                            );
                          }).toList()),
                        );
                      },
                    ));
              } else {
                return AppPlaceHolder.error(
                  onTap: () => foodCourtCubit.getRestaurantDetail(restaurantId),
                );
              }
            },
          ),
          errorChild: const EmptyScaffold(child: Loader()),
          loadingChild: const EmptyScaffold(child: _Shimmer()),
        );
      },
    );
  }

  void _goToItemScreen({
    required String restId,
    required String itemId,
    required BuildContext context,
  }) =>
      context.navigateTo(
          routeName: FoodRoutes.variableItemScreen,
          args: FoodItemScreen(
            itemId: itemId,
            restaurantId: restId,
          ));
}

class _Shimmer extends StatelessWidget {
  const _Shimmer({super.key});

  static const _count = 10;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const CustomShimmer(w: double.infinity, h: 150),
        const ShimmerBuilder(
          isList: false,
          data: [
            ShimmerData(300, 16, 15),
            ShimmerData(200, 14, 15),
            ShimmerData(175, 12, 15),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(_count, (index) {
              return const ShimmerBuilder(
                isList: false,
                trailing: ShimmerData(110, 110, 15),
                data: [
                  ShimmerData(250, 16, 15),
                  ShimmerData(175, 14, 15),
                  ShimmerData(136, 12, 15),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }
}
