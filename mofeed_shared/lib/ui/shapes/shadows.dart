import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppShadows {
  static const List<BoxShadow> light = [
    BoxShadow(blurRadius: 8, spreadRadius: 4),
  ];

  static const defaultLinear = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black],
  );
}
