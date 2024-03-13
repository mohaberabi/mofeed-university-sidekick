import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/theme/theme_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:shimmer/shimmer.dart';

import '../colors/app_colors.dart';

class CustomShimmer extends StatelessWidget {
  final double? w;
  final double? h;
  final Widget? child;
  final Color? baseColor;
  final Color? higlightColor;
  final double radius;

  const CustomShimmer({
    Key? key,
    this.h,
    this.w,
    this.higlightColor,
    this.child,
    this.baseColor,
    this.radius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction:
          context.lang == 'ar' ? ShimmerDirection.rtl : ShimmerDirection.ltr,
      highlightColor: higlightColor ?? context.theme.shimmerHighlightColor,
      baseColor: baseColor ?? context.theme.shimmerBaseColor,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primColor.withOpacity(0.5),
          borderRadius: radius.circle,
        ),
        width: w,
        height: h,
        child: child,
      ),
    );
  }
}
