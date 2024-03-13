import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/features/gallery/cubit/gallery_cubit.dart';
import 'package:mofeed_owner/features/gallery/cubit/gallery_state.dart';
import 'package:mofeed_owner/shared/router/app_routes.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/widgets/app_view_builder.dart';
import 'package:mofeed_shared/widgets/cached_image.dart';
import 'package:mofeed_shared/widgets/loader.dart';
import 'package:mofeed_shared/widgets/my_place_holder.dart';

import '../../../shared/sl/service_locator.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  navigateTo(context, routeName: Routes.addGallery),
              icon: Icon(Icons.add)),
        ],
        title: Text("Gallery"),
      ),
      body: const GalleryBuilder(),
    );
  }
}

class GalleryBuilder extends StatefulWidget {
  final void Function(String)? onTap;

  const GalleryBuilder({
    super.key,
    this.onTap,
  });

  @override
  State<GalleryBuilder> createState() => _GalleryBuilderState();
}

class _GalleryBuilderState extends State<GalleryBuilder> {
  late GalleryCubit galleryCubit;

  @override
  void initState() {
    galleryCubit = sl<GalleryCubit>()..getGallery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryCubit, GalleryState>(builder: (context, state) {
      return state.state.builder(
          onLoading: () => const Loader(),
          onError: () => AppPlaceHolder.error(onTap: () {}),
          onDone: () {
            return AppViewBuilder.grid(
                onRefresh: () async => galleryCubit.getGallery(),
                padding: const EdgeInsets.all(8),
                sliverGridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                builder: (context, index) {
                  final gallery = state.gallery[index];
                  return GestureDetector(
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!(gallery.url);
                      }
                    },
                    child: CachedImage(
                        radius: 8,
                        imageUrl: gallery.url,
                        decorated: true,
                        boxFit: BoxFit.cover),
                  );
                },
                count: state.gallery.length,
                placeHolder: Text("No gallery "));
          });
    });
  }
}
