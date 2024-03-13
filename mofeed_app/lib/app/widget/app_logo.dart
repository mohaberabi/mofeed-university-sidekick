import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';

class AppLogo extends StatelessWidget {
  final double size;

  final Color color;

  const AppLogo({
    super.key,
    this.color = Colors.white,
    this.size = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppIcon(AppIcons.logo, size: size, color: color);
  }
}
