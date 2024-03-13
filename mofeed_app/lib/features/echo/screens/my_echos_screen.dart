import 'package:flutter/material.dart';
import 'package:mofeduserpp/features/echo/widgets/echo_builder.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class MyEchosScreen extends StatelessWidget {
  const MyEchosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.echo)),
      body: const EchoBuilder(getMine: true),
    );
  }
}
