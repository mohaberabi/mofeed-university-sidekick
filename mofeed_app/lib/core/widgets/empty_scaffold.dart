import 'package:flutter/material.dart';

class EmptyScaffold extends StatelessWidget {
  final Widget child;

  const EmptyScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: child,
    );
  }
}
