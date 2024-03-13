import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:sakan/model/sakan_model.dart';

class StayingPeriodSakanView extends StatelessWidget {
  final Sakan sakan;

  const StayingPeriodSakanView({super.key, required this.sakan});

  @override
  Widget build(BuildContext context) {
    final period = sakan.billingPeriod.tr(context.lang);
    final local = context.l10n;
    return Column(
      children: [
        (AppIcons.min, local.minPeriod, sakan.minStay.toString()),
        (AppIcons.max, local.maxPeriod, sakan.maxStay.toString())
      ].map((e) {
        final leading = e.$1;
        final title = e.$2;
        final trailing = e.$3;
        return ListTile(
          subtitle: Text(period,
              style: context.bodyLarge.copyWith(color: Colors.grey)),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          titleTextStyle: context.bodyLarge.copyWith(fontSize: 16),
          leadingAndTrailingTextStyle: context.bodyLarge,
          horizontalTitleGap: 1,
          leading: AppIcon(leading),
          title: Text(title),
          trailing: Text(trailing),
        );
      }).toList(),
    );
  }
}
