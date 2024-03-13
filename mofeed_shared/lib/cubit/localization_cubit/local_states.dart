import 'package:flutter/material.dart';

abstract class LocalizationState {
  const LocalizationState();
}

class LocalInitState extends LocalizationState {
  const LocalInitState();
}

class ChangeLocalState extends LocalizationState {
  final Locale locale;

  const ChangeLocalState({required this.locale});
}
