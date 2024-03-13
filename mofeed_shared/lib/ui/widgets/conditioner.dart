import 'package:flutter/cupertino.dart';

class Conditioner extends StatelessWidget {
  final bool condition;

  final Widget Function(bool) builder;

  const Conditioner(
      {super.key, required this.condition, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(condition);
  }
}
