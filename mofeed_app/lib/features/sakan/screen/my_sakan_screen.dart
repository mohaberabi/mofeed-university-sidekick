import 'package:flutter/material.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import '../widgets/sakan_builder.dart';

class MySakanScreen extends StatelessWidget {
  const MySakanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.sakan)),
      body: const SakanBuilder(getMine: true),
    );
  }
}
