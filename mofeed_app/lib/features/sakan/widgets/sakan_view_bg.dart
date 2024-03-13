import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/widgets/cached_image.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:sakan/model/mate_wanted.dart';
import 'package:sakan/model/sakan_model.dart';

class SakanViewBG extends StatelessWidget {
  final Sakan sakan;

  const SakanViewBG({
    super.key,
    required this.sakan,
  });

  @override
  Widget build(BuildContext context) {
    final images = sakan is MateWanted
        ? [...(sakan as MateWanted).roomImages]
        : [sakan.cover];
    return GestureDetector(
      onTap: () =>
          context.navigateTo(routeName: AppRoutes.imageViewer, args: images),
      child: PageView.builder(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return Hero(
            tag: sakan.id,
            child: CachedImage(
              imageUrl: image,
              decorated: true,
              boxFit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
