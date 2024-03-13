import 'package:flutter/material.dart';

abstract class ContentTextStyle {
  static const _baseTextStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    decoration: TextDecoration.none,
    textBaseline: TextBaseline.alphabetic,
  );

  static const primary = _baseTextStyle;
}
