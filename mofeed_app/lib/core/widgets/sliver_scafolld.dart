import 'package:flutter/material.dart';
import 'package:mofeduserpp/core/const/const_widgets.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';

class SliverScaffold extends StatefulWidget {
  final Widget? title;
  final Widget? collapsedWidget;
  final Widget? body;
  final double expandedHeight;
  final double collapsedWidgetHeight;
  final List<Widget> innerSrollables;
  final Widget? bootomNavBar;
  final Widget Function(bool)? listenable;
  final Widget? leading;
  final List<Widget>? actions;

  final Color? appBarColor;

  final Color? backgroundColor;

  final Widget? background;

  const SliverScaffold({
    super.key,
    this.title,
    this.collapsedWidget,
    this.body,
    this.expandedHeight = 200,
    this.collapsedWidgetHeight = 50,
    this.background,
    this.innerSrollables = const [],
    this.bootomNavBar,
    this.listenable,
    this.leading,
    this.backgroundColor,
    this.appBarColor,
    this.actions,
  });

  @override
  State<SliverScaffold> createState() => _SliverScaffoldState();
}

class _SliverScaffoldState extends State<SliverScaffold> {
  late ScrollController scrollController;
  late ValueNotifier<bool> showMetaWidgets;

  @override
  void initState() {
    showMetaWidgets = ValueNotifier(false);
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset >= widget.expandedHeight) {
          showMetaWidgets.value = true;
        } else {
          showMetaWidgets.value = false;
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    showMetaWidgets.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeFromHeight =
        widget.collapsedWidget == null ? 0.0 : widget.collapsedWidgetHeight;
    final perefedSizeChild = widget.collapsedWidget ?? const SizedBox();
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      bottomNavigationBar: widget.bootomNavBar,
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          headerSliverBuilder: (context, innerScrolled) {
            return [
              ValueListenableBuilder(
                valueListenable: showMetaWidgets,
                builder: (context, value, child) {
                  return SliverAppBar(
                    toolbarHeight: context.height * 0.08,
                    actions: widget.actions,
                    leadingWidth: context.width * 0.15,
                    backgroundColor: widget.appBarColor,
                    leading: widget.leading ??
                        const AppBackBtn(background: Colors.white),
                    title: value && widget.title != null ? widget.title : null,
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(sizeFromHeight),
                        child: widget.collapsedWidget != null && value
                            ? perefedSizeChild
                            : const SizedBox()),
                    pinned: true,
                    expandedHeight: widget.expandedHeight,
                    flexibleSpace: widget.background != null
                        ? FlexibleSpaceBar(background: widget.background!)
                        : null,
                  );
                },
              ),
              ...widget.innerSrollables
            ];
          },
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.collapsedWidget != null)
                ValueListenableBuilder(
                    valueListenable: showMetaWidgets,
                    builder: (context, value, child) {
                      if (value == false) {
                        return widget.collapsedWidget!;
                      }
                      return const SizedBox();
                    }),
              if (widget.listenable != null)
                ValueListenableBuilder(
                    valueListenable: showMetaWidgets,
                    builder: (context, value, child) {
                      return widget.listenable!(value);
                    }),
              if (widget.body != null) Expanded(child: widget.body!),
            ],
          )),
    );
  }
}
