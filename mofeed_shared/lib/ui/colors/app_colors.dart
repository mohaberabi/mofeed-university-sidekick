import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primDark = Color(0xFF00493F);
  static const Color primColor = Color(0xFF3AB44D);
  static const Color primLight = Color(0xFFEBE8FC);
  static const Color lightGreyDark = Color(0xFF303030);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color secondColor = Color(0xFF00493F);
  static const Color shadow = Color(0xFFD3D3D3);
  static const Color lightDark = Color(0xFF1E1E1E);
  static const Color darkBg = Color(0xFF121212);
  static const Color disabledButton = Color(0xFFCCCCCC);

  static const MaterialColor primMaterial = MaterialColor(
    0xFF3AB44D,
    <int, Color>{
      50: Color(0xFFE0F6E5),
      100: Color(0xFFB3E9C8),
      200: Color(0xFF80DCAA),
      300: Color(0xFF4DC18C),
      400: Color(0xFF26B077),
      500: Color(0xFF3AB44D),
      600: Color(0xFF338F3B),
      700: Color(0xFF2C8335),
      800: Color(0xFF24782E),
      900: Color(0xFF145F20),
    },
  );
}
