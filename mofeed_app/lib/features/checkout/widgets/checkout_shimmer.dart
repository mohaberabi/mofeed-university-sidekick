import 'package:flutter/material.dart';
import 'package:mofeduserpp/core/widgets/shimmer_builder.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/custom_shimmer.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';

class CheckoutShimmer extends StatelessWidget {
  const CheckoutShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      header,
      footer,
      ...List.generate(
        _count,
        (index) => const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBuilder(
              isList: false,
              data: [
                ShimmerData(200, 12, 8),
                ShimmerData(136, 8, 8),
              ],
              leading: ShimmerData(46, 46, 6),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: CustomShimmer(
          w: context.width,
          h: 50,
          radius: 26,
        ),
      ),
    ]);
  }

  static const _count = 5;
  static const header = Padding(
      padding: EdgeInsets.all(AppSpacing.sm),
      child: CustomShimmer(w: 275, h: 16));
  static const footer = Padding(
      padding: EdgeInsets.all(AppSpacing.sm),
      child: CustomShimmer(w: 185, h: 12));
}
