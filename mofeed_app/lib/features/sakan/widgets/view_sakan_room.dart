import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/text_icon.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:sakan/model/mate_wanted.dart';

class MateWantedInfo extends StatelessWidget {
  final MateWanted mateWanted;

  const MateWantedInfo({super.key, required this.mateWanted});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const iconFirst = true;

    const align = MainAxisAlignment.spaceBetween;
    const padding = EdgeInsets.all(AppSpacing.md);
    final style = context.bodyLarge.copyWith(fontSize: AppSpacing.lg);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l10n.moreInfo, style: context.headlineMedium),
      TextIcon.svg(
        iconFirst: iconFirst,
        mainAxisAlignment: align,
        text: "${mateWanted.metres} ${l10n.metres}",
        path: AppIcons.area,
        size: 26,
        padding: padding,
        style: style,
      ),
      TextIcon.svg(
        iconFirst: iconFirst,
        mainAxisAlignment: align,
        text: "${l10n.floor} ${mateWanted.floor}",
        path: AppIcons.home,
        size: 26,
        style: style,
        padding: padding,
      ),
      TextIcon.svg(
        iconFirst: iconFirst,
        mainAxisAlignment: align,
        text:
            "${l10n.nearestServices} ${mateWanted.nearestServices} ${l10n.km}",
        path: AppIcons.service,
        size: 26,
        style: style,
        padding: padding,
      ),
    ]);
  }
}
