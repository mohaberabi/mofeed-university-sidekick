import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';

class CustomFileImage extends StatelessWidget {
  final VoidCallback? onTap;

  final VoidCallback? onDelete;
  final double w;

  final double h;

  final double borderRadius;

  final File file;

  const CustomFileImage({
    super.key,
    required this.file,
    this.onTap,
    this.borderRadius = 12,
    this.onDelete,
    this.h = 155,
    this.w = 155,
  });

  CustomFileImage.fromPath({
    Key? key,
    VoidCallback? onTap,
    VoidCallback? ondDelete,
    double w = 155,
    double h = 155,
    double bordeRadius = 12,
    required String path,
  }) : this(
          key: key,
          w: w,
          h: h,
          onTap: onTap,
          onDelete: ondDelete,
          borderRadius: bordeRadius,
          file: File(path),
        );

  CustomFileImage.fromXfile({
    Key? key,
    VoidCallback? onTap,
    VoidCallback? ondDelete,
    double w = 155,
    double h = 155,
    double bordeRadius = 12,
    required XFile xFile,
  }) : this(
          key: key,
          w: w,
          h: h,
          onTap: onTap,
          onDelete: ondDelete,
          borderRadius: bordeRadius,
          file: xFile.toFile,
        );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: borderRadius.circle,
            child: Image.file(
              file,
              width: w,
              height: h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (onDelete != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: onDelete,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.black87,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          )
      ],
    );
  }
}
