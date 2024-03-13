import 'package:flutter/material.dart';

import 'loader.dart';

class PaginationBuilder extends StatefulWidget {
  final Widget Function(ScrollController) builder;
  final Future<void> Function() onMax;

  const PaginationBuilder({
    super.key,
    required this.builder,
    required this.onMax,
  });

  @override
  State<PaginationBuilder> createState() => _PaginationBuilderState();
}

class _PaginationBuilderState extends State<PaginationBuilder> {
  late ScrollController scrollController;
  late ValueNotifier<bool> isLoading;

  @override
  void initState() {
    isLoading = ValueNotifier(false);
    scrollController = ScrollController()
      ..addListener(
        () {
          if (scrollController.offset >=
                  scrollController.position.maxScrollExtent &&
              !scrollController.position.outOfRange) {
            isLoading.value = true;
            widget.onMax().whenComplete(
              () {
                isLoading.value = false;
              },
            ).onError((error, stackTrace) => isLoading.value = false);
          }
        },
      );
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        widget.builder(scrollController),
        ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, child) {
              return value
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 22),
                      child: Loader(centered: false))
                  : const SizedBox();
            })
      ],
    );
  }
}
