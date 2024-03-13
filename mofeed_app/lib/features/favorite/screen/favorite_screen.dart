import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/model/restaurant_model.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/features/favorite/cubit/favorite_cubit.dart';
import 'package:mofeduserpp/features/favorite/cubit/favorite_state.dart';
import 'package:mofeduserpp/features/food_court/widgets/restarant_card.dart';
import 'package:mofeduserpp/features/sakan/widgets/sakan_card.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/app_view_builder.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import 'package:sakan/model/sakan_model.dart';
import 'package:sakan/routes/sakan_routes.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteCubit favoriteCubit;

  @override
  void initState() {
    super.initState();
    favoriteCubit = context.read<FavoriteCubit>()..getFavorites();
  }

  @override
  void dispose() {
    super.dispose();
    favoriteCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        appBar: AppBar(title: Text(l10n.favorites)),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
          final view = Expanded(
            child: AppViewBuilder.list(
              padding: const EdgeInsets.all(AppSpacing.lg),
              builder: (context, index) {
                final fav = state.favorites[index];
                switch (state.type) {
                  case FavoriteType.restarant:
                    return RestarantCard(
                        onTap: () => context.navigateTo(
                            routeName: FoodRoutes.restarantScreen,
                            args: (fav).id),
                        restarant: fav as RestarantModel);
                  case FavoriteType.mateWanted:
                  case FavoriteType.roomWanted:
                    return GestureDetector(
                      onTap: () => context.navigateTo(
                          routeName: SakanRoutes.viewSakanScreen, args: fav),
                      child: SakanCard(
                        sakan: fav as Sakan,
                      ),
                    );
                }
              },
              count: state.favorites.length,
              placeHolder: AppPlaceHolder.empty(title: l10n.noFavorites),
            ),
          );
          return Column(
            children: [
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: FavoriteType.values.map((e) {
                    final bool selected = e == state.type;
                    return Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: ActionChip(
                        avatar: AppIcon(e.path,
                            color:
                                selected ? AppColors.primColor : Colors.grey),
                        backgroundColor: context.theme.scaffoldBackgroundColor,
                        padding: const EdgeInsets.all(AppSpacing.xxxs),
                        label: const SizedBox(),
                        onPressed: () => favoriteCubit.typeChanged(e),
                        shape: RoundedRectangleBorder(
                          borderRadius: 4.circle,
                          side: BorderSide(
                              color:
                                  selected ? AppColors.primColor : Colors.grey,
                              width: selected ? 2.3 : 1),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              state.state.builder({
                FavoriteStatus.loadingData: () => const Loader(),
                FavoriteStatus.error: () => AppPlaceHolder.error(
                    onTap: () => favoriteCubit.getFavoriteData()),
                FavoriteStatus.populated: () => view,
              }, placeHolder: view)
            ],
          );
        }));
  }
}
