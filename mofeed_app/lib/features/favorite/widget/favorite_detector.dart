import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import '../cubit/favorite_cubit.dart';
import '../cubit/favorite_state.dart';

class FavoriteDetector extends StatelessWidget {
  final Widget? child;
  final FavoriteType type;
  final double? iconSize;

  final Color? backgroundColor;

  final String id;

  const FavoriteDetector({
    super.key,
    required this.type,
    required this.id,
    this.child,
    this.iconSize,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      return _Detector(
        type: type,
        id: id,
        iconSize: iconSize,
        child: child,
      );
    }
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        child!,
        _Detector(
          backgroundColor: backgroundColor,
          type: type,
          id: id,
          iconSize: iconSize,
          child: child,
        ),
      ],
    );
  }
}

class _Detector extends StatelessWidget {
  final Widget? child;
  final FavoriteType type;
  final double? iconSize;
  final Color? backgroundColor;

  final String id;

  const _Detector({
    super.key,
    required this.child,
    required this.type,
    required this.id,
    this.iconSize,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(builder: (context, state) {
      final fav = state.isFavorite(type.name, id);
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: CircleAvatar(
          radius: iconSize ?? AppSpacing.lg,
          backgroundColor:
              backgroundColor ?? context.theme.scaffoldBackgroundColor,
          child: IconButton(
            onPressed: () =>
                context.read<FavoriteCubit>().addToFavorite(type: type, id: id),
            icon: Icon(
              fav ? Icons.favorite : Icons.favorite_border,
              color: fav ? AppColors.primColor : Colors.grey,
              size: iconSize ?? AppSpacing.lg,
            ),
          ),
        ),
      );
    });
  }
}
