import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class EchoAsker extends StatelessWidget {
  final bool enabled;
  final void Function(bool) onChanged;

  const EchoAsker({super.key, required this.enabled, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    return SwitchListTile.adaptive(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      subtitle: enabled ? Text("Colleagues can chat with you") : null,
      title: Text("Allow colleagues to chat with me"),
      value: enabled,
      onChanged: onChanged,
    );
  }
}
