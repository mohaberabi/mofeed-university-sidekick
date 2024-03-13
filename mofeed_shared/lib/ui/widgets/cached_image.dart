import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/widgets/custom_shimmer.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? w;
  final BoxFit boxFit;
  final double? h;
  final bool decorated;
  final Widget? errorHolder;
  final double radius;
  final BoxShape shape;
  final Widget? loadingHolder;

  const CachedImage({
    Key? key,
    required this.imageUrl,
    this.w,
    required this.decorated,
    this.h,
    required this.boxFit,
    this.errorHolder,
    this.loadingHolder,
    this.radius = 0,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: radius.circle,
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: boxFit,
        filterQuality: FilterQuality.low,
        placeholderFadeInDuration: Duration.zero,
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        width: w,
        height: h,
        errorWidget: (context, url, error) {
          return errorHolder ?? buildPlaceHolder();
        },
        placeholder: (context, url) {
          return loadingHolder ?? buildPlaceHolder();
        },
      ),
    );
  }

  Widget buildPlaceHolder() => CustomShimmer(
        h: h ?? 50,
        w: w ?? 50,
        radius: radius,
      );
}
