import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import '../colors/app_colors.dart';

enum ChipBuilderShape {
  tile,
  chip,
}

class ChipBuilder<T> extends StatelessWidget {
  final Widget? Function(T)? avatar;
  final bool Function(T) selected;
  final void Function(T) onTap;
  final String Function(T) title;
  final String? header;
  final TextStyle? headerStyle;

  final List<T> items;
  final double runSpacing;
  final OutlinedBorder? shape;
  final double spacing;
  final ChipBuilderShape chipBuilderShape;
  final String? footer;

  const ChipBuilder({
    super.key,
    this.avatar,
    required this.items,
    required this.selected,
    required this.title,
    required this.onTap,
    this.header,
    this.runSpacing = 8,
    this.headerStyle,
    this.shape,
    this.spacing = 8,
    this.chipBuilderShape = ChipBuilderShape.chip,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                header!,
                style: headerStyle ?? context.headlineMedium,
              ),
            ),
          Wrap(
            spacing: spacing,
            runSpacing: runSpacing,
            children: items.map((e) {
              if (chipBuilderShape == ChipBuilderShape.chip) {
                return ActionChip(
                  backgroundColor: selected(e)
                      ? AppColors.primColor
                      : context.theme.scaffoldBackgroundColor,
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: selected(e) ? Colors.transparent : Colors.grey,
                    ),
                  ),
                  onPressed: () => onTap(e),
                  avatar: avatar != null
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              selected(e) ? Colors.white : Colors.grey,
                              BlendMode.srcIn),
                          child: avatar!(e) ?? const SizedBox(),
                        )
                      : null,
                  label: Text(
                    title(e),
                    style: context.bodyLarge.copyWith(
                        color: selected(e) ? Colors.white : Colors.grey),
                  ),
                  padding: EdgeInsets.all(selected(e) ? 12 : 8),
                  labelStyle: context.button
                      .copyWith(color: selected(e) ? null : Colors.black),
                );
              } else {
                return ListTile(
                  onTap: () => onTap(e),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  titleTextStyle: context.bodyLarge
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  shape: context.theme.primaryOutlineBorder.copyWith(
                      side: selected(e)
                          ? const BorderSide(
                              color: AppColors.primColor, width: 2)
                          : null),
                  title: Text(title(e)),
                );
              }
            }).toList(),
          ),
        ],
      ),
    );
  }
}
