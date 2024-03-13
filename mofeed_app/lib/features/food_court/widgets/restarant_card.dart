import 'package:flutter/material.dart';
import 'package:food_court/model/restaurant_model.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/features/favorite/widget/favorite_detector.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/cached_image.dart';
import 'package:mofeed_shared/ui/widgets/text_icon.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class RestarantCard extends StatelessWidget {
  final RestarantModel restarant;
  final VoidCallback? onTap;
  final bool isMini;

  const RestarantCard({
    Key? key,
    required this.restarant,
    this.onTap,
    this.isMini = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (isMini) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              restarant.name[context.lang],
              style: context.headlineMedium,
            ),
            Text(
              restarant.cusinesRecap(context.lang),
              maxLines: 2,
              style: context.bodyLarge.copyWith(color: Colors.grey.shade700),
            ),
            Row(
              children: [
                const SizedBox(width: AppSpacing.sm),
                _delInfo(context),
                const Spacer(),
                _ratings(context),
                Text(
                  '${restarant.ratingCount} ${l10n.users}',
                  style: context.bodyLarge.copyWith(color: Colors.grey),
                ),
                const SizedBox(width: AppSpacing.xs),
                GestureDetector(
                  child: Text(
                    l10n.reviews,
                    style: context.bodyLarge
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                  onTap: () => context.navigateTo(
                    routeName: FoodRoutes.restaurnatRatings,
                    args: restarant.id,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    } else {
      return Opacity(
        opacity: 1,
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FavoriteDetector(
                id: restarant.id,
                type: FavoriteType.restarant,
                child: CachedImage(
                    h: 150,
                    radius: 20,
                    w: 136,
                    imageUrl: restarant.logo,
                    decorated: true,
                    boxFit: BoxFit.cover),
              ),
              const SizedBox(width: AppSpacing.sm),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      child: Text(restarant.name[context.lang],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.titleLarge),
                    ),
                    SizedBox(
                      width: context.width * 0.8,
                      child: Text(restarant.cusinesRecap(context.lang),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodyLarge.copyWith(
                              color: Colors.grey.shade500, fontSize: 16)),
                    ),
                    Row(
                      children: [
                        TextIcon.svg(
                          text: restarant.averageRating.toStringAsFixed(1),
                          path: AppIcons.star,
                          style: context.titleLarge
                              .copyWith(color: AppColors.primColor),
                          color: AppColors.primColor,
                          iconFirst: true,
                        ),
                        if (restarant.offersDelivery)
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: AppSpacing.md),
                            child: AppIcon(AppIcons.moto,
                                color: AppColors.primColor),
                          ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget _delInfo(BuildContext context) {
    return TextIcon.svg(
      text: context.l10n.facultyHanodver,
      path: AppIcons.moto,
      style: context.titleLarge.copyWith(color: AppColors.primColor),
      color: AppColors.primColor,
      iconFirst: true,
    );
  }

  Widget _ratings(BuildContext context) {
    return TextIcon.svg(
      text: restarant.averageRating.toStringAsFixed(1),
      path: AppIcons.star,
      iconFirst: true,
      size: 18,
      style: context.titleLarge.copyWith(color: AppColors.primColor),
      color: AppColors.primColor,
    );
  }

  Widget time(BuildContext context) {
    return Row(
      children: [
        const AppIcon(AppIcons.clock, size: AppSpacing.lg),
        const SizedBox(width: AppSpacing.xxs),
        Text(
          '${restarant.minPickupTime.toStringAsFixed(0)} ${context.l10n.mins}',
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
