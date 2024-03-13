import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/theme/theme_ext.dart';
import 'package:mofeed_shared/ui/widgets/custom_shimmer.dart';
import 'package:mofeed_shared/utils/enums/restarant.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class OrderProgressWidget extends StatelessWidget {
  final OrderStatus status;

  const OrderProgressWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        final isDone = status.index >= index;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isDone
                ? Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: 8.circle,
                      color: status.index >= index
                          ? AppColors.primColor
                          : Colors.grey.shade300,
                    ),
                  )
                : CustomShimmer(
                    h: 8,
                    baseColor: context.theme.shimmerBaseColor,
                    higlightColor: context.theme.shimmerHighlightColor,
                  ),
          ),
        );
      }),
    );
  }
}
