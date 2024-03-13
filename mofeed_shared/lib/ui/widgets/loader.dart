import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final bool centered;

  const Loader({
    Key? key,
    this.centered = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return centered
        ? const Center(child: CircularProgressIndicator.adaptive())
        : const CircularProgressIndicator.adaptive();
  }
}
