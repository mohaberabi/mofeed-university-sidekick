import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/features/restraurant/cubit/restarant_cubit.dart';
import 'package:mofeed_owner/features/restraurant/cubit/restarant_state.dart';
import 'package:mofeed_owner/shared/router/app_routes.dart';
import 'package:mofeed_shared/constants/app_icons.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/style/app_colors.dart';
import 'package:mofeed_shared/widgets/cta.dart';
import 'package:mofeed_shared/widgets/text_icon.dart';

import '../../../shared/sl/service_locator.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const _RestInfo(),
        CallToAction.custom(
          title: "Restaurant Information",
          action: () => navigateTo(context, routeName: Routes.restarantInfo),
          leading: const AppIcon(AppIcons.info),
        ),
        CallToAction.custom(
          title: "Items",
          action: () => navigateTo(context, routeName: Routes.itemsScreen),
          leading: const AppIcon(AppIcons.pizza),
        ),
        CallToAction.custom(
          title: "Categories",
          action: () => navigateTo(context, routeName: Routes.categoryScreen),
          leading: const AppIcon(AppIcons.category),
        ),
        CallToAction.custom(
          title: "Items Options",
          action: () =>
              navigateTo(context, routeName: Routes.foodOptionsScreen),
          leading: const AppIcon(AppIcons.peper),
        ),
        CallToAction.custom(
          title: "Gallery ",
          action: () => navigateTo(context, routeName: Routes.gallery),
          leading: const AppIcon(AppIcons.gallery),
        ),
        CallToAction.custom(
          title: "Ratings & Reviews",
          action: () => navigateTo(context, routeName: Routes.ratingsScreen),
          leading: const AppIcon(AppIcons.star),
        ),
      ],
    );
  }
}

class _RestInfo extends StatefulWidget {
  const _RestInfo({super.key});

  @override
  State<_RestInfo> createState() => _RestInfoState();
}

class _RestInfoState extends State<_RestInfo> {
  late RestarantCubit restarantCubit;

  @override
  void initState() {
    restarantCubit = sl<RestarantCubit>()..getRestuanrt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestarantCubit, RestarantState>(
      builder: (context, state) {
        final rest = state.restarant;
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rest.name[context.lang] ?? '',
                style: context.displaySmall,
              ),
              Row(
                children: [
                  TextIcon.svg(
                    path: AppIcons.star,
                    color: AppColors.primColor,
                    text: rest.averageRating.toStringAsFixed(1),
                    iconFirst: true,
                    style: context.bodyLarge.copyWith(fontSize: 16),
                  ),
                  Text(
                    "${rest.ratingCount} Users",
                    style: context.bodyLarge.copyWith(
                        color: Colors.grey,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
