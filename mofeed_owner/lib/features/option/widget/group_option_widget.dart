import 'package:flutter/material.dart';
import 'package:food_court/model/option_group.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/utils/style/app_colors.dart';

class GroupOptionWidget extends StatelessWidget {
  final OptionGroup option;
  final void Function(OptionGroup)? onTap;
  final bool selectable;
  final bool Function(OptionGroup)? selected;

  final void Function(OptionGroup)? onSelect;

  const GroupOptionWidget({
    super.key,
    required this.option,
    this.onTap,
    this.selectable = false,
    this.selected,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          if (selectable)
            GestureDetector(
              onTap: () {
                if (onSelect != null) {
                  onSelect!(option);
                }
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected != null && selected!(option)
                      ? AppColors.primColor
                      : Colors.transparent,
                  border: Border.all(
                    color: selected != null && selected!(option)
                        ? Colors.transparent
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          Expanded(
            child: ListTile(
              onTap: () {
                if (onTap != null) {
                  onTap!(option);
                }
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              titleTextStyle: context.titleLarge,
              subtitleTextStyle: context.bodyLarge,
              title: Text(option.name[context.lang]),
              trailing: Text(
                '${option.children.length} Options',
                style: context.bodyLarge,
              ),
              subtitle: Row(
                children: [
                  Text("Min : ${option.min}"),
                  8.width,
                  Text("Max : ${option.max}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
