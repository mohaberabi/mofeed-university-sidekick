import 'package:flutter/services.dart';

abstract class InputFormaters {
  static final TextInputFormatter phoneLength =
      LengthLimitingTextInputFormatter(10);
  static final TextInputFormatter dayMonLength =
      LengthLimitingTextInputFormatter(2);
  static final TextInputFormatter yaerLength =
      LengthLimitingTextInputFormatter(4);
  static final TextInputFormatter cardLength =
      LengthLimitingTextInputFormatter(16);
  static final onlyNumbers =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  static final trimmed = FilteringTextInputFormatter.deny(RegExp('[ ]'));

  ///
  static final validDay =
      FilteringTextInputFormatter.allow(RegExp(r'^([1-9]|[12][0-9]|3[01])$'));

  ///
  static final validMonth =
      FilteringTextInputFormatter.allow(RegExp(r'^(0?[1-9]|1[0-2])$'));

  ///
  static final validYear =
      FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*$'));

  ///
  static final decimalNumber =
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));
  static final List<TextInputFormatter> carPlateStandard = [
    FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
    LengthLimitingTextInputFormatter(7),
    FilteringTextInputFormatter.deny(RegExp("[a-zA-Z-@.-]")),
    FilteringTextInputFormatter.deny(RegExp("[١,٢,٣,٤,٥,٦,٧,٨,٩,٠]")),
    FilteringTextInputFormatter.deny(RegExp("[!,@,#,%,^,&,*,(,),_,-,=,+,]")),
    FilteringTextInputFormatter.deny(RegExp("[?,/,>,.,<,',;,:,},{,]")),
  ];
}
