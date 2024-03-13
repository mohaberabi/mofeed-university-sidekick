import 'package:flutter/material.dart';
import 'package:mofeed_shared/model/university_model.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/cached_image.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class UniversityWidget extends StatelessWidget {
  final String leading;

  final MapJson title;

  final String trailing;

  final VoidCallback? onTap;
  final bool selected;

  const UniversityWidget({
    super.key,
    required this.leading,
    this.onTap,
    required this.title,
    required this.trailing,
    this.selected = false,
  });

  UniversityWidget.fromUni({
    Key? key,
    required UniversityModel university,
    bool selected = false,
    VoidCallback? onTap,
  }) : this(
          key: key,
          onTap: onTap,
          selected: selected,
          title: university.name,
          leading: university.logo,
          trailing: university.abreviation,
        );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(AppSpacing.sm),
      onTap: onTap,
      shape: selected
          ? context.theme.primaryOutlineBorder
              .copyWith(side: const BorderSide(color: AppColors.primColor))
          : null,
      titleTextStyle: context.titleLarge,
      horizontalTitleGap: AppSpacing.md,
      leading: CachedImage(
          imageUrl: leading,
          decorated: true,
          boxFit: BoxFit.cover,
          h: 50,
          w: 50),
      title: Text(title[context.lang]),
      trailing: Text(trailing, style: context.bodyLarge),
    );
  }
}
