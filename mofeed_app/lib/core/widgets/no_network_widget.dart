import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class NoNetWorkWidget extends StatelessWidget {
  const NoNetWorkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
      alignment: Alignment.bottomCenter,
      color: Colors.red,
      height: context.height * 0.1,
      child: Row(
        children: [
          const Icon(Icons.network_check_outlined, color: Colors.white),
          const SizedBox(width: AppSpacing.sm),
          Text(
            l10n.noNetWork,
            style: context.titleLarge.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
