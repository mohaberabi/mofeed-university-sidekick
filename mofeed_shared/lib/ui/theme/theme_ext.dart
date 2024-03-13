import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../spacing/spacing.dart';

extension CustomThemeData on ThemeData {
  Color get shimmerBaseColor => brightness == Brightness.light
      ? lightShimmerBaseColor
      : darkShimmerBaseColor;

  Color get secondaryBgColor => brightness == Brightness.light
      ? Colors.grey.shade200
      : scaffoldBackgroundColor;

  BoxDecoration get primaryDecoration => BoxDecoration(
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      border: Border.all(color: dividerColor));

  Color get recievedMessageColor =>
      isDark ? darkShimmerHighlightColor : lightShimmerBaseColor;

  Color get shimmerHighlightColor => brightness == Brightness.light
      ? lightShimmerHighlightColor
      : darkShimmerHighlightColor;

  bool get isDark => brightness == Brightness.dark;

  IconData get modeIcon =>
      isDark ? Icons.light_mode_rounded : Icons.dark_mode_outlined;

  ThemeMode get toOther => isDark ? ThemeMode.light : ThemeMode.dark;
}

const Color lightShimmerBaseColor = AppColors.shadow;
const Color lightShimmerHighlightColor = Color(0xFFFFFFFF);

const Color darkShimmerBaseColor = Color(0xFF292929);
const Color darkShimmerHighlightColor = Color(0xFF3C3C3C);
