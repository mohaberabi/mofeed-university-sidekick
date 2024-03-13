import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/widgets/pagination_builder.dart';

class AppViewBuilder extends StatelessWidget {
  final Widget Function(BuildContext, int) _builder;
  final Widget Function(BuildContext, int)? _seprator;

  final int _count;
  final bool _isList;
  final Widget _placeHolder;
  final ScrollController? _controller;
  final SliverGridDelegate _sliverGridDelegate;
  final double? _itemExtent;
  final EdgeInsets? _padding;
  final ScrollPhysics? _scrollPhysics;
  final Future<void> Function()? _onRefresh;
  final Future<void> Function()? _onMax;
  final bool? _shrinkWrap;

  final bool? _isPrimary;

  const AppViewBuilder._({
    super.key,
    Future<void> Function()? onMax,
    Future<void> Function()? onRefresh,
    Widget Function(BuildContext, int)? seprator,
    required Widget Function(BuildContext, int) builder,
    required int count,
    required Widget placeHolder,
    ScrollController? controller,
    double? itemExtent,
    SliverGridDelegate sliverGridDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    bool isList = true,
    EdgeInsets? padding,
    ScrollPhysics? scrollPhysics,
    bool? shrinkWrap,
    bool? primary,
  })  : _builder = builder,
        _shrinkWrap = shrinkWrap,
        _isPrimary = primary,
        _seprator = seprator,
        _padding = padding,
        _count = count,
        _isList = isList,
        _placeHolder = placeHolder,
        _sliverGridDelegate = sliverGridDelegate,
        _itemExtent = itemExtent,
        _scrollPhysics = scrollPhysics,
        _onRefresh = onRefresh,
        _onMax = onMax,
        _controller = controller;

  const AppViewBuilder.list({
    Key? key,
    required Widget Function(BuildContext, int) builder,
    required int count,
    required Widget placeHolder,
    ScrollController? controller,
    double? itemExtent,
    EdgeInsets? padding,
    ScrollPhysics? scrollPhysics,
    Future<void> Function()? onRefresh,
    Future<void> Function()? onMax,
    Widget Function(BuildContext, int)? seprator,
    bool? shrinkWrap,
    bool? primary,
  }) : this._(
            shrinkWrap: shrinkWrap,
            primary: primary,
            onMax: onMax,
            scrollPhysics: scrollPhysics,
            key: key,
            isList: true,
            builder: builder,
            count: count,
            controller: controller,
            itemExtent: itemExtent,
            placeHolder: placeHolder,
            padding: padding,
            onRefresh: onRefresh,
            seprator: seprator);

  const AppViewBuilder.grid({
    Key? key,
    required Widget Function(BuildContext, int) builder,
    required int count,
    required Widget placeHolder,
    ScrollController? controller,
    EdgeInsets? padding,
    ScrollPhysics? scrollPhysics,
    Future<void> Function()? onMax,
    SliverGridDelegate sliverGridDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    Future<void> Function()? onRefresh,
    bool? shrinkWrap,
    bool? primary,
  }) : this._(
          shrinkWrap: shrinkWrap,
          primary: primary,
          onRefresh: onRefresh,
          scrollPhysics: scrollPhysics,
          sliverGridDelegate: sliverGridDelegate,
          key: key,
          isList: false,
          builder: builder,
          count: count,
          controller: controller,
          placeHolder: placeHolder,
          padding: padding,
          onMax: onMax,
        );

  @override
  Widget build(BuildContext context) {
    if (_count == 0) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _placeHolder,
        ],
      ));
    } else {
      return _onMax != null
          ? PaginationBuilder(
              builder: (controller) {
                return _refresher(controller: controller);
              },
              onMax: _onMax!)
          : _refresher(controller: _controller);
    }
  }

  Widget _refresher({ScrollController? controller}) {
    if (_onRefresh != null) {
      return RefreshIndicator.adaptive(
        onRefresh: _onRefresh!,
        child: _view(controller: controller),
      );
    } else {
      return _view(controller: controller);
    }
  }

  Widget _view({
    ScrollController? controller,
  }) {
    if (_isList) {
      if (_seprator != null) {
        return ListView.separated(
          shrinkWrap: _shrinkWrap ?? false,
          physics: _scrollPhysics ?? const AlwaysScrollableScrollPhysics(),
          primary: _isPrimary,
          separatorBuilder: _seprator!,
          padding: _padding,
          itemCount: _count,
          controller: controller,
          itemBuilder: _builder,
        );
      } else {
        return ListView.builder(
          shrinkWrap: _shrinkWrap ?? false,
          physics: _scrollPhysics ?? const AlwaysScrollableScrollPhysics(),
          primary: _isPrimary,
          padding: _padding,
          itemExtent: _itemExtent,
          itemCount: _count,
          controller: controller,
          itemBuilder: _builder,
        );
      }
    } else {
      return GridView.builder(
        primary: _isPrimary,
        shrinkWrap: _shrinkWrap ?? false,
        physics: _scrollPhysics ?? const AlwaysScrollableScrollPhysics(),
        padding: _padding,
        itemCount: _count,
        gridDelegate: _sliverGridDelegate,
        itemBuilder: _builder,
        controller: controller,
      );
    }
  }
}
