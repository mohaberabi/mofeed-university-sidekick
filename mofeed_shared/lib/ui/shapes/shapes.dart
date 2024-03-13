import 'package:flutter/material.dart';

import '../spacing/spacing.dart';

extension Shapes on num {
  BorderRadius get circle => BorderRadius.circular(toDouble());
}

extension AppBorders on ThemeData {
  OutlinedBorder get primaryOutlineBorder => RoundedRectangleBorder(
      borderRadius: AppSpacing.sm.circle,
      side: BorderSide(color: dividerColor, width: 1.5));
}
