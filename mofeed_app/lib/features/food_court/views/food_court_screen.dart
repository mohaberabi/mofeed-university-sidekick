import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/routes/food_routes.dart';
import 'package:mofeduserpp/core/widgets/shimmer_builder.dart';
import 'package:mofeduserpp/features/food_court/cubit/food_court_cubit/foodcourt_cubit.dart';
import 'package:mofeduserpp/features/food_court/cubit/food_court_cubit/foodcourt_state.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/app_view_builder.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import '../../../core/services/service_lcoator.dart';
import '../widgets/restarant_card.dart';

class FoodCourtScreen extends StatelessWidget {
  const FoodCourtScreen({Key? key}) : super(key: key);
  static const shimmer = ShimmerBuilder(
    isList: false,
    parentCrossAxis: CrossAxisAlignment.center,
    dataCrossAxis: CrossAxisAlignment.start,
    data: [
      ShimmerData(200, 22, 16),
      ShimmerData(175, 18, 16),
      ShimmerData(136, 16, 16),
    ],
    leading: ShimmerData(135, 166, 16),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => sl<FoodCourtCubit>()..getRestaruants(),
      child: BlocBuilder<FoodCourtCubit, FoodCourtState>(
        builder: (context, state) {
          return state.state.child(
              doneChild: AppViewBuilder.list(
                seprator: (context, index) =>
                    const SizedBox(height: AppSpacing.lg),
                padding: const EdgeInsets.all(AppSpacing.md),
                onRefresh: () async => _getRestaruants(context),
                builder: (context, index) {
                  final restarant = state.restaurants[index];
                  return RestarantCard(
                      restarant: restarant,
                      onTap: () =>
                          _onRestaruantTap(id: restarant.id, context: context));
                },
                count: state.restaurants.length,
                placeHolder: AppPlaceHolder.empty(
                    title: context.l10n.noRestaurantsUseMofeed),
              ),
              errorChild: AppPlaceHolder.error(
                title: l10n.localizeError(state.error),
                onTap: () => _getRestaruants(context),
              ),
              loadingChild: const _Shimmer());
        },
      ),
    );
  }

  void _onRestaruantTap({
    required String id,
    required BuildContext context,
  }) {
    context.navigateTo(routeName: FoodRoutes.restarantScreen, args: id);
  }

  void _getRestaruants(BuildContext context) =>
      context.read<FoodCourtCubit>().getRestaruants();
}

class _Shimmer extends StatelessWidget {
  static const _count = 10;

  const _Shimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(
        _count,
        (index) {
          return FoodCourtScreen.shimmer;
        },
      ),
    );
  }
}
