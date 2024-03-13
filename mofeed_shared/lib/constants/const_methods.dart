import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

String idxToChar(int index) {
  if (index < 0 || index > 25) {
    throw Exception('Index must be between 0 and 25');
  }

  return String.fromCharCode(index + 65);
}

bool isPhoneNumber(String value) {
  RegExp phoneRegex = RegExp(r'^\+?[0-9]{6,}$');
  return phoneRegex.hasMatch(value);
}

bool isLink(String value) {
  RegExp urlRegex = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$');
  return urlRegex.hasMatch(value);
}

enum FlushBarState {
  done,
  error,
  alert;

  Color get color => switch (this) {
        FlushBarState.done => Colors.green,
        FlushBarState.error => Colors.red,
        FlushBarState.alert => Colors.black54,
      };

  IconData get icon => switch (this) {
        FlushBarState.done => Icons.done,
        FlushBarState.error => Icons.error_outline,
        FlushBarState.alert => Icons.info_outline,
      };
}

Future<List<XFile>> pickMultiImages({int max = 10}) async {
  final List<XFile> picked = [];

  final picker = ImagePicker();

  final toPick = await picker.pickMultiImage(imageQuality: 75);
  picked.addAll(toPick);
  return picked.take(max).toList();
}

Future<XFile?> pickImage() async {
  final picker = ImagePicker();
  return await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
}

const tempImage =
    "https://www.tastingtable.com/img/gallery/12-low-carb-fast-food-options-that-wont-ruin-your-diet/l-intro-1651501665.jpg";

bool isArabic(String text) {
  for (int i = 0; i < text.length; i++) {
    int charCode = text.codeUnitAt(i);
    if ((charCode >= 0x0600 && charCode <= 0x06FF) || // Arabic script
        (charCode >= 0xFB50 &&
            charCode <= 0xFDFF) || // Arabic Presentation Forms-A
        (charCode >= 0xFE70 && charCode <= 0xFEFF)) {
      return true;
    }
  }
  return false;
}

bool isEnglish(String text) {
  for (int i = 0; i < text.length; i++) {
    int charCode = text.codeUnitAt(i);
    if ((charCode >= 65 && charCode <= 90) || // Uppercase English letters
        (charCode >= 97 && charCode <= 122)) {
      // Lowercase English letters
      return true;
    }
  }
  return false;
}
