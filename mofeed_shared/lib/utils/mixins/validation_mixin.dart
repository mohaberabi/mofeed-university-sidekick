import 'package:flutter/material.dart';

import '../error/error_codes.dart';

mixin ValidationMixin {
  String? validateDefault(String? input) {
    if (input != null && input
        .trim()
        .isEmpty) {
      return ErrorCodes.required;
    }
    return null;
  }

  String? validateTrimmed(String? input) {
    if (input != null) {
      if (input.characters.isNotEmpty) {
        if (input.characters.first == ' ' || input.characters.last == ' ') {
          return ErrorCodes.invalidTextFromat;
        }
      }
    }
    return null;
  }

  String validateMinLength(int length, String input) {
    if (input.length >= 50) {
      return "";
    } else {
      return ErrorCodes.inputVeryShort50;
    }
  }

  String? validateEmailNoDomain(String? input) {
    if (input == null) {
      return ErrorCodes.invalidEmail;
    } else if (validateEmail(input) == null) {
      return ErrorCodes.noDomainNeededEmail;
    } else {
      return null;
    }
  }

  String? validatePhone(String? input) {
    if (input == null) {
      return ErrorCodes.wrongPhone;
    } else if (!input.trim().startsWith('1') || input
        .trim()
        .length < 10) {
      return ErrorCodes.wrongPhone;
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null) {
      return ErrorCodes.invalidEmail;
    } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return ErrorCodes.invalidEmail;
    } else {
      return null;
    }
  }

  String? validatePassword(String? input) {
    if (input == null) {
      return ErrorCodes.required;
    } else if (input
        .trim()
        .isEmpty) {
      return ErrorCodes.required;
    } else if (input
        .trim()
        .length < 6) {
      return ErrorCodes.sixCharPass;
    }
    return null;
  }
}
