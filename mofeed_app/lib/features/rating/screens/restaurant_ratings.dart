import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/rating/cubit/rating_cubit.dart';
import 'package:mofeduserpp/features/rating/cubit/rating_state.dart';
import 'package:mofeed_shared/ui/widgets/app_view_builder.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/ui/widgets/rating_card.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class RestaurantRatingScreen extends StatelessWidget {
  final String restaruantId;

  const RestaurantRatingScreen({
    super.key,
    required this.restaruantId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reviews),
      ),
      body: BlocBuilder<RatingCubit, RatingState>(
        builder: (context, state) {
          return state.status.builder({
            RatingStatus.loading: () => const Loader(),
            RatingStatus.error: () => AppPlaceHolder.error(
                title: l10n.localizeError(state.error),
                onTap: () => _getRatings(context)),
            RatingStatus.populated: () => AppViewBuilder.list(
                onRefresh: () async => _getRatings(context),
                onMax: () async => _getRatings(context, loadBefore: false),
                seprator: (context, index) => const Divider(
                      thickness: 0.25,
                      color: Colors.grey,
                    ),
                builder: (context, index) {
                  final rating = state.ratings[index];
                  return RatingCard(rating: rating);
                },
                count: state.ratings.length,
                placeHolder: AppPlaceHolder.empty(
                  title: l10n.restaurantHasNoReviews,
                  subtitle: l10n.makeOrderToReview,
                ))
          });
        },
      ),
    );
  }

  void _getRatings(
    BuildContext context, {
    bool loadBefore = true,
  }) =>
      context
          .read<RatingCubit>()
          .getRatings(restaurantId: restaruantId, loadBefore: loadBefore);
}
