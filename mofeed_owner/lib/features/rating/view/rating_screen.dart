import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/features/rating/cubit/rating_cubit.dart';
import 'package:mofeed_owner/features/rating/cubit/rating_state.dart';
import 'package:mofeed_shared/widgets/app_view_builder.dart';
import 'package:mofeed_shared/widgets/loader.dart';
import 'package:mofeed_shared/widgets/my_place_holder.dart';
import 'package:mofeed_shared/widgets/rating_card.dart';

import '../../../shared/sl/service_locator.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late RatingCubit ratingCubit;

  @override
  void dispose() {
    ratingCubit.clear();
    super.dispose();
  }

  @override
  void initState() {
    ratingCubit = sl<RatingCubit>()..getRatings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ratings"),
      ),
      body: BlocBuilder<RatingCubit, RatingState>(builder: (context, state) {
        return state.state.builder(
            onLoading: () => const Loader(),
            onError: () =>
                AppPlaceHolder.error(onTap: () => ratingCubit.getRatings()),
            onDone: () {
              return AppViewBuilder.list(
                  onRefresh: () async => ratingCubit.getRatings(),
                  onMax: () async => ratingCubit.getRatings(loadBefore: false),
                  builder: (context, index) {
                    final rating = state.ratings[index];
                    return RatingCard(rating: rating);
                  },
                  count: state.ratings.length,
                  placeHolder: AppPlaceHolder.empty(
                    title: "You didn\'t recieve any reviews yet ",
                    subtitle:
                        'Once customer leaves a review it will appear here',
                  ));
            });
      }),
    );
  }
}
