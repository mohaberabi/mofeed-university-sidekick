import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/widgets/pagination_builder.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class ComplexScrollView extends StatelessWidget {
  final Future<void> Function() onMax;
  final Future<void> Function() onRefresh;
  final List<Widget> children;

  const ComplexScrollView({
    super.key,
    required this.onMax,
    required this.onRefresh,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return PaginationBuilder(
      builder: (ScrollController controller) {
        return RefreshIndicator.adaptive(
          onRefresh: onRefresh,
          child: CustomScrollView(
              controller: controller,
              slivers: children.map((e) => e.toSliver).toList()),
        );
      },
      onMax: onMax,
    );
  }
}
