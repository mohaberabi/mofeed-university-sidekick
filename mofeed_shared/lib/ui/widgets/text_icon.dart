import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import '../spacing/spacing.dart';

class TextIcon extends StatelessWidget {
  final String _text;
  final Widget _icon;
  final TextStyle? _style;
  final bool _iconFirst;
  final EdgeInsets _padding;
  final VoidCallback? _onTap;
  final bool _columed;
  final MainAxisAlignment _mainAxisAlignment;

  const TextIcon._({
    super.key,
    required String text,
    required Widget icon,
    bool iconFirst = false,
    TextStyle? style,
    VoidCallback? onTap,
    EdgeInsets padding = const EdgeInsets.all(4),
    bool columed = false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
  })  : _text = text,
        _style = style,
        _iconFirst = iconFirst,
        _padding = padding,
        _onTap = onTap,
        _columed = columed,
        _mainAxisAlignment = mainAxisAlignment,
        _icon = icon;

  TextIcon.iconData({
    required String text,
    required IconData icon,
    TextStyle? style,
    Color? color,
    double? size,
    bool iconFirst = false,
    EdgeInsets padding = const EdgeInsets.all(4),
    VoidCallback? onTap,
    bool columed = false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    Key? key,
  }) : this._(
          iconFirst: iconFirst,
          columed: columed,
          key: key,
          text: text,
          padding: padding,
          onTap: onTap,
          mainAxisAlignment: mainAxisAlignment,
          icon: Icon(
            icon,
            color: color,
            size: size,
          ),
          style: style,
        );

  const TextIcon.custom({
    required String text,
    required Widget icon,
    TextStyle? style,
    bool iconFirst = false,
    EdgeInsets padding = const EdgeInsets.all(4),
    VoidCallback? onTap,
    bool columed = false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    Key? key,
  }) : this._(
            iconFirst: iconFirst,
            key: key,
            onTap: onTap,
            text: text,
            padding: padding,
            mainAxisAlignment: mainAxisAlignment,
            icon: icon,
            style: style,
            columed: columed);

  TextIcon.svg({
    required String text,
    TextStyle? style,
    required String path,
    Key? key,
    Color? color,
    double? size,
    bool iconFirst = false,
    EdgeInsets padding = const EdgeInsets.all(4),
    VoidCallback? onTap,
    bool columed = false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
  }) : this._(
          columed: columed,
          onTap: onTap,
          iconFirst: iconFirst,
          key: key,
          text: text,
          padding: padding,
          mainAxisAlignment: mainAxisAlignment,
          icon: AppIcon(
            path,
            color: color,
            size: size ?? 22,
          ),
          style: style,
        );

  @override
  Widget build(BuildContext context) {
    final children = !_iconFirst
        ? [
            Text(
              _text,
              style: _style ?? context.bodyLarge,
              maxLines: 3,
            ),
            const SizedBox(width: AppSpacing.sm),
            _icon,
          ]
        : [
            _icon,
            const SizedBox(width: AppSpacing.sm),
            Text(
              _text,
              style: _style ?? context.bodyLarge,
              maxLines: 3,
            ),
          ];
    return Padding(
      padding: _padding,
      child: GestureDetector(
        onTap: _onTap,
        child: _columed
            ? Column(
                mainAxisAlignment: _mainAxisAlignment,
                children: children,
                mainAxisSize: MainAxisSize.min,
              )
            : Row(
                mainAxisAlignment: _mainAxisAlignment,
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
      ),
    );
  }
}
