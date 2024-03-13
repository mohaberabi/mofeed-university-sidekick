import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/widgets/custom_shimmer.dart';

class ShimmerBuilder extends StatelessWidget {
  final ShimmerData? leading;

  final List<ShimmerData> data;

  final ShimmerData? trailing;

  final bool isList;

  final CrossAxisAlignment? parentCrossAxis;
  final MainAxisAlignment? parentMainAxis;
  final MainAxisAlignment? dataMainAxis;
  final CrossAxisAlignment? dataCrossAxis;

  const ShimmerBuilder({
    super.key,
    this.leading,
    this.trailing,
    this.data = const [],
    this.parentCrossAxis,
    this.parentMainAxis,
    this.dataMainAxis,
    this.dataCrossAxis,
    this.isList = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _parent(
        children: [
          if (leading != null) _protoType(leading!),
          isList ? _dataBuilder() : Expanded(child: _dataBuilder()),
          if (trailing != null) _protoType(trailing!)
        ],
      ),
    );
  }

  Widget _dataBuilder() {
    return Column(
      crossAxisAlignment: dataCrossAxis ?? CrossAxisAlignment.start,
      mainAxisAlignment: dataMainAxis ?? MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: data.map((e) => _protoType(e)).toList(),
    );
  }

  Widget _parent({
    required List<Widget> children,
  }) {
    if (isList) {
      return Column(
        crossAxisAlignment: parentCrossAxis ?? CrossAxisAlignment.start,
        mainAxisAlignment: parentMainAxis ?? MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    } else {
      return Row(
        crossAxisAlignment: parentCrossAxis ?? CrossAxisAlignment.start,
        mainAxisAlignment: parentMainAxis ?? MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }

  Widget _protoType(ShimmerData shimmer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: CustomShimmer(
        w: shimmer.width,
        h: shimmer.height,
        radius: shimmer.borderRadius,
      ),
    );
  }
}

class ShimmerData {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerData(this.width, this.height, this.borderRadius);
}
