import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mofeed_shared/model/app_media.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';

import '../../utils/enums/media_source.dart';
import '../colors/app_colors.dart';
import '../spacing/spacing.dart';
import 'cached_image.dart';

class AvatarWidget extends StatelessWidget {
  final double _radius;
  final bool _isImage;
  final MediaSource _source;
  final String _title;
  final Color? _circleColor;
  final TextStyle? _avatarStyle;
  final TextStyle? _leadingStyle;
  final String _leading;

  const AvatarWidget._({
    Key? key,
    double radius = 20.0,
    Color? textColor,
    bool isImage = false,
    MediaSource source = MediaSource.network,
    String title = '',
    TextStyle? leadingStyle,
    TextStyle? avatarStyle,
    Color? circleColor,
    String leading = '',
  })  : _source = source,
        _leading = leading,
        _title = title,
        _radius = radius,
        _avatarStyle = avatarStyle,
        _leadingStyle = leadingStyle,
        _isImage = isImage,
        _circleColor = circleColor,
        super(key: key);

  AvatarWidget.text({
    required String name,
    String? customTitle,
    Color? textColor,
    Color? circleColor,
    TextStyle? avatarStyle,
    double radius = 20,
    TextStyle? leadingStyle,
    Key? key,
  }) : this._(
          leadingStyle: leadingStyle,
          radius: radius,
          leading: customTitle ?? "",
          avatarStyle: avatarStyle,
          circleColor: circleColor,
          textColor: textColor,
          isImage: false,
          key: key,
          title: (name.isNotEmpty ? name[0].toUpperCase() : ""),
        );

  AvatarWidget.image({
    required AppMedia media,
    double radius = 20,
    String? customTitle,
    TextStyle? leadingStyle,
    Key? key,
  }) : this._(
          leadingStyle: leadingStyle,
          leading: customTitle ?? "",
          key: key,
          title: media.path,
          isImage: true,
          source: media.source,
          radius: radius,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: _radius.circle,
          child: _isImage
              ? image()
              : CircleAvatar(
                  radius: _radius,
                  backgroundColor: _circleColor ?? AppColors.primDark,
                  child: Text(_title,
                      style: _avatarStyle ??
                          context.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
        ),
        const SizedBox(width: AppSpacing.sm),
        if (_leading.isNotEmpty) Text(_leading, style: _leadingStyle)
      ],
    );
  }

  Widget image() {
    switch (_source) {
      case MediaSource.local:
        return ClipRRect(
            borderRadius: _radius.circle,
            child: Image.file(
              File(_title),
              width: _radius,
              fit: BoxFit.cover,
              height: _radius,
            ));

      case MediaSource.asset:
        return Image.asset(
          _title,
          width: _radius,
          height: _radius,
        );
      default:
        return CachedImage(
          imageUrl: _title,
          decorated: true,
          boxFit: BoxFit.fill,
          w: _radius,
          h: _radius,
          errorHolder: CircleAvatar(
            radius: _radius,
            backgroundColor: Colors.grey.withOpacity(0.3),
            child: const Icon(
              Icons.image,
              color: Colors.grey,
              size: 65,
            ),
          ),
        );
    }
  }
}
