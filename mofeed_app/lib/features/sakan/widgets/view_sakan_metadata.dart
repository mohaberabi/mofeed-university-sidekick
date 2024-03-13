import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/read_more.dart';
import 'package:mofeed_shared/ui/widgets/text_icon.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:sakan/model/sakan_model.dart';

class ViewSakanMetaData extends StatelessWidget {
  final Sakan sakan;

  const ViewSakanMetaData({
    super.key,
    required this.sakan,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const iconFirst = true;
    const align = MainAxisAlignment.spaceBetween;
    final style = context.bodyLarge;
    const size = 22.0;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextIcon.svg(
            iconFirst: iconFirst,
            mainAxisAlignment: align,
            text: sakan.gender.tr(context.lang),
            path: sakan.gender.icon,
            size: size,
            style: style,
          ),
          TextIcon.svg(
            iconFirst: iconFirst,
            mainAxisAlignment: align,
            text: sakan.religion.tr(context.lang),
            path: sakan.religion.icon,
            size: size,
            style: style,
          ),
          TextIcon.svg(
            iconFirst: iconFirst,
            mainAxisAlignment: align,
            text: sakan.smoking.tr(context.lang),
            path: sakan.smoking.icon,
            size: size,
            style: style,
          ),
          TextIcon.svg(
            iconFirst: iconFirst,
            mainAxisAlignment: align,
            text: sakan.pet.tr(context.lang),
            path: sakan.pet.icon,
            size: size,
            style: style,
          ),
          if (sakan.bio.isNotEmpty)
            Text(l10n.aboutMe, style: context.headlineSmall),
          if (sakan.bio.isNotEmpty) ReadMore(sakan.bio),
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: e,
                ))
            .toList());
  }
}
