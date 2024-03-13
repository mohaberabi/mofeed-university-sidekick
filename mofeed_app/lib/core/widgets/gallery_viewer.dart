import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryViewer extends StatelessWidget {
  final List<String> images;

  const GalleryViewer({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
              color: Colors.black,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(images[index]),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
                  );
                },
                itemCount: images.length,
                loadingBuilder: (context, event) => Center(
                  child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              (event.expectedTotalBytes == null
                                  ? 1
                                  : event.expectedTotalBytes!.toInt())),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.xxxlg, horizontal: AppSpacing.lg),
            child: CircleAvatar(
              backgroundColor: Colors.black87,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
