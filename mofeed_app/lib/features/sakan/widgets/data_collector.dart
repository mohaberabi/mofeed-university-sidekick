import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';

class DataCollector extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const DataCollector({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: ListView(
        children: [
          Text(title,
              style:
                  context.headlineSmall.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: AppSpacing.lg),
          ...children,
        ],
      ),
    );
  }
}
