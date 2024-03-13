import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get bottom => MediaQuery.of(this).viewInsets.bottom;

  double get topPadding => MediaQuery.of(this).viewInsets.top;

  double get bottomPadding => MediaQuery.of(this).viewInsets.bottom;
}
extension Filer on XFile {
  File get toFile => File(path);
}
