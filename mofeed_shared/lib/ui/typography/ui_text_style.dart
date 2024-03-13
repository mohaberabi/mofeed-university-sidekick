import 'package:flutter/material.dart';

import 'app_font_weight.dart';

abstract class UiTextStyle {
  static const englishFontName = "Lota";
  static const arabicFontName = "Almarai";
  static const packageName = "mofeed_shared";

  const UiTextStyle();

  static const _baseTextStyle = TextStyle(
    package: packageName,
    fontWeight: AppFontWeight.regular,
    fontFamily: englishFontName,
    decoration: TextDecoration.none,
    textBaseline: TextBaseline.alphabetic,
  );

  static final displayLarge = _baseTextStyle.copyWith(
      fontSize: 36, fontWeight: FontWeight.bold, height: 1.22);

  static final displayMedium = _baseTextStyle.copyWith(
      fontSize: 32, fontWeight: FontWeight.bold, height: 1.25);

  static final displaySmall = _baseTextStyle.copyWith(
      fontSize: 28, fontWeight: FontWeight.bold, height: 1.28);

  static final headlineLarge = _baseTextStyle.copyWith(
      fontSize: 24, fontWeight: FontWeight.bold, height: 1.25);

  static final headlineMedium = _baseTextStyle.copyWith(
      fontSize: 22, fontWeight: FontWeight.bold, height: 1.27);

  static final headlineSmall = _baseTextStyle.copyWith(
      fontSize: 20, fontWeight: FontWeight.bold, height: 1.33);

  static final titleLarge = _baseTextStyle.copyWith(
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.1);

  static final titleMedium = _baseTextStyle.copyWith(
      fontSize: 14,
      height: 1.42,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.1);

  static final titleSmall = _baseTextStyle.copyWith(
      fontSize: 14,
      height: 1.42,
      letterSpacing: 0.1,
      fontWeight: FontWeight.bold);

  static final bodyLarge = _baseTextStyle.copyWith(
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.5,
    fontWeight: FontWeight.normal,
  );

  static final bodyMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.25,
    fontWeight: FontWeight.normal,
  );

  static final bodySmall = _baseTextStyle.copyWith(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
    fontWeight: FontWeight.normal,
  );

  static final button = _baseTextStyle.copyWith(
    fontSize: 16,
    height: 1.42,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w600,
  );
}
